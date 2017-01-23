//
//  BTHomePageManager.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTHomePageData.h"
#import "BTCommunitySubject.h"
@class BTSubjectListPostParams,BTListPost,BTTopicNewInfo;
typedef void(^CompeletionHandler)(NSArray *dataArray,NSError *error);
typedef void(^FailureHandler)(NSError *error);
@interface BTHomePageManager : NSObject
/**
 *  获取轮播图数组
 *
 *  @param array 轮播图数组
 */
+ (void)getBannerArrayWithCompetionHanlder:(CompeletionHandler)handler;

/**
 *  根据page获取首页数据
 *
 *  @param array 轮播图数组
 */
+ (void)getHomePageDataWithPage:(NSInteger)page
                 successHandler:(void(^)(BTHomePageData *pageData))successHandler
                 failureHandler:(FailureHandler)failuteHandler;

/**
 *  根据page返回话题list
 *
 *  @param page           页数
 *  @param extend         拼接的id字符串
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getTopicListWithPage:(NSInteger)page
                      extend:(NSString *)extend
              successHandler:(void(^)(NSArray *topicList))successHandler
              failureHandler:(FailureHandler)failuteHandler;

/**
 *  根据subjectId返回subJect
 *
 *  @param subjectId      subjectID
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getSubjectWithID:(NSInteger)subjectId
          successHandler:(void(^)(BTCommunitySubject *subject))successHandler
          failureHandler:(FailureHandler)failuteHandler;

/**
 *  根据page返回话题listPost
 *
 *  @param page           页数
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getListPostWithListPostParams:(BTSubjectListPostParams *)params
              successHandler:(void(^)(NSArray *listPostArray))successHandler
              failureHandler:(FailureHandler)failuteHandler;

/**
 *  根据infoId返回listPostInfo
 *
 *  @param infoId         infoId
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getListPostInfoWithId:(NSString *)infoId
               successHandler:(void(^)(BTListPost *listPost))successHandler
               failureHandler:(FailureHandler)failuteHandler;


/**
 *  获取清单分类列表
 *
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getCategoryListSuccessHandler:(void(^)(NSArray *categoryArray))successHandler
                       failureHandler:(FailureHandler)failuteHandler;

/**
 *  获取热门标签列表
 *
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getHotTagListSuccessHandler:(void(^)(NSArray *tagsArray))successHandler
                     failureHandler:(FailureHandler)failuteHandler;

/**
 *  获取topic详情
 *
 *  @param infoId id
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getTopicNewInfoWithId:(NSString *)infoId
               successHandler:(void(^)(BTTopicNewInfo *info))successHandler
               failureHandler:(FailureHandler)failuteHandler;


@end
