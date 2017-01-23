//
//  BTAppManager.m
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTAppManager.h"
#import "BTAppInfo.h"
#import "BTBaseRequestParmas.h"
#import <RXApiServiceEngine.h>

@implementation BTAppStartAd

@end

@implementation BTAppManager
/**
 *  app初始化信息
 *
 *  @param successHanlder 成功回调
 *  @param failureHanlder 失败回调
 */
+ (void)initializeOnSucess:(void(^)(BTAppInfo *appInfo))successHandler
                   failure:(void(^)(NSError *error))failureHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    
    NSString *url = [kBaseURL stringByAppendingString:@"app/init"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                successHandler([BTAppInfo mj_objectWithKeyValues:jsonData[@"data"]]);
            }
        }else{
            if (error) {
                if (failureHandler) {
                    failureHandler(error);
                }
            }
        }
    }];
}

/**
 *  获取广告
 *
 *  @param successHanlder 成功回调
 *  @param failureHanlder 失败回调
 */
+ (void)getStartAdOnSuccess:(void(^)(BTAppStartAd *startAd))successHandler
                    failure:(void(^)(NSError *error))failureHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    
    NSString *url = [kBaseURL stringByAppendingString:@"app/startAd"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                successHandler([BTAppStartAd mj_objectWithKeyValues:jsonData[@"data"]]);
            }
        }else{
            if (error) {
                if (failureHandler) {
                    failureHandler(error);
                }
            }
        }
    }];
}
@end
