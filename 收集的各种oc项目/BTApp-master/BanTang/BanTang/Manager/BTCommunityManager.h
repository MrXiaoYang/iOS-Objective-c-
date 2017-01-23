//
//  BTCommunityManager.h
//  BanTang
//
//  Created by 沈文涛 on 15/12/6.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BTCommunityEditorRec;
@interface BTCommunityManager : NSObject

/**
 *  获取社区精选
 *
 *  @param page           页数
 *  @param successHanlder 成功回调
 *  @param failureHandler 失败回调
 */
+ (void)getEditorRecWithPage:(NSInteger)page
                     success:(void(^)(BTCommunityEditorRec *editorRec))successHanlder
                     failure:(void(^)(NSError *error))failureHandler;


/**
 *  获取社区关注
 *
 *  @param page           页数
 *  @param successHanlder 成功回调
 *  @param failureHandler 失败回调
 */
+ (void)getMyAttentionPostWithPage:(NSInteger)page
                     success:(void(^)(NSArray *listPostArray))successHanlder
                     failure:(void(^)(NSError *error))failureHandler;
@end
