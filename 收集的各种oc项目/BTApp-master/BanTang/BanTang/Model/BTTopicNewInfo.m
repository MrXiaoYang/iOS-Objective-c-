//
//  BTTopicNewInfo.m
//  BanTang
//
//  Created by Ryan on 15/12/1.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTTopicNewInfo.h"
#import "BTProduct.h"
@implementation BTTopicNewInfo
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"ID"]) {
        propertyName = @"id";
    }
    
    return [propertyName mj_underlineFromCamel];
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"product":[BTProduct class]
             };
}
@end
@implementation Activity

@end


