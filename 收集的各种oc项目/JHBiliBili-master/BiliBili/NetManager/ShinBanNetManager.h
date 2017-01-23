//
//  ShinBanNetManager.h
//  BiliBili
//
//  Created by apple-jd44 on 15/10/28.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseNetManager.h"

@interface ShinBanNetManager : BaseNetManager
/**
 *  获取大家都在看
 *
 */
+ (id)getMoreViewParametersCompletionHandler:(void(^)(id responseObj, NSError *error))complete;
/**
 *  获取推荐番剧
 *
 */
+ (id)getRecommentParameters:(NSDictionary*)params CompletionHandler:(void(^)(id responseObj, NSError *error))complete;
/**
 *  获取新番放送表
 *
 */
+ (id)getShiBanPlayTableCompletionHandler:(void(^)(id responseObj, NSError *error))complete;
@end
