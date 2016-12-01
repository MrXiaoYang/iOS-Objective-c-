//
//  BTPlatformInfo.m
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTPlatformInfo.h"

@implementation BTPlatformInfo
MJCodingImplementation
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    return [propertyName mj_underlineFromCamel];
}
@end
