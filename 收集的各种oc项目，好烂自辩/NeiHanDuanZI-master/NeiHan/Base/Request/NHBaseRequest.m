//
//  NHBaseRequest.m
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseRequest.h"
#import "NHRequestManager.h"
#import "MJExtension.h"
#import "NSString+Addition.h"
#import "NSDictionary+Addition.h"
#import "AFNetworkReachabilityManager.h"
#import "NSNotificationCenter+Addition.h"
//#import "NSString+Addition.h"

@implementation NHBaseRequest

#pragma mark - 构造
+ (instancetype)nh_request {
    return [[self alloc] init];
}

+ (instancetype)nh_requestWithUrl:(NSString *)nh_url {
    return [self nh_requestWithUrl:nh_url isPost:NO];
}

+ (instancetype)nh_requestWithUrl:(NSString *)nh_url isPost:(BOOL)nh_isPost {
    return [self nh_requestWithUrl:nh_url isPost:nh_isPost delegate:nil];
}

+ (instancetype)nh_requestWithUrl:(NSString *)nh_url isPost:(BOOL)nh_isPost delegate:(id <NHBaseRequestReponseDelegate>)nh_delegate {
    NHBaseRequest *request = [self nh_request];
    request.nh_url = nh_url;
    request.nh_isPost = nh_isPost;
    request.nh_delegate = nh_delegate;
    return request;
}

#pragma mark - 发送请求
- (void)nh_sendRequest {
    [self nh_sendRequestWithCompletion:nil];
}

- (void)nh_sendRequestWithCompletion:(NHAPIDicCompletion)completion {
    
    // 链接
    NSString *urlStr = self.nh_url;
    if (urlStr.length == 0) return ;
    
    // 参数
    NSDictionary *params = [self params];
    
    // 普通POST请求
    if (self.nh_isPost) {
        if (self.nh_imageArray.count == 0) {
            // 开始请求
            [NHRequestManager POST:[urlStr noWhiteSpaceString] parameters:params responseSeializerType:NHResponseSeializerTypeJSON success:^(id responseObject) {
                
                // 处理数据
                [self handleResponse:responseObject completion:completion];
            } failure:^(NSError *error) {
                // 数据请求失败，暂时不做处理
            }];
        }
        
    } else { // 普通GET请求
        // 开始请求
        [NHRequestManager GET:[urlStr noWhiteSpaceString] parameters:params responseSeializerType:NHResponseSeializerTypeJSON success:^(id responseObject) {
            
            // 处理数据
            [self handleResponse:responseObject completion:completion];
        } failure:^(NSError *error) {
            // 数据请求失败，暂时不做处理
        }];
    }
    
    // 上传图片
    if (self.nh_imageArray.count) {
        [NHRequestManager POST:[urlStr noWhiteSpaceString] parameters:params responseSeializerType:NHResponseSeializerTypeJSON constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSInteger imgCount = 0;
            for (UIImage *image in self.nh_imageArray) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
                NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
//                [NSString stringWithFormat:@"uploadFile%@",@(imgCount)]
                [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"file" fileName:fileName mimeType:@"image/png"];
                imgCount++;
            }
        } success:^(id responseObject) {
            // 处理数据
            [self handleResponse:responseObject completion:completion];
        } failure:^(NSError *error) {
            // 数据请求失败，暂时不做处理
        }];
    }
}

- (void)handleResponse:(id)responseObject completion:(NHAPIDicCompletion)completion {
    // 接口约定，如果message为retry即重试
    if ([responseObject[@"message"] isEqualToString:@"retry"]) {
        [self nh_sendRequestWithCompletion:completion];
        return  ;
    }
    
    // 数据请求成功回调
    BOOL success = [responseObject[@"message"] isEqualToString:@"success"];
    if (completion) {
        completion(responseObject[@"data"], success, @"");
    } else if (self.nh_delegate) {
        if ([self.nh_delegate respondsToSelector:@selector(requestSuccessReponse:response:message:)]) {
            [self.nh_delegate requestSuccessReponse:success response:responseObject[@"data"] message:@""];
        }
    }
    // 请求成功，发布通知
    [NSNotificationCenter postNotification:kNHRequestSuccessNotification];
}

// 设置链接
- (void)setNh_url:(NSString *)nh_url {
    if (nh_url.length == 0 || [nh_url isKindOfClass:[NSNull class]]) {
        return ;
    }
    _nh_url = nh_url;
}

- (NSDictionary *)params {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"tag"] = @"joke";
    params[@"iid"] = @"5316804410";
    params[@"os_version"] = @"9.3.4";
    params[@"os_api"] = @"18";
    
    params[@"app_name"] = @"joke_essay";
    params[@"channel"] = @"App Store";
    params[@"device_platform"] = @"iphone";
    params[@"idfa"] = @"832E262C-31D7-488A-8856-69600FAABE36";
    params[@"live_sdk_version"] = @"120";
    
    params[@"vid"] = @"4A4CBB9E-ADC3-426B-B562-9FC8173FDA52";
    params[@"openudid"] = @"cbb1d9e8770b26c39fac806b79bf263a50da6666";
    params[@"device_type"] = @"iPhone 6 Plus";
    params[@"version_code"] = @"5.5.0";
    params[@"ac"] = @"WIFI";
    params[@"screen_width"] = @"1242";
    params[@"device_id"] = @"10752255605";
    params[@"aid"] = @"7";
    params[@"count"] = @"50";
    params[@"max_time"] = [NSString stringWithFormat:@"%.2f", [[NSDate date] timeIntervalSince1970]];
    
    [params addEntriesFromDictionary:self.mj_keyValues];
    
    if ([params.allKeys containsObject:@"nh_delegate"]) {
        [params removeObjectForKey:@"nh_delegate"];
    }
    if ([params.allKeys containsObject:@"nh_isPost"]) {
        [params removeObjectForKey:@"nh_isPost"];
    }
    if ([params.allKeys containsObject:@"nh_url"]) {
        [params removeObjectForKey:@"nh_url"];
    }
    if (self.nh_imageArray.count == 0) {
        if ([params.allKeys containsObject:@"nh_imageArray"]) {
            [params removeObjectForKey:@"nh_imageArray"];
        }
    }
    return params;
}

@end