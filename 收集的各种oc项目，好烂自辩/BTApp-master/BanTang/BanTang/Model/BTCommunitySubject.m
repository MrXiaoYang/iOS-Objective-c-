//
//  ESSubject.m
//  BWDApp
//
//  Created by Ryan on 15/11/27
//  Copyright (c) Flinkinfo. All rights reserved.
//

#import "BTCommunitySubject.h"
#import <MJExtension.h>
@implementation BTCommunitySubject
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    //     nickName -> nick_name
    if ([propertyName isEqualToString:@"ID"])
    {
        propertyName = @"id";
    }else if ([propertyName isEqualToString:@"desc"])
    {
        propertyName = @"description";
    }
    
    return [propertyName mj_underlineFromCamel];
}
@end
