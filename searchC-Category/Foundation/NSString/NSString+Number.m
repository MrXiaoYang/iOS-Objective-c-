//
//  NSString+Number.m
//  HongheTeacher
//
//  Created by KGART on 15/9/21.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "NSString+Number.h"

@implementation NSString (Number)

+ (BOOL)isEmpty:(NSString *)value
{
    if ((value == nil) || value == (NSString *)[NSNull null] || (value.length == 0))
    {
        return YES;
    }
    return NO;
}

+ (NSString *)ifNilToStr:(NSString *)value
{
    if ((value == nil) || (value == (NSString *)[NSNull null]))
    {
        return @"";
    }
    return value;
}

+ (NSString *)stringWithInteger:(NSInteger)value
{
    NSNumber *number = [NSNumber numberWithInteger:value];
    return [number stringValue];
}

+ (NSString *)stringWithLong:(long)value
{
    return [NSString stringWithFormat:@"%ld", value];
}

+ (NSString *)stringWithLongLong:(int64_t)value
{
    return [NSString stringWithFormat:@"%lld", value];
}

+ (NSString *)stringWithFloat:(float)value
{
    return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)stringWithDouble:(double)value
{
    return [NSString stringWithFormat:@"%lf", value];
}


@end
