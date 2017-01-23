//
//  FindNetManager.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/4.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "FindNetManager.h"
#import "AVModel.h"

@implementation FindNetManager
+ (id)GetRankCompletionHandler:(void(^)(id responseObj, NSError *error))complete{
    NSString* basePath = [NSString stringWithFormat:@"http://app.bilibili.com/api/search_rank.json?_device=android&_hwid=831fc7511fa9aff5&appkey=c1b107428d337928&build=408001&platform=android&ts=%ld&sign=63405243feccff73b90e75737d8fc561", (long)[NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970];
    return [self Get:basePath parameters:nil completionHandler:^(id responseObj, NSError *error) {
        complete([FindModel mj_objectWithKeyValues:[NSJSONSerialization json2DicWithData:responseObj]],error);
    }];
}
+ (id)GetRankImgCompletionHandler:(void(^)(id responseObj, NSError *error))complete{
    //NSString* basePath = @"http://app.bilibili.com/api/search/1954/search.android.xhdpi.android.json";
    NSString* basePath = [NSString stringWithFormat:@"http://app.bilibili.com/bangumi/operation_module?_device=android&_hwid=831fc7511fa9aff5&_ulv=10000&access_key=9f380cf88aaea796f400871a586afd27&appkey=c1b107428d337928&build=408001&channel=yingyongbao&module=search&platform=android&screen=xhdpi&test=0&ts=%ld&sign=81c90bb4c0c63119ee91028849f9495b", (long)[NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970];
    return [self Get:basePath parameters:nil completionHandler:^(id responseObj, NSError *error) {
        complete([FindImgModel mj_objectWithKeyValues:[NSJSONSerialization json2DicWithData:responseObj][@"result"]],error);
    }];
}
+ (id)GetSectionRankWithParameters:(NSDictionary*)parameters CompletionHandler:(void(^)(id responseObj, NSError *error))complete{
    //http://www.bilibili.com/index/rank/all-3-1.json 排行
    //http://www.bilibili.com/index/rank/origin-3-0.json 原创
    NSString* basePath = nil;
    if ([parameters[@"style"] isEqualToString: @"origin"]) {
        basePath = [NSString stringWithFormat: @"http://www.bilibili.com/index/rank/all-3-%@.json",parameters[@"section"]];
    }else{
        basePath = [NSString stringWithFormat: @"http://www.bilibili.com/index/rank/origin-3-%@.json",parameters[@"section"]];
    }
    return [self Get: basePath parameters:nil completionHandler:^(id responseObj, NSError *error) {
        complete([AVModel mj_objectWithKeyValues:[NSJSONSerialization json2DicWithData:responseObj][@"rank"]], error);
    }];
}
@end
