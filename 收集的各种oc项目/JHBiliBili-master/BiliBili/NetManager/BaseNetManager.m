//
//  BaseNetManager.m
//  BaseProject
//
//  Created by JimHuang on 15/10/21.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseNetManager.h"

static AFHTTPRequestOperationManager *manager = nil;
static AFURLSessionManager *URLManager = nil;

@implementation BaseNetManager

+ (AFHTTPRequestOperationManager *)sharedAFManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    });
    return manager;
}

+ (AFURLSessionManager *)sharedAFURLManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        URLManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return URLManager;
}

+ (id)Get:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
    
    return [[self sharedAFManager] GET:path parameters:params success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        complete(responseObject, nil);
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        complete(nil, error);
    }];
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete{
    return [[self sharedAFManager] POST:path parameters:params success:^void(AFHTTPRequestOperation * operation, id responseObject) {
        complete(responseObject, nil);
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        complete(nil, error);
    }];
}

+ (id)downLoad:(NSString*)path parameters:(NSDictionary *)params resumeData:(NSData*)resumeData completionHandler:(void(^)(NSURL* responseObj, NSError *error))complete{
    if (path == nil) {
        return nil;
    }
    //通过data判断文件是否正在下载
    NSURLSessionDownloadTask *downloadTask = nil;
    //重新下载
    if (resumeData == nil) {
        downloadTask = [[self sharedAFURLManager] downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]] progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            if (![[NSFileManager defaultManager] fileExistsAtPath: kDownloadPath]) {
                [[NSFileManager defaultManager] createDirectoryAtPath:kDownloadPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            return [NSURL fileURLWithPath: [kDownloadPath stringByAppendingPathComponent:[response suggestedFilename]]];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            complete(filePath, error);
        }];
    //断点续传
    }else{
        downloadTask = [[self sharedAFURLManager] downloadTaskWithResumeData:resumeData progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            if (![[NSFileManager defaultManager] fileExistsAtPath: kDownloadPath]) {
                [[NSFileManager defaultManager] createDirectoryAtPath:kDownloadPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            return [NSURL fileURLWithPath: [kDownloadPath stringByAppendingPathComponent:[response suggestedFilename]]];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            complete(filePath, error);
        }];
    }
    downloadTask.taskDescription = params[@"aid"];
    
    [downloadTask resume];
   // NSLog(@"%lu",(unsigned long)[self sharedAFURLManager].downloadTasks.count);
    return downloadTask;
}

@end
