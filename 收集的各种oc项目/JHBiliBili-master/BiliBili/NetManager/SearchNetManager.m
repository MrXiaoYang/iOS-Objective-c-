//
//  SearchNetManager.m
//  BiliBili
//
//  Created by apple-jd24 on 15/12/12.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SearchNetManager.h"
#import "SearchModel.h"
#import "SpecialModel.h"
#import "NSDictionary+Tools.h"

@implementation SearchNetManager
+ (id)getSeachParameters:(NSDictionary*)dic CompletionHandler:(void(^)(id responseObj, NSError *error))complete{
    //http://api.bilibili.com/search?_device=android&_hwid=831fc7511fa9aff5&appkey=85eb6835b0a1034e&bangumi_num=1&build=408005&keyword=%E5%B9%B2%E7%89%A9%E5%A6%B9&main_ver=v3&page=1&pagesize=20&platform=android&search_type=all&source_type=0&special_num=1&topic_num=1&upuser_num=1&sign=fb67d8906d97af4f4cdfa29a143df3d6
    NSMutableDictionary* mdic = [dic mutableCopy];
    mdic[@"_device"] = @"android";
    mdic[@"_hwid"] = @"831fc7511fa9aff5";
    mdic[@"appkey"] = APPKEY;
    mdic[@"bangumi_num"] = @"1";
    mdic[@"build"] = @"408005";
    mdic[@"main_ver"] = @"v3";
    mdic[@"page"] = @"1";
    mdic[@"pagesize"] = @"20";
    mdic[@"platform"] = @"android";
    mdic[@"search_type"] = @"all";
    mdic[@"source_type"] = @"0";
    mdic[@"special_num"] = @"1";
    mdic[@"topic_num"] = @"1";
    mdic[@"upuser_num"] = @"1";
    NSString* basePath = [mdic appendGetSortParameterWithSignWithBasePath: @"http://api.bilibili.cn/search?"];
    return [self Get:basePath parameters:nil completionHandler:^(id responseObj, NSError *error) {
        complete([SearchModel mj_objectWithKeyValues: [NSJSONSerialization json2DicWithData: responseObj][@"result"]],error);
    }];
}


+ (id)getSpecialParameters:(NSString*)spid CompletionHandler:(void(^)(id responseObj, NSError *error))complete{
//    http://www.bilibili.com/index/bangumi/58163.json
    NSString* basePath = [NSString stringWithFormat:@"http://www.bilibili.com/index/bangumi/%@.json",spid];
    return [self Get:basePath parameters:nil completionHandler:^(id responseObj, NSError *error) {
        id resp = [NSJSONSerialization json2DicWithData: responseObj];
        if (resp == nil) {
            return;
        }
        complete([SpecialModel mj_objectWithKeyValues: @{@"list": resp}], error);
    }];
}
@end
