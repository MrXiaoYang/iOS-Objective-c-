//
//  NHMainTabbarViewController.m
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHMainTabbarViewController.h"
#import "NHBaseNavigationViewController.h"
#import "NHHomeViewController.h"
#import "NHDiscoverViewController.h"
#import "NHCheckViewController.h"
#import "NHMessageViewController.h"
#import "NHServiceListRequest.h"
#import "NHServiceListModel.h"

@implementation NHMainTabbarViewController

+ (void)initialize {
    
    // 设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色
    [UITabBar appearance].barTintColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, 1.5);
    
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.62f green:0.62f blue:0.63f alpha:1.00f];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllerWithClassname:[NHHomeViewController description] imagename:@"home" title:@"首页"];
    [self addChildViewControllerWithClassname:[NHDiscoverViewController description] imagename:@"Found" title:@"发现"];
    [self addChildViewControllerWithClassname:[NHCheckViewController description]imagename:@"audit" title:@"审核"];
    [self addChildViewControllerWithClassname:[NHMessageViewController description] imagename:@"newstab" title:@"消息"];
    
    NHServiceListRequest *request = [NHServiceListRequest nh_request];
    request.nh_url = kNHHomeServiceListAPI;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            NHBaseNavigationViewController *homeNav = (NHBaseNavigationViewController *)self.viewControllers.firstObject;
            NHHomeViewController *home = (NHHomeViewController *)homeNav.viewControllers.firstObject;
            home.models = [NHServiceListModel modelArrayWithDictArray:response];
        }
    }];
}

// 添加子控制器
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                                      title:(NSString *)title {
    
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    NHBaseNavigationViewController *nav = [[NHBaseNavigationViewController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imagename];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_press"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}
@end
