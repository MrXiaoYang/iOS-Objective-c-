//
//  SearchNetManager.h
//  BiliBili
//
//  Created by apple-jd24 on 15/12/12.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseNetManager.h"

@interface SearchNetManager : BaseNetManager
/**
 *  搜索 最少要传一个keyword
 *
 */
+ (id)getSeachParameters:(NSDictionary*)dic CompletionHandler:(void(^)(id responseObj, NSError *error))complete;
/**
 *  获取专题详情
 */
+ (id)getSpecialParameters:(NSString*)spid CompletionHandler:(void(^)(id responseObj, NSError *error))complete;
@end
