//
//  ReplyNetManager.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/7.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "AVInfoNetManager.h"
#import "NSString+Tools.h"
#import "NSDictionary+Tools.h"
#import "VideoNetManager.h"

@implementation AVInfoNetManager
//获取回复
+ (id)GetReplyWithParameter:(NSDictionary*)parame completionHandler:(void(^)(id responseObj, NSError *error))complete{
    //http://api.bilibili.com/feedback?type=jsonp&ver=3&callback=jQuery172019889523880556226_1446769749937&mode=arc&aid=3118012&pagesize=20&page=1&_=1446769758188
    //aid pagesize page
    NSString*path = [parame appendGetParameterWithBasePath:@"http://api.bilibili.com/feedback?type=jsonp&ver=3&callback=jQuery172019889523880556226_1446769749937&mode=arc&_=1446769758188&"];
    return [self Get:path parameters:nil completionHandler:^(NSData* responseObj, NSError *error) {
        NSString* str = [[[NSString alloc] initWithData:responseObj encoding:NSUTF8StringEncoding] subStringsWithRegularExpression:@"\\{.*\\}"].firstObject;
        NSDictionary* js = [NSJSONSerialization json2DicWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
        complete([ReplyModel mj_objectWithKeyValues: js], error);
    }];
}

//获取承包商信息
+ (id)GetInverstorWithParameter:(NSDictionary*)parame completionHandler:(void(^)(id responseObj, NSError *error))complete{
    //http://www.bilibili.com/widget/ajaxGetBP?aid=3168681
    //aid
    NSString* path = [parame appendGetParameterWithBasePath:@"http://www.bilibili.com/widget/ajaxGetBP?"];
    return [self Get:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        complete([InvestorModel mj_objectWithKeyValues:[NSJSONSerialization json2DicWithData:responseObj][@"list"]], error);
    }];
}
//获取推荐视频信息
+ (id)GetSameVideoWithParameter:(NSString*)parame completionHandler:(void(^)(id responseObj, NSError *error))complete{
   // http://comment.bilibili.com/recommend,3187577
    NSString* path = [NSString stringWithFormat:@"http://comment.bilibili.com/recommend,%@",parame];
    return [self Get:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        id obj = [NSJSONSerialization json2DicWithData:responseObj];
        if (obj == nil) {
            complete(nil, error);
        }else{
            complete([sameVideoModel mj_objectWithKeyValues:@{@"list":obj}], error);
        }
    }];
}

+ (id)GetTagWithParameter:(NSDictionary*)parame completionHandler:(void(^)(id responseObj, NSError *error))complete{
    //http://www.bilibili.com/api_proxy?app=tag&action=/tags/archive_list&aid=3161283&nomid=1
//    aid
    NSString* path = [parame appendGetParameterWithBasePath:@"http://www.bilibili.com/api_proxy?app=tag&action=/tags/archive_list&nomid=1&"];
    return [self Get:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        complete([TagModel mj_objectWithKeyValues:[NSJSONSerialization json2DicWithData:responseObj]],error);
    }];
}

//获取新番详情信息
+ (id)GetShiBanInfoWithParameter:(NSString*)parame completionHandler:(void(^)(id responseObj, NSError *error))complete{
    //http://app.bilibili.com/bangumi/seasoninfo/2725.ver?callback=episodeJsonCallback&_=1446863930820
    NSString* path = [NSString stringWithFormat:@"http://app.bilibili.com/bangumi/seasoninfo/%@.ver?callback=episodeJsonCallback&_=1446863930820",parame];
    return [self Get:path parameters:nil completionHandler:^(NSData* responseObj, NSError *error) {
        NSString* str = [[[NSString alloc] initWithData:responseObj encoding:NSUTF8StringEncoding] subStringsWithRegularExpression:@"\\{.*\\}"].firstObject;
        NSDictionary* js = [NSJSONSerialization json2DicWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
        complete([ShinBanInfoModel mj_objectWithKeyValues: js], error);
    }];
}

+ (id)DownVideoWithDic:(NSDictionary*)dic completionHandler:(void(^)(id responseObj, NSError *error))complete{
    VideoModel *vm = dic[@"vm"];
    NSString *quality = dic[@"quality"];
    NSData *resumeData = [dic[@"resumeData"] isEqualToString:@""]?nil:[dic[@"resumeData"] dataUsingEncoding: NSUTF8StringEncoding];
    NSString* aid = dic[@"aid"];
    
    return [VideoNetManager DownDanMuWithParameter:vm.durl.firstObject.cid completionHandler:^(NSDictionary *danmuObj, NSError *error) {
        NSString* path = nil;
        if ([quality isEqualToString:@"high"]) {
            path = vm.durl.firstObject.url;
        }else if ([quality isEqualToString:@"normal"]){
            path = vm.durl.firstObject.backup_url.firstObject;
        }else{
            path = vm.durl.firstObject.backup_url.lastObject;
        }
        //对下载路径进行非空判断
        if (path == nil) {
            NSLog(@"请求失败");
            return;
        }else{
            NSLog(@"请求成功");
        }
        
        [self downLoad:path parameters:@{@"aid": aid} resumeData:resumeData completionHandler:^(NSURL *downLoadPathObj, NSError *error) {
            //path存在 返回下载路径
            if (downLoadPathObj.path) {
                complete(@{@"danmuobj":danmuObj,@"status":@"downloadover",@"videopath":[downLoadPathObj.path lastPathComponent]}, nil);
            }
            NSLog(@"%@", downLoadPathObj);
        }];
        
    }];
}

@end
