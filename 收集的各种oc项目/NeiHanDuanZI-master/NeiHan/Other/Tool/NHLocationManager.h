//
//  NHLocationManager.h
//  NeiHan
//
//  Created by Charles on 16/9/6.
//  Copyright © 2016年 Charles. All rights reserved.
//  定位管理类

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>

typedef void(^NHLocationManagerDidUpdateLocationHandle)(CLLocation *newLocation, NSString *newLatitude, NSString *newLongitude);

@interface NHLocationManager : NSObject

/** 开始定位*/
- (void)startSerialLocation;

+ (instancetype)sharedManager;

/** 更新定位回调*/
- (void)setUpLocationManagerUpdateLocationHandle:(NHLocationManagerDidUpdateLocationHandle)updateLocationHandle;

/** 是否可以定位*/
@property (nonatomic, assign) BOOL canLocationFlag;

/** 是否有经纬度*/
@property (nonatomic, assign) BOOL hasLocation;
@end
