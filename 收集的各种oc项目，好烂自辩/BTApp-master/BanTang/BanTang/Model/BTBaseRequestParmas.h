//
//  BTHomePageParmas.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *
 app_installtime	1448526083.725066
 app_versions	4.3
 channel_name	appStore
 client_id	bt_app_ios
 client_secret	9c1e6634ce1c5098e056628cd66a17a5
 device_token	909e071381687d4e4f179f1d80b712e8d1afdf944c441c791ee4a75e58fda008
 oauth_token	7b71ae6c8e12d5b15e426f178dfa3e3a
 os_versions	9.1
 page	0
 pagesize	20
 screensize	750
 track_device_info	iPhone8,1
 track_deviceid	D4A4D7A1-6979-4DD6-ABBE-F6A614835068
 track_user_id	1607500
 */
@interface BTBaseRequestParmas : NSObject

@property (nonatomic, copy, readonly) NSString *app_installtime;
@property (nonatomic, copy, readonly) NSString *app_versions;
@property (nonatomic, copy, readonly) NSString *channel_name;
@property (nonatomic, copy, readonly) NSString *client_id;
@property (nonatomic, copy, readonly) NSString *client_secret;
@property (nonatomic, copy, readonly) NSString *device_token;
@property (nonatomic, copy, readonly) NSString *oauth_token;
@property (nonatomic, copy, readonly) NSString *os_versions;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pagesize;
@property (nonatomic, assign) CGFloat screensize;
@property (nonatomic, copy, readonly) NSString *track_device_info;
@property (nonatomic, copy, readonly) NSString *track_deviceid;
@property (nonatomic, copy, readonly) NSString *track_user_id;

+ (instancetype)params;
@end
