//
//  VideoNetManager.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/13.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "VideoNetManager.h"
#import "NSDictionary+Tools.h"
#import "XML2Dic.h"

@implementation VideoNetManager
+ (id)GetVideoWithParameter:(NSString*)parame completionHandler:(void(^)(id responseObj, NSError *error))complete{
    //aid
    //http://www.bilibilijj.com/Api/AvToCid/3203638 aid转cid用
    //aid cid
    //http://interface.bilibili.com/playurl?platform=android&_device=android&_hwid=831fc7511fa9aff5&_aid=3090561&_tid=0&_p=1&_down=0&cid=4855949&quality=3&otype=json&appkey=86385cdc024c0f6c&type=mp4&sign=7fed8a9b7b446de4369936b6c1c40c3f
    return [self GetCIDWithParameter:parame completionHandler:^(id responseObj, NSError *error) {
       [self GetVideoPathWithCidData:responseObj completionHandler:^(id responseObj, NSError *error) {
           complete(responseObj, error);
       }];
    }];
}

+ (id)GetCIDWithParameter:(NSString*)parame completionHandler:(void(^)(id responseObj, NSError *error))complete{
    NSString*path =  [@"http://www.bilibilijj.com/Api/AvToCid/" stringByAppendingString:parame];
    return [self Get:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        complete(responseObj, error);
    }];
}


+ (id)GetVideoPathWithCidData:(NSData*)data completionHandler:(void(^)(id responseObj, NSError *error))complete{
    CIDModel* cidModel = [CIDModel mj_objectWithKeyValues:[NSJSONSerialization json2DicWithData:data]];
    CIDDataModel* obj = cidModel.list.firstObject;
    return [self GetVideoPathWithCid:obj.CID Aid:obj.AV title:obj.Title completionHandler:complete];
}

+ (id)GetVideoPathWithCid:(NSString*)cid Aid:(NSString*)aid title:(NSString*)title completionHandler:(void(^)(id responseObj, NSError *error))complete{
    VideoModel* vModel = [[VideoModel alloc] init];
    
    NSString*vpath = [NSString stringWithFormat:@"http://interface.bilibili.com/playurl?platform=android&_device=android&_hwid=831fc7511fa9aff5&_tid=0&_p=1&_down=0&quality=3&otype=json&appkey=86385cdc024c0f6c&type=mp4&sign=7fed8a9b7b446de4369936b6c1c40c3f&_aid=%@&cid=%@", aid, cid];
    return [self Get: vpath parameters:nil completionHandler:^(id responseObj, NSError *error) {
        VideoDataModel*dModel = [VideoDataModel mj_objectWithKeyValues:[[NSJSONSerialization json2DicWithData:responseObj][@"durl"] firstObject]];
        dModel.cid = cid;
        dModel.title = title;
        [vModel.durl addObject: dModel];
        complete(vModel, nil);
    }];
}


+ (id)DownDanMuWithParameter:(NSString*)parame completionHandler:(void(^)(NSDictionary* responseObj, NSError *error))complete{
    //http://comment.bilibili.com/4937954.xml
    NSString* path = [[@"http://comment.bilibili.com/" stringByAppendingString:parame] stringByAppendingString:@".xml"];
    return [self Get:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
            complete([XML2Dic dicWithData:responseObj], error);
    }];
}
@end
