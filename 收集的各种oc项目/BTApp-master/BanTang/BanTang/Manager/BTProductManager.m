//
//  BTProductManager.m
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTProductManager.h"
#import "BTBaseRequestParmas.h"
#import <RXApiServiceEngine.h>
#import "BTSubjectAuthor.h"

@implementation BTProductManager
/**
 *  发表评论
 *
 *  @param obcjectID      物体的id
 *  @param content        评论内容
 *  @param successHandler 成功回调
 *  @param failureHandler 失败回调
 */
+ (void)publishCommentWithObjectID:(NSString *)obcjectID
                           content:(NSString *)content
                           success:(void(^)(BOOL result))successHandler
                           failure:(void(^)(NSError *error))failureHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"object_id"] = @([obcjectID integerValue]);
    params[@"conent"] = content;
    params[@"type_id"] = @4;
    [params removeObjectForKey:@"screensize"];
    [params removeObjectForKey:@"pagesize"];
    [params removeObjectForKey:@"page"];
    
    NSString *url = [kBaseURL stringByAppendingString:@"comm/comments/edit"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                successHandler(jsonData[@"data"][@"result"]);
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
 *  获取产品喜欢列表
 *
 *  @param objectID       ID
 *  @param successHandler 成功回调
 *  @param failureHandler 失败回调
 */
+ (void)getProductLikesListWithObjectID:(NSString *)objectID
                                success:(void(^)(NSArray *likesList))successHandler
                                failure:(void(^)(NSError *error))failureHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"id"] = @([objectID integerValue]);
    [params removeObjectForKey:@"screensize"];
    [params removeObjectForKey:@"pagesize"];
    [params removeObjectForKey:@"page"];
    
    NSString *url = [kBaseURL stringByAppendingString:@"product/productLikes"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                successHandler([BTSubjectAuthor mj_objectArrayWithKeyValuesArray:jsonData[@"data"][@"list"]]);
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
