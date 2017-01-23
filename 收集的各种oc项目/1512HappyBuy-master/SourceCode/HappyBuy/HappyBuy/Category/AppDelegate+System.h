//
//  AppDelegate+System.h
//  TRProject
//
//  Created by jiyingxin on 16/2/25.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworkActivityIndicatorManager.h>
#import <AFNetworkReachabilityManager.h>

@interface AppDelegate (System)

- (void)setupGlobalConfig;

- (AFNetworkReachabilityStatus)netReachStatus;
- (BOOL)isOnLine;
@end
