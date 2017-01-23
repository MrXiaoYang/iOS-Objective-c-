//
//  AppDelegate.m
//  BanTang
//
//  Created by Ryan on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTAppDelegate.h"
#import "BTTabBarController.h"
#import "BTTabBarControllerConfig.h"
#import "BTUserManager.h"
#import "BTAppInfo.h"
#import "BTAppManager.h"
#import <SDWebImageManager.h>
@interface BTAppDelegate ()

@end

@implementation BTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    BTTabBarControllerConfig *tabBarControllerConfig = [[BTTabBarControllerConfig alloc] init];
    [self.window setRootViewController:tabBarControllerConfig.tabBarController];
    [self.window makeKeyAndVisible];
    
    
    [self saveUserInfo];
    
    return YES;
}

- (void)saveUserInfo
{
    [BTUserManager getUserInfoSuccess:^(BTUserInfo *userInfo) {
        
       BOOL result = [NSKeyedArchiver archiveRootObject:userInfo toFile:kUserInfoPath];
        if (result) {
            NSLog(@"归档userInfo信息成功");
        }else{
            NSLog(@"归档userInfo信息失败");
        }
    } failure:^(NSError *error) {
        NSLog(@"%@,",error);
    }];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [BTAppManager initializeOnSucess:^(BTAppInfo *appInfo) {
        BOOL result = [NSKeyedArchiver archiveRootObject:appInfo toFile:kAppInfoPath];
        if (result) {
            NSLog(@"归档appInfo信息成功");
        }else{
            NSLog(@"归档appInfo信息失败");
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDWebImageManager sharedManager].imageCache clearDisk];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}


@end
