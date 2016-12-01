//
//  BTCommunityManager.m
//  BanTang
//
//  Created by 沈文涛 on 15/12/6.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTCommunityManager.h"
#import "BTCommunityEditorRec.h"
#import "BTListPost.h"
#import "BTBaseRequestParmas.h"
#import "RXApiServiceEngine.h"
@implementation BTCommunityManager

/**
 *  获取社区精选
 *
 *  @param page           页数
 *  @param successHanlder 成功回调
 *  @param failureHandler 失败回调
 */
+ (void)getEditorRecWithPage:(NSInteger)page
                     success:(void(^)(BTCommunityEditorRec *editorRec))successHandler
                     failure:(void(^)(NSError *error))failureHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"page"] = @(page);
    params[@"pagesize"] = @(10);
    params[@"v"] = @"8";
//    params[@"last_time"]= [NSString stringWithFormat:@"%.f",[NSDate date].timeIntervalSince1970];

    NSString *url = [kBaseURL stringByAppendingString:@"community/post/editorRec"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                successHandler([BTCommunityEditorRec mj_objectWithKeyValues:jsonData[@"data"]]);
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
 *  获取社区关注
 *
 *  @param page           页数
 *  @param successHanlder 成功回调
 *  @param failureHandler 失败回调
 */
+ (void)getMyAttentionPostWithPage:(NSInteger)page
                           success:(void(^)(NSArray *listPostArray))successHandler
                           failure:(void(^)(NSError *error))failureHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"page"] = @(page);
    params[@"pagesize"] = @(10);
    
    NSString *url = [kBaseURL stringByAppendingString:@"community/post/myAttentionPost"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                successHandler([BTListPost mj_objectArrayWithKeyValuesArray:jsonData[@"data"][@"list"]]);
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
