//
//  VideoNetManager.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/13.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseNetManager.h"
#import "VideoModel.h"
@interface VideoNetManager : BaseNetManager
/**
 *  获取完整视频 GetCIDWithParameter和GetVideoPathWithParameter的封装
 *
 */
+ (id)GetVideoWithParameter:(NSString*)parame completionHandler:(void(^)(id responseObj, NSError *error))complete;
/**
 *  获取CID
 *
 */
+ (id)GetCIDWithParameter:(NSString*)parame completionHandler:(void(^)(id responseObj, NSError *error))complete;
/**
 *  根据cid模型获取视频路径
 *
 */
+ (id)GetVideoPathWithCidData:(NSData*)data completionHandler:(void(^)(id responseObj, NSError *error))complete;
/**
 *  根据cid获取视频路径
 *
 */
+ (id)GetVideoPathWithCid:(NSString*)cid Aid:(NSString*)aid title:(NSString*)title completionHandler:(void(^)(id responseObj, NSError *error))complete;

+ (id)DownDanMuWithParameter:(NSString*)parame completionHandler:(void(^)(NSDictionary* responseObj, NSError *error))complete;
@end
