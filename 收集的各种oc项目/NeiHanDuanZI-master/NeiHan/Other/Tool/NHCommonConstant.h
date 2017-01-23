//
//  NHCommonConstant.h
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
// 普通公共常量

#import <Foundation/Foundation.h>

@interface NHCommonConstant : NSObject

/** 当前纬度*/
UIKIT_EXTERN NSString *const kNHUserCurrentLatitude;
/** 当前经度*/
UIKIT_EXTERN NSString *const kNHUserCurrentLongitude;
/** 是否登陆*/
UIKIT_EXTERN NSString *const kNHHasLoginFlag;
/** 网络请求成功*/
UIKIT_EXTERN NSString *const kNHRequestSuccessNotification;
@end
