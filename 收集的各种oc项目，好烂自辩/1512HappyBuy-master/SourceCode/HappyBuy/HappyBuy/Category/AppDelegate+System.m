//
//  AppDelegate+System.m
//  TRProject
//
//  Created by jiyingxin on 16/2/25.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "AppDelegate+System.h"
#import <MLTransition.h>

@implementation AppDelegate (System)

#pragma mark - 方法
- (void)setupGlobalConfig{
    //电池条显示菊花,监测网络活动
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //网络状态监测
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //自定义左上角返回按钮, 导致右划返回失效
    [MLTransition validatePanBackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypeScreenEdgePan];
    
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    [self configGlobalUI];
}

//对UI进行统一的配置
- (void)configGlobalUI{
    self.window.tintColor = kRGBColor(227, 59, 65, 1.0);

    [[UINavigationBar appearance] setBarTintColor:kRGBColor(233, 82, 84, 1.0)];
    [UIBarButtonItem appearance].tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]}];
}

#pragma mark - 懒加载
- (AFNetworkReachabilityStatus)netReachStatus{
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

- (BOOL)isOnLine{
    switch (self.netReachStatus) {
        case AFNetworkReachabilityStatusUnknown:
        case AFNetworkReachabilityStatusNotReachable: {
            return NO;
            break;
        }
        case AFNetworkReachabilityStatusReachableViaWWAN:
        case AFNetworkReachabilityStatusReachableViaWiFi: {
            return YES;
            break;
        }
    }
}

#pragma mark - 生命周期
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}
@end
