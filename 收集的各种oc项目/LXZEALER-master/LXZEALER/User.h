//
//  User.h
//  LXZEALER
//
//  Created by Lonely Stone on 16/1/27.
//  Copyright © 2016年 LonelyStone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

/**
 *  用户id
 */
@property (nonatomic, assign) NSInteger id;
/**
 *  用户大头像
 */
@property (nonatomic, copy) NSString *avatar_large;

/**
 *  用户个性签名
 */
@property (nonatomic, copy) NSString *userDescription;

/**
 *  用户名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  性别  m / man
 */
@property (nonatomic, copy) NSString *gender;

@end

