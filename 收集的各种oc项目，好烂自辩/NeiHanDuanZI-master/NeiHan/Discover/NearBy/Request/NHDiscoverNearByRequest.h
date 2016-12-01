//
//  NHDiscoverNearByRequest.h
//  NeiHan
//
//  Created by Charles on 16/9/4.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseRequest.h"

@interface NHDiscoverNearByRequest : NHBaseRequest

//http://lf.snssdk.com/neihan/user/nearby/v1/?iid=5316804410&os_version=9.3.4&os_api=18&app_name=joke_essay&channel=App%20Store&device_platform=iphone&idfa=832E262C-31D7-488A-8856-69600FAABE36&live_sdk_version=120&vid=4A4CBB9E-ADC3-426B-B562-9FC8173FDA52&openudid=cbb1d9e8770b26c39fac806b79bf263a50da6666&device_type=iPhone%206%20Plus&version_code=5.5.0&ac=WIFI&screen_width=1242&device_id=10752255605&aid=7&gender=-1&latitude=40.0720396865016&longitude=116.3416759780343

@property (nonatomic, assign) NSInteger gender; // - 1全部 0男 1女 2不明
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@end
