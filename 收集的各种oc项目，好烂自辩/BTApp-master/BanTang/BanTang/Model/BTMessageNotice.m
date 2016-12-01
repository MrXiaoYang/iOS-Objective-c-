//
//  BTMessageNotice.m
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTMessageNotice.h"

@implementation BTMessageNotice

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"ID"]) {
        propertyName = @"id";
    }
    
    return [propertyName mj_underlineFromCamel];
}
@end
