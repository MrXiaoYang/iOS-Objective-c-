//
//  BTProductManager.h
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTProductManager : NSObject

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
                           failure:(void(^)(NSError *error))failureHandler;

/**
 *  获取产品喜欢列表
 *
 *  @param objectID       ID
 *  @param successHandler 成功回调
 *  @param failureHandler 失败回调
 */
+ (void)getProductLikesListWithObjectID:(NSString *)objectID
                                success:(void(^)(NSArray *likesList))successHandler
                                failure:(void(^)(NSError *error))failureHandler;




@end
