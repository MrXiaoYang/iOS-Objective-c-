//
//  BTProduct.m
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTProduct.h"
#import <MJExtension.h>
@implementation BTProduct
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"ID"]) {
        propertyName = @"id";
    }else if ([propertyName isEqualToString:@"picArray"]){
        propertyName = @"pic";
    }
    
    return [propertyName mj_underlineFromCamel];
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"picArray":[BTProductPic class],
             @"likesList":[BTProductLiker class]
             };
}


@end

@implementation BTProductLiker
@end

@implementation BTProductPic
@end
