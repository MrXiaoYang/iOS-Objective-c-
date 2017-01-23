//
//  AccountTool.h
//  LXZEALER
//
//  Created by Lonely Stone on 16/1/27.
//  Copyright © 2016年 LonelyStone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface AccountTool : NSObject

/**
 *  保存用户信息
 *
 *  @param user user obj
 */
+ (void)saveUserInformation:(User*)user;

/**
 *  获取存储的user信息
 *
 *  @return user obj
 */
+ (User*)getUserInformation;

/**
 *  删除保存的用户信息
 */
+ (void)deleteUserInfomation;

@end
