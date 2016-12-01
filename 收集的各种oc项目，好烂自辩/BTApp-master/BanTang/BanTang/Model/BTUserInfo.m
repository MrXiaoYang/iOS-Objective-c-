//
//  BTUserInfo.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/29.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTUserInfo.h"

@implementation BTUserInfo
MJCodingImplementation
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    return [propertyName mj_underlineFromCamel];
}

@end
