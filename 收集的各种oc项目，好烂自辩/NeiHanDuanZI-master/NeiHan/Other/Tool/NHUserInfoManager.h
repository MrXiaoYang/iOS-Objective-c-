//
//  NHUserInfoManager.h
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//  用户信息管理类

#import <Foundation/Foundation.h>
#import "NHNeiHanUserInfoModel.h"

@interface NHUserInfoManager : NSObject

+ (instancetype)sharedManager;

/**
 *  登录成功
 */
- (void)didLoginInWithUserInfo:(id)userInfo;

/**
 *  退出
 */
- (void)didLoginOut;

/**
 *  获取用户信息
 */
- (NHNeiHanUserInfoModel *)currentUserInfo;

/**
 *  更新缓存中的用户信息
 */
- (void)resetUserInfoWithUserInfo:(NHNeiHanUserInfoModel *)userInfo;

/**
 *  用来记录是否是登陆状态
 */
@property (nonatomic, assign) BOOL isLogin;

@end
