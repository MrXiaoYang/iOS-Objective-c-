//
//  BTHomeTopic.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTHomeTopic.h"
#import <MJExtension.h>
@implementation BTHomeTopic
MJCodingImplementation
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    //     nickName -> nick_name
    if ([propertyName isEqualToString:@"tid"])
    {
        propertyName = @"id";
    }
    
    return [propertyName mj_underlineFromCamel];
}


@end
