//
//  BTListPost.m
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTListPost.h"
#import "BTProduct.h"
#import "BTTag.h"
#import "BTListPostDynamic.h"
#import "BTSubjectAuthor.h"
#import "BTListPostPics.h"
#import <MJExtension.h>
@implementation BTListPost
+ (NSDictionary *)objectClassInArray{
    return @{@"product" : [BTProduct class],
             @"tags" : [BTTag class],
             @"pics" : [BTListPostPics class]};
}

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"ID"]) {
        propertyName = @"id";
    }
    
    return [propertyName mj_underlineFromCamel];
}
@end

