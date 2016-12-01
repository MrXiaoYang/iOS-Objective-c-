//
//  NSObject+Parse.m
//  BaseProject
//
//  Created by yingxin on 15/12/13.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "NSObject+Parse.h"

@implementation NSObject (Parse)

+ (id)parse:(id)responseObj{
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        return [self mj_objectWithKeyValues:responseObj];
    }
    if ([responseObj isKindOfClass:[NSArray class]]) {
        return [self mj_objectArrayWithKeyValuesArray:responseObj];
    }
    return responseObj;
}

@end
