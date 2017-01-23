//
//  BTAppInfo.h
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BTAppUpdateInfo,BTStartAdvertisement,BTPlatformInfo;
@interface BTAppInfo : NSObject

@property (nonatomic, strong) NSArray<BTPlatformInfo *> *webSearch;

@property (nonatomic, copy) NSString *creditMallUrl;

@property (nonatomic, copy) NSString *signinBg_2;

@property (nonatomic, copy) NSString *signinBg_1;

@property (nonatomic, strong) BTAppUpdateInfo *appUpdate;

@property (nonatomic, assign) BOOL isBaichuan;

@property (nonatomic, copy) NSString *webSearchJs;

@property (nonatomic, strong) BTStartAdvertisement *startAd;

@property (nonatomic, copy) NSString *userCover;

@end


