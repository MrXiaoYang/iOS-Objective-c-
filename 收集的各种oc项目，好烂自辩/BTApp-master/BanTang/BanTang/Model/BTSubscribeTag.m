//
//  BTSubscribeTag.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTSubscribeTag.h"

@implementation BTSubscribeTag

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"ID"]) {
        propertyName = @"id";
    }
    
    return [propertyName mj_underlineFromCamel];
}

@end
