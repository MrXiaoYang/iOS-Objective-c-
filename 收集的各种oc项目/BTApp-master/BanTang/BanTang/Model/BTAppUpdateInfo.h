//
//  BTAppUpdateInfo.h
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface BTAppUpdateInfo : NSObject

@property (nonatomic, assign) NSInteger updateType;

@property (nonatomic, copy) NSString *updateVersions;

@property (nonatomic, copy) NSString *updateUrl;

@property (nonatomic, copy) NSString *updateMessage;

@end
