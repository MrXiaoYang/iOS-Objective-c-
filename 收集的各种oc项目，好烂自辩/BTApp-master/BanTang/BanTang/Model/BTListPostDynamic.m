//
//  BTListPostDynamic.m
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTListPostDynamic.h"
#import <MJExtension.h>
#import "BTSubjectAuthor.h"

@implementation BTListPostDynamic

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"likesUsers" : [BTSubjectAuthor class]};
}

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    return [propertyName mj_underlineFromCamel];
}
@end
