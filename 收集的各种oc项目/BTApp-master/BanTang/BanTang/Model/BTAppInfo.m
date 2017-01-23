//
//  BTAppInfo.m
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTAppInfo.h"
#import "BTPlatformInfo.h"
@implementation BTAppInfo

MJCodingImplementation

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    return [propertyName mj_underlineFromCamel];
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"webSearch":[BTPlatformInfo class]};
}

@end

