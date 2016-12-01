//
//  NSString+Extension.h
//  BWDApp
//
//  Created by Ryan on 15/8/12.
//  Copyright (c) 2015年 Kratos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Extension)
/**
 *  将image进行base64编码
 */
+ (NSString *)imageBase64:(UIImage *)image;

/**
 *  返回单行文字大小
 *
 *  @param fontSize 字体大小
 */
- (CGSize)titleSizeWithfontSize:(CGFloat)fontSize;

/**
 *  返回文字大小
 *
 *  @param fontSize 字体大小
 */
- (CGSize)titleSizeWithfontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize;

/**
 *  根据时间戳字符串返回指定格式的时间字符串
 *
 *  @param createTime 时间戳
 *
 *  @return 返回时间字符串
 */
+ (NSString *)dateStringWithCreateTimeFromString:(NSString *)createTime;

/**
 *  根据时间戳字符串返回指定格式的年月日字符串
 *
 *  @param createTime 时间戳
 *
 *  @return 返回时间字符串
 */
+ (NSString *)nyrDateStringWithCreateTimeFromString:(NSString *)createTime;

/**
 *  根据指定格式的年月日字符串返回时间戳字符串
 *
 *  @param nyrDateString 年月日时间字符串
 *
 *  @return 返回时间字符串
 */
+ (NSString *)createDateStringWithNYRDateString:(NSString *)nyrDateString;
@end
