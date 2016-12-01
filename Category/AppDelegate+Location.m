//
//  AppDelegate+Location.m
//  HappyBuy
//
//  Created by tarena on 16/4/1.
//  Copyright © 2016年 tedu. All rights reserved.
//
/*
 分类 和 继承的区别: 官方:分类不能够添加属性
 */

#import "AppDelegate+Location.h"
//使用runtime来让分类也能够添加属性
#import <objc/runtime.h>

@implementation AppDelegate (Location)

- (void)setLocationManager:(CLLocationManager *)locationManager{
    //@selector(locationManager) -> 本质就是个指针地址
    //绑定了指针地址和locationManager变量
    return objc_setAssociatedObject(self, @selector(locationManager), locationManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CLLocationManager *)locationManager{
    //_cmd 当前方法的指针
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setupLocation{
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    //此方法只有iOS8以后才有
    //respondsToSelector:返回值是BOOL, 真就代表有某个方法
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    //开启定位服务: 注意iOS8之后的特点
    [self.locationManager startUpdatingLocation];
    //设置初始城市
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (!kCurrentCity) {
            [[NSUserDefaults standardUserDefaults] setObject:@"西安" forKey:kCurrentCityName];
            [[NSUserDefaults standardUserDefaults] synchronize];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kCurrentCityChangedNotification object:nil];
            });
        }
    });
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    //locations[0] 如果数组是空, 那么会crash,数组越界
    CLLocation *location = locations.firstObject;
    if (location) {
        manager.delegate = nil;
        [manager stopUpdatingLocation];
        //反地理编码: 经纬度->人类明白的信息
        [[CLGeocoder new] reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *placemark = placemarks.firstObject;
            NSString *localCity = placemark.locality;
            localCity = [localCity stringByReplacingOccurrencesOfString:@"市" withString:@""];
            NSLog(@"%@", localCity);
            //排除掉非联网状态时, 无法反地理编码得到城市名称问题.
            if (![kCurrentCity isEqualToString:localCity] && localCity!= nil) {
                //BlocksKit第三方的优化
                NSString *message = [NSString stringWithFormat:@"当前城市发生变化,是否要切换到'%@'?", localCity];
                [UIAlertView bk_showAlertViewWithTitle:@"切换城市" message:message cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    if (buttonIndex == 1) {
                        //1.保存新的城市名称到UserDefaults
                        //2.同步到沙盒
                        //3.发送城市变更通知
                        [[NSUserDefaults standardUserDefaults] setObject:localCity forKey:kCurrentCityName];
                        //命令立刻把内存中的plist存入沙盒
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        //发送全局通知
                        [[NSNotificationCenter defaultCenter] postNotificationName:kCurrentCityChangedNotification object:nil];
                    }
                }];
            }
        }];
    }
}


@end









