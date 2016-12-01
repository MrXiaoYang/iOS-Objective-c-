//
//  NSDate+MXYExtension.h.m
//  2016年BIU~BIU~BIU
//  http://www.jianshu.com/users/f60047bf604f/latest_articles

//

#import <Foundation/Foundation.h>

@interface NSDate (MXYExtension)
/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;
@end
