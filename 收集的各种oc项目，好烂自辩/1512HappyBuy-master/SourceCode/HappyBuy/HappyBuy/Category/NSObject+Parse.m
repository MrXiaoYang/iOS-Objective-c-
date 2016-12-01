//
//  NSObject+Parse.m
//  HappyBuy
//
//  Created by tarena on 16/3/30.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "NSObject+Parse.h"



@implementation NSObject (Parse)

+ (id)parseJSON:(id)json{
    //    if([json isKindOfClass:[NSDictionary class]]){
    //        return [self modelWithJSON:json];
    //    }
    if ([json isKindOfClass:[NSArray class]]) {
        return [NSArray modelArrayWithClass:[self class] json:json];
    }
    return [self modelWithJSON:json];
}

@end










