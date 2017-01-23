//
//  BTHomePageData.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTHomePageData.h"
#import <MJExtension.h>
#import "BTHomeBanner.h"
#import "BTHomeTopic.h"
#import "BTCategoryElement.h"
#import "BTFirstpageElement.h"
#import "BTEntryList.h"

@implementation BTHomePageData
MJCodingImplementation
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"banner":[BTHomeBanner class],
             @"topic":[BTHomeTopic class],
             @"categoryElement": [BTCategoryElement class],
             @"firstpageElement": [BTFirstpageElement class],
             @"entryList" : [BTEntryList class]
             };
}

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    return [propertyName mj_underlineFromCamel];
}

@end


