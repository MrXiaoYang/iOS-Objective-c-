//
//  BTAppManager.h
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BTAppInfo,BTAppStartAd;

@interface BTAppStartAd : NSObject

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, assign) BOOL is_show;

@end

@interface BTAppManager : NSObject

/**
 *  app初始化信息
 *
 *  @param successHanlder 成功回调
 *  @param failureHanlder 失败回调
 */
+ (void)initializeOnSucess:(void(^)(BTAppInfo *appInfo))successHandler
                   failure:(void(^)(NSError *error))failureHandler;

/**
 *  获取广告
 *
 *  @param successHanlder 成功回调
 *  @param failureHanlder 失败回调
 */
+ (void)getStartAdOnSuccess:(void(^)(BTAppStartAd *startAd))successHandler
                    failure:(void(^)(NSError *error))failureHandler;

@end
