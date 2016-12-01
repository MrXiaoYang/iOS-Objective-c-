//
//  BTRedSopt.m
//  BanTang
//
//  Created by 沈文涛 on 15/12/6.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTRedSopt.h"
#import "BTFirstpageElement.h"
@implementation BTRedSpot

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    return [propertyName mj_underlineFromCamel];
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"element":[BTFirstpageElement class]};
}

@end
