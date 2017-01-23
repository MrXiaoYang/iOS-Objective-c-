//
//  NHUserInfoManager.m
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHUserInfoManager.h"
#import "NHNeiHanUserInfoModel.h"
#import "NHFileCacheManager.h"

static NHUserInfoManager *_singleton = nil;
@implementation NHUserInfoManager

+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[NHUserInfoManager alloc] init];
    });
    return _singleton;
}

// 当前用户信息
- (NHNeiHanUserInfoModel *)currentUserInfo {
    
    id obj = [NHFileCacheManager getObjectByFileName:NSStringFromClass([NHNeiHanUserInfoModel class])];
    if (obj != nil) {
        return  obj;
    }
    return nil;
}

// 重置用户信息
- (void)resetUserInfoWithUserInfo:(NHNeiHanUserInfoModel *)userInfo {
    [userInfo archive];
}

// 登陆
- (void)didLoginInWithUserInfo:(id)userInfo {
    
    NHNeiHanUserInfoModel *userinfo = [NHNeiHanUserInfoModel modelWithDictionary:userInfo];
    [userinfo archive];
    
    [NHFileCacheManager saveUserData:@YES forKey:kNHHasLoginFlag];
}

// 退出登陆
- (void)didLoginOut {
    [NHFileCacheManager removeObjectByFileName:NSStringFromClass([NHNeiHanUserInfoModel class])];
    
    [NHFileCacheManager saveUserData:@NO forKey:kNHHasLoginFlag];
}

// 判断是否是登陆状态
- (BOOL)isLogin {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kNHHasLoginFlag];
}

@end
