//
//  NSString+Extension.m
//  BWDApp
//
//  Created by Ryan on 15/8/12.
//  Copyright (c) 2015年 Kratos. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (NSString *)imageBase64:(UIImage *)image
{
    image = [self imageWithImageSimple:image scaledToSize:CGSizeMake(200, 200)];
    
    NSData *data =[NSData data];
    if (UIImagePNGRepresentation(image)) {
        //返回为png图像。
        data = UIImagePNGRepresentation(image);
    }else {
        //返回为JPEG图像。
        data = UIImageJPEGRepresentation(image, 0.5);
    }
    NSString *base64ImageStr = [data base64EncodedStringWithOptions:0];
    base64ImageStr = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                   (CFStringRef)base64ImageStr,
                                                                                   NULL,
                                                                                   CFSTR("="),
                                                                                   kCFStringEncodingUTF8);
    return base64ImageStr;
}

/**
 *  调整发图片大小
 */
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}

/**
 *  返回单行文字大小
 *
 *  @param fontSize 字体大小
 */
- (CGSize)titleSizeWithfontSize:(CGFloat)fontSize
{
	return [self titleSizeWithfontSize:fontSize maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}

/**
 *  返回文字大小
 *
 *  @param fontSize 字体大小
 */
- (CGSize)titleSizeWithfontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize;
{
   CGSize size =   [self boundingRectWithSize:maxSize
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName : BTFont(fontSize)}
                                      context:nil].size;
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

+ (NSString *)dateStringWithCreateTimeFromString:(NSString *)createTime
{
    NSString *dateString = @"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSDate *create_date = [NSDate dateWithTimeIntervalSince1970:[createTime longLongValue]];
    
    if ([create_date rx_isToday])
    {
        formatter.dateFormat = @"HH:mm";
        dateString = [formatter stringFromDate:create_date];
    } else {
        formatter.dateFormat = @"YYYY-MM-dd";
        dateString = [formatter stringFromDate:create_date];
    }
    
    return dateString;
}


/**
 *  根据时间戳字符串返回指定格式的年月日字符串
 *
 *  @param createTime 时间戳
 *
 *  @return 返回时间字符串
 */
+ (NSString *)nyrDateStringWithCreateTimeFromString:(NSString *)createTime
{
    if (createTime.length) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSDate *create_date = [NSDate dateWithTimeIntervalSince1970:[createTime longLongValue]];
        formatter.dateFormat = @"YYYY年MM月dd日";
        NSString *dateString = [formatter stringFromDate:create_date];
        
        return dateString;
    }
    return @"";
}

/**
 *  根据指定格式的年月日字符串返回时间戳字符串
 *
 *  @param nyrDateString 年月日时间字符串
 *
 *  @return 返回时间字符串
 */
+ (NSString *)createDateStringWithNYRDateString:(NSString *)nyrDateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM月dd日"];
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate *date = [formatter dateFromString:nyrDateString];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeSp);
    return timeSp;
}
@end
