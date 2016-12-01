//
//  BTSubjectDynamic.m
//  BWDApp
//
//  Created by Ryan on 15/11/27
//  Copyright (c) Flinkinfo. All rights reserved.
//

#import "BTSubjectDynamic.h"
#import "BTSubjectAuthor.h"
#import "BTSubjectRankAuthor.h"
#import <MJExtension.h>
@implementation BTSubjectDynamic

+ (NSDictionary *)objectClassInArray{
    return @{@"rankList" : [BTSubjectRankAuthor class]};
}

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    return [propertyName mj_underlineFromCamel];
}
@end
