//
//  BaseNetManager.h
//  BaseProject
//
//  Created by JimHuang on 15/10/21.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNetManager : NSObject
+ (AFURLSessionManager*)sharedAFURLManager;
+ (AFHTTPRequestOperationManager *)sharedAFManager;
+ (id)Get:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete;
+ (id)POST:(NSString *)path parameters:(NSDictionary *)params completionHandler:(void(^)(id responseObj, NSError *error))complete;
+ (id)downLoad:(NSString*)path parameters:(NSDictionary *)params resumeData:(NSData*)resumeData completionHandler:(void(^)(NSURL* responseObj, NSError *error))complete;
@end
