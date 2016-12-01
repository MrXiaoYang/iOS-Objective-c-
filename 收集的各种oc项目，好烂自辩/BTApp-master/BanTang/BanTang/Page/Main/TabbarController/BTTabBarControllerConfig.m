//
//  BTTabBarControllerConfig.m
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTTabBarControllerConfig.h"
#import "BTHomeVC.h"
#import "BTCommunityVC.h"
#import "BTMessageVC.h"
#import "BTProfileVC.h"
#import "BTNavigationController.h"
#import "BTHomePushTransitionVC.h"
@interface BTTabBarControllerConfig ()

@property (nonatomic, readwrite, strong) BTTabBarController *tabBarController;

@end

@implementation BTTabBarControllerConfig


- (BTTabBarController *)tabBarController
{
    if (!_tabBarController) {
        BTHomePushTransitionVC *homeVC = [[BTHomePushTransitionVC alloc] init];
        homeVC.title = @"首页";
        BTNavigationController *firstNavigationController = [[BTNavigationController alloc]
                                                             initWithRootViewController:homeVC];
        
        BTCommunityVC *communityVC = [[BTCommunityVC alloc] init];
        communityVC.title = @"发现";
        BTNavigationController *secondNavigationController = [[BTNavigationController alloc]
                                                              initWithRootViewController:communityVC];
        
        BTMessageVC *searchVC = [[BTMessageVC alloc] init];
        searchVC.title = @"消息";
        BTNavigationController *thirdNavigationController = [[BTNavigationController alloc]
                                                             initWithRootViewController:searchVC];
        
        BTProfileVC *profileVC = [[BTProfileVC alloc] init];
        profileVC.title = @"我";
        BTNavigationController *fourthNavigationController = [[BTNavigationController alloc]
                                                              initWithRootViewController:profileVC];
        
        BTTabBarController *tabBarController = [[BTTabBarController alloc] init];
        
        [self customizeTabBarForController:tabBarController];
        
        [tabBarController setViewControllers:@[
                                               firstNavigationController,
                                               secondNavigationController,
                                               thirdNavigationController,
                                               fourthNavigationController
                                               ]];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
 */
- (void)customizeTabBarForController:(BTTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"",
                            CYLTabBarItemImage : @"tab_首页",
                            CYLTabBarItemSelectedImage : @"tab_首页_pressed",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"",
                            CYLTabBarItemImage : @"tab_社区",
                            CYLTabBarItemSelectedImage : @"tab_社区_pressed",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"",
                            CYLTabBarItemImage : @"tab_分类",
                            CYLTabBarItemSelectedImage : @"tab_分类_pressed",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"",
                            CYLTabBarItemImage : @"tab_我的",
                            CYLTabBarItemSelectedImage : @"tab_我的_pressed"
                            };
    NSArray *tabBarItemsAttributes = @[ dict1, dict2, dict3, dict4 ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
    
    [self setUpTabBarItemTextAttributes];
}

/**
 *  tabBarItem 的选中和不选中文字属性
 */
- (void)setUpTabBarItemTextAttributes {
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = BTGobalRedColor;
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    UITabBar *tabBarAppearance = [UITabBar appearance];
    [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tab_bar_bg"]];
}
@end
