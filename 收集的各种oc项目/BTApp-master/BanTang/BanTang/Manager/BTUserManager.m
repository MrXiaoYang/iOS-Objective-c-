//
//  BTUserManager.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/28.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTUserManager.h"
#import <RXApiServiceEngine.h>
#import "BTBaseRequestParmas.h"
#import "BTUserInfo.h"
#import "BTRedSopt.h"
#import "BTMessageNotice.h"
@implementation BTUserManager

/**
 *  获取用户信息
 *
 *  @param successHandler 成功回调
 *  @param failureHandler 失败回调
 */
+ (void)getUserInfoSuccess:(void(^)(BTUserInfo *userInfo))successHandler
                   failure:(FailureHandler)failureHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    NSString *url = [kBaseURL stringByAppendingString:@"users/likes/userInfo"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params
                      completionHanlder:^(id jsonData, NSError *error)
    {
        if (jsonData) {
            if (successHandler) {
                successHandler([BTUserInfo mj_objectWithKeyValues:jsonData[@"data"]]);
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
 *  关注
 *
 *  @param friendId       对方的id字符串
 *  @param successHanlder 成功回调
 *  @param failureHanlder 失败回调
 */
+ (void)followUserWithFriendId:(NSString *)friendId
                       success:(void(^)())successHandler
                       failure:(FailureHandler)failureHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"friend_id"] = friendId;
    NSString *url = [kBaseURL stringByAppendingString:@"users/fllow/add"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                successHandler();
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
 *  取消关注
 *
 *  @param friendId       对方的id字符串
 *  @param successHanlder 成功回调
 *  @param failureHanlder 失败回调
 */
+ (void)unfollowUserWithFriendId:(NSString *)friendId
                         success:(void(^)(BOOL))successHandler
                         failure:(FailureHandler)failureHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"friend_id"] = friendId;
    NSString *url = [kBaseURL stringByAppendingString:@"users/fllow/delete"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypeGet url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
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
 *  喜欢
 *
 *  @param subjectId      subjectID
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)likeSubjectWithID:(NSInteger)subjectId
                    boxID:(NSInteger)boxID
               categoryID:(NSString *)categoryID
           successHandler:(void(^)(BOOL result))successHandler
           failureHandler:(FailureHandler)failuteHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"object_id"] = @(subjectId);
    params[@"type_id"] = @(2);
    if (boxID) {
        params[@"box_id"] = @(boxID);
    }
    if (categoryID) {
        params[@"category_id"] = categoryID;
    }
    [params removeObjectForKey:@"screensize"];
    [params removeObjectForKey:@"pagesize"];
    [params removeObjectForKey:@"page"];
    
    NSString *url = [kBaseURL stringByAppendingString:@"users/likes/add"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                successHandler(jsonData[@"data"][@"result"]);
            }
        }else{
            if (error) {
                if (failuteHandler) {
                    failuteHandler(error);
                }
            }
        }
    }];
}


/**
 *  取消喜欢
 *
 *  @param subjectId      subjectID
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)unlikeSubjectWithID:(NSInteger)subjectId
             successHandler:(void(^)(BOOL result))successHandler
             failureHandler:(FailureHandler)failuteHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"object_id"] = @(subjectId);
    params[@"type_id"] = @4;
    [params removeObjectForKey:@"screensize"];
    [params removeObjectForKey:@"pagesize"];
    [params removeObjectForKey:@"page"];
    NSString *url = [kBaseURL stringByAppendingString:@"users/likes/delete"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                successHandler(jsonData[@"data"][@"result"]);
            }
        }else{
            if (error) {
                if (failuteHandler) {
                    failuteHandler(error);
                }
            }
        }
    }];
}

/**
 *  获取红点
 *
 *  @param successHanlder 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getRedSpotSuccessHandler:(void(^)(BTRedSpot *spot))successHandler
                  failureHandler:(FailureHandler)failuteHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"type"] = @"1";
    params[@"v"] = @"8";
    [params removeObjectForKey:@"screensize"];
    [params removeObjectForKey:@"pagesize"];
    [params removeObjectForKey:@"page"];
    NSString *url = [kBaseURL stringByAppendingString:@"users/notice/redSpot"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                successHandler([BTRedSpot mj_objectWithKeyValues:jsonData[@"data"]]);
            }
        }else{
            if (error) {
                if (failuteHandler) {
                    failuteHandler(error);
                }
            }
        }
    }];
}

/**
 *  获取消息列表
 *
 *  @param typeId         typeId
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getNoticeListWithType:(BTMessageType)type
               SuccessHandler:(void(^)(NSArray *noticeList))successHandler
               failureHandler:(FailureHandler)failuteHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"type"] = [[[self alloc] init] messageTypeForStringType:type];
    params[@"v"] = @"8";
    NSString *url = [kBaseURL stringByAppendingString:@"users/notice/list"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                successHandler([BTMessageNotice  mj_objectArrayWithKeyValuesArray:jsonData[@"data"][@"list"]]);
            }
        }else{
            if (error) {
                if (failuteHandler) {
                    failuteHandler(error);
                }
            }
        }
    }];
}

- (NSString *)messageTypeForStringType:(BTMessageType)type
{
    switch (type) {
        case BTMessageTypeNotification:
            return @"1";
            break;
        case BTMessageTypeNewFans:
            return @"2";
            break;
        case BTMessageTypeNewComment:
            return @"3,4";
            break;
        case BTMessageTypeNewLike:
            return @"6";
            break;
        case BTMessageTypeNewReward:
            return @"8";
            break;
        default:
            break;
    }
}
@end
