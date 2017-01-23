//
//  FindNetManager.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/4.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseNetManager.h"
#import "FindModel.h"
@interface FindNetManager : BaseNetManager
+ (id)GetRankCompletionHandler:(void(^)(id responseObj, NSError *error))complete;
+ (id)GetRankImgCompletionHandler:(void(^)(id responseObj, NSError *error))complete;
/**
 *  获取全区排行
 *
 */
+ (id)GetSectionRankWithParameters:(NSDictionary*)parameters CompletionHandler:(void(^)(id responseObj, NSError *error))complete;
@end