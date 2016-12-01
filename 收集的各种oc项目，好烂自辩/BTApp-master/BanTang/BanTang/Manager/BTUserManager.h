//
//  BTUserManager.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/28.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,BTMessageType) {
    BTMessageTypeNotification = 1,
    BTMessageTypeNewFans,
    BTMessageTypeNewComment,
    BTMessageTypeNewLike,
    BTMessageTypeNewReward
};

typedef void(^FailureHandler)(NSError *error);
@class BTUserInfo,BTRedSpot;
@interface BTUserManager : NSObject

/**
 *  获取用户信息
 *
 *  @param successHandler 成功回调
 *  @param failureHandler 失败回调
 */
+ (void)getUserInfoSuccess:(void(^)(BTUserInfo *))successHandler
                   failure:(FailureHandler)failureHandler;
/**
 *  关注
 *
 *  @param friendId       对方的id字符串
 *  @param successHanlder 成功回调
 *  @param failureHanlder 失败回调
 */
+ (void)followUserWithFriendId:(NSString *)friendId
                       success:(void(^)())successHandler
                       failure:(FailureHandler)failureHandler;

/**
 *  取消关注
 *
 *  @param friendId       对方的id字符串
 *  @param successHanlder 成功回调
 *  @param failureHanlder 失败回调
 */
+ (void)unfollowUserWithFriendId:(NSString *)friendId
                         success:(void(^)(BOOL))successHandler
                         failure:(FailureHandler)failureHandler;

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
           failureHandler:(FailureHandler)failuteHandler;


/**
 *  取消喜欢
 *
 *  @param subjectId      subjectID
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)unlikeSubjectWithID:(NSInteger)subjectId
             successHandler:(void(^)(BOOL result))successHandler
             failureHandler:(FailureHandler)failuteHandler;

/**
 *  获取红点
 *
 *  @param successHanlder 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getRedSpotSuccessHandler:(void(^)(BTRedSpot *spot))successHanlder
             failureHandler:(FailureHandler)failuteHandler;

/**
 *  获取消息列表
 *
 *  @param typeId         typeId
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getNoticeListWithType:(BTMessageType)type
               SuccessHandler:(void(^)(NSArray *noticeList))successHanlder
               failureHandler:(FailureHandler)failuteHandler;


@end
