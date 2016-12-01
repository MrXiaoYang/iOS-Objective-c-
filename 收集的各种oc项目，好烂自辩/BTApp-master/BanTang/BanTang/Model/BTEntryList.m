//
//  BTEntryList.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTEntryList.h"
#import <MJExtension.h>
@implementation BTEntryList
MJCodingImplementation
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    //     nickName -> nick_name
    if ([propertyName isEqualToString:@"idString"])
    {
        propertyName = @"id";
    }else if ([propertyName isEqualToString:@"desc"])
    {
        propertyName = @"description";
    }
    
    return [propertyName mj_underlineFromCamel];
}
@end
