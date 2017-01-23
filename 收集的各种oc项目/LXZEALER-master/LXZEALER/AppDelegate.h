//
//  AppDelegate.h
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/1.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WeiboSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  用户id
 */
@property (strong, nonatomic) NSString *userID;

/**
 *  认证口令
 */
@property (strong, nonatomic) NSString *access_token;

/**
 *  刷新access_token 口令
 */
@property (strong, nonatomic) NSString *refresh_token;

/**
 *  过期时间
 */
@property (strong ,nonatomic) NSDate *expirationDate;

/**
 *  获得appdelegate单例
 *
 *  @return appdelegate对象
 */
+ (AppDelegate*)sharedAppdelegate;

-(void)getWXCodeStringWithController:(id)vc;

@end

