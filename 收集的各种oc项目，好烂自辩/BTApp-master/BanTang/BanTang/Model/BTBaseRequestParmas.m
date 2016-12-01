//
//  BTHomePageParmas.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTBaseRequestParmas.h"
/**
 *
 app_installtime	1448947487.584563
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
@implementation BTBaseRequestParmas

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // 新浪微博登陆
        _app_installtime = @"1448947487.584563";
        _app_versions = @"5.0.1";
        _channel_name = @"appStore";
        _client_id = @"bt_app_ios";
        _client_secret = @"9c1e6634ce1c5098e056628cd66a17a5";
        _device_token = @"6a753ca95d9def383f91b8292f297897ef553b6b3474eb0734173d0feb2c761a";
        _oauth_token = @"ebb4ca3078707ea2b89e0e7fbe840cf6";
        _os_versions = @"9.1";
        _pagesize = 20;
        _screensize = 750;
        _track_device_info = @"iPhone8,1";
        _track_deviceid = @"D4A4D7A1-6979-4DD6-ABBE-F6A614835068";
        _track_user_id = @"1628223";
    }
    return self;
}

+ (instancetype)params
{
    return [[self alloc] init];
}
@end
