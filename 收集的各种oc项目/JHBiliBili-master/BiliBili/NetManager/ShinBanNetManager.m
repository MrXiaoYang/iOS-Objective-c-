//
//  ShinBanNetManager.m
//  BiliBili
//
//  Created by apple-jd44 on 15/10/28.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ShinBanNetManager.h"
#import "ShinBanModel.h"
#import "ShiBanPlayTableModel.h"
#import "NSDictionary+Tools.h"
#import "NSString+Tools.h"
@implementation ShinBanNetManager
+ (id)getMoreViewParametersCompletionHandler:(void(^)(id responseObj, NSError *error))complete{
    //http://www.bilibili.com/index/ding/13.json
    NSString* basePath = @"http://www.bilibili.com/index/ding/13.json";
    return [self Get:basePath parameters:nil completionHandler:^(id responseObj, NSError *error) {
        complete([MoreViewShinBanModel mj_objectWithKeyValues:[NSJSONSerialization json2DicWithData:responseObj]],error);
    }];
    
}

+ (id)getRecommentParameters:(NSDictionary*)params CompletionHandler:(void(^)(id responseObj, NSError *error))complete{
    
    //http://www.bilibili.com/api_proxy?app=bangumi&page=1&indexType=0&pagesize=30&action=site_season_index
    
    NSString*basePath = [params appendGetParameterWithBasePath:@"http://www.bilibili.com/api_proxy?app=bangumi&indexType=0&action=site_season_index&"];
    
    return [self Get:basePath parameters:nil completionHandler:^(id responseObj, NSError *error) {
        id obj = [NSJSONSerialization json2DicWithData:responseObj];
        if ([obj isKindOfClass: [NSDictionary class]]) complete([RecommentShinBanModel mj_objectWithKeyValues:obj[@"result"]],error);
        else complete(nil,error);
    }];
}

+ (id)getShiBanPlayTableCompletionHandler:(void(^)(id responseObj, NSError *error))complete{
    //http://app.bilibili.com/bangumi/timeline_v2
    return [self Get:@"http://app.bilibili.com/bangumi/timeline_v2" parameters:nil completionHandler:^(id responseObj, NSError *error) {
        NSString* str = [[[NSString alloc] initWithData:responseObj encoding:NSUTF8StringEncoding] subStringsWithRegularExpression:@"\\{.*\\}"].firstObject;
        NSDictionary* js = [NSJSONSerialization json2DicWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
        complete([ShiBanPlayTableModel mj_objectWithKeyValues: js], error);
    }];
}
@end
