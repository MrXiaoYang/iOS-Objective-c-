//
//  BTHomePageManager.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTHomePageManager.h"
#import <RXApiServiceEngine.h>
#import "BTBaseRequestParmas.h"
#import "BTSubjectListPostParams.h"
#import <MJExtension.h>
#import "BTHomeTopic.h"
#import "BTListPost.h"
#import "BTTopicNewInfo.h"
#import "BTSubscribeTag.h"
@implementation BTHomePageManager

+ (void)getBannerArrayWithCompetionHanlder:(CompeletionHandler)handler
{
    NSString *url = [kBaseURL stringByAppendingString:@"recommend/index?"];
    
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"page"] = @(0);
    
    [RXApiServiceEngine requestWithType:RequestMethodTypeGet url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (handler) {
                BTHomePageData *data = [BTHomePageData mj_objectWithKeyValues:jsonData[@"data"]];
                handler(data.banner,nil);
            }
        }else{
            if (error) {
                if (handler) {
                    handler(nil,error);
                }
            }
        }
        NSLog(@"%@",jsonData);
    }];
}

/**
 *  根据page获取首页数据
 *
 *  @param array 轮播图数组
 */
+ (void)getHomePageDataWithPage:(NSInteger)page
                 successHandler:(void(^)(BTHomePageData *pageData))successHandler
                 failureHandler:(FailureHandler)failuteHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"page"] = @(page);
    NSString *url = [kBaseURL stringByAppendingString:@"recommend/index?"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypeGet url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                BTHomePageData *data = [BTHomePageData mj_objectWithKeyValues:jsonData[@"data"]];
                successHandler(data);
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
              failureHandler:(FailureHandler)failuteHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"page"] = @(page);
    params[@"ids"] = extend;
    NSString *url = [kBaseURL stringByAppendingString:@"topic/list?"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypeGet url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                NSArray *data = [BTHomeTopic mj_objectArrayWithKeyValuesArray:jsonData[@"data"]];
                successHandler(data);
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
 *  根据subjectId返回subJect
 *
 *  @param subjectId      subjectID
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getSubjectWithID:(NSInteger)subjectId
          successHandler:(void(^)(BTCommunitySubject *subject))successHandler
          failureHandler:(FailureHandler)failuteHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"subject_id"] = @(subjectId);
    NSString *url = [kBaseURL stringByAppendingString:@"community/subject/info"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                BTCommunitySubject *subject = [BTCommunitySubject mj_objectWithKeyValues:jsonData[@"data"][@"subject"]];
                successHandler(subject);
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
 *  根据page返回话题listPost
 *
 *  @param page           页数
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getListPostWithListPostParams:(BTSubjectListPostParams *)listPostParams
                       successHandler:(void (^)(NSArray *))successHandler
                       failureHandler:(FailureHandler)failuteHandler
{
    NSMutableDictionary *params = listPostParams.mj_keyValues;

    NSString *url = [kBaseURL stringByAppendingString:@"community/subject/listPost"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                NSArray *listPostArray = [BTListPost mj_objectArrayWithKeyValuesArray:jsonData[@"data"][@"list"]];
                successHandler(listPostArray);
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
 *  根据infoId返回listPostInfo
 *
 *  @param infoId         infoId
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getListPostInfoWithId:(NSString *)infoId
               successHandler:(void(^)(BTListPost *listPost))successHandler
               failureHandler:(FailureHandler)failuteHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"id"] = infoId;
    
    NSString *url = [kBaseURL stringByAppendingString:@"community/post/info"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                successHandler([BTListPost mj_objectWithKeyValues:jsonData[@"data"][@"post"]]);
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
 *  获取清单分类列表
 *
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getCategoryListSuccessHandler:(void(^)(NSArray *categoryArray))successHandler
                       failureHandler:(FailureHandler)failuteHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    [params removeObjectForKey:@"pagesize"];
    [params removeObjectForKey:@"screensize"];
    
    NSString *url = [kBaseURL stringByAppendingString:@"category/list"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                successHandler([BTSubscribeTag mj_objectArrayWithKeyValuesArray:jsonData[@"data"]]);
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
 *  获取热门标签列表
 *
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getHotTagListSuccessHandler:(void(^)(NSArray *tagsArray))successHandler
                     failureHandler:(FailureHandler)failuteHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    [params removeObjectForKey:@"pagesize"];
    [params removeObjectForKey:@"screensize"];
    
    NSString *url = [kBaseURL stringByAppendingString:@"base/search/hottags"];
    
    [RXApiServiceEngine requestWithType:RequestMethodTypePost url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                successHandler(jsonData[@"data"]);
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
 *  获取topic详情
 *
 *  @param infoId id
 *  @param successHandler 成功回调
 *  @param failuteHandler 失败回调
 */
+ (void)getTopicNewInfoWithId:(NSString *)infoId
               successHandler:(void(^)(BTTopicNewInfo *info))successHandler
               failureHandler:(FailureHandler)failuteHandler
{
    NSMutableDictionary *params = [BTBaseRequestParmas params].mj_keyValues;
    params[@"id"] = infoId;
    params[@"statistics_uv"] = @0;
    [params removeObjectForKey:@"pagesize"];
    NSString *url = [kBaseURL stringByAppendingString:@"topic/newInfo?"];
    [RXApiServiceEngine requestWithType:RequestMethodTypeGet url:url parameters:params completionHanlder:^(id jsonData, NSError *error) {
        if (jsonData) {
            if (successHandler) {
                successHandler([BTTopicNewInfo mj_objectWithKeyValues:jsonData[@"data"]]);
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
@end
