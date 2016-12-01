//
//  RecommendNetManager.m
//  BiliBili
//
//  Created by apple-jd44 on 15/10/21.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "RecommendNetManager.h"
#import "AVModel.h"
#import "IndexModel.h"
@implementation RecommendNetManager
+ (id)getSection:(NSString *)section completionHandler:(void(^)(id responseObj, NSError *error))complete{
    //http://www.bilibili.com/index/catalogy/1-3day.json
    NSString* path = [@"http://www.bilibili.com/index/catalogy/" stringByAppendingString:section];
        return [self Get:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
            complete([AVModel mj_objectWithKeyValues:[NSJSONSerialization json2DicWithData:responseObj][@"hot"]], error);
        }];
}
//获取顶部滚动视图
+ (id)getHeadImgCompletionHandler:(void(^)(id responseObj, NSError *error))complete{
    //http://www.bilibili.com/index/slideshow.json
    NSString* path = @"http://www.bilibili.com/index/slideshow.json";
    return [self Get:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
         complete([IndexModel mj_objectWithKeyValues:[NSJSONSerialization json2DicWithData:responseObj]],error);
    }];
}
@end
