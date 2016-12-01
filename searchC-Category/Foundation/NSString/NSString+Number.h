//
//  NSString+Number.h
//  HongheTeacher
//
//  Created by KGART on 15/9/21.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Number)

+ (BOOL)isEmpty:(NSString *)value;
+ (NSString *)ifNilToStr:(NSString *)value;

+ (NSString *)stringWithInteger:(NSInteger)value;
+ (NSString *)stringWithLong:(long)value;
+ (NSString *)stringWithLongLong:(int64_t)value;
+ (NSString *)stringWithFloat:(float)value;
+ (NSString *)stringWithDouble:(double)value;

@end
