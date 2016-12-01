//
//  UIBezierPath+Tools.m
//  tes
//
//  Created by JimHuang on 15/11/22.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "UIBezierPath+Tools.h"

@implementation UIBezierPath (Tools)
+ (instancetype)bezierPathWithAIFilePath:(NSString*)path{
    NSString* str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //长宽内容
    NSArray* rectArr = [[str substringWithRange:[str rangeOfString:@"\%%BoundingBox.*" options:NSRegularExpressionSearch]] componentsSeparatedByString:@" "];
    CGRect rect = CGRectMake([rectArr[1] floatValue], [rectArr[2] floatValue], [rectArr[3] floatValue], [rectArr[4] floatValue]);
    //点内容
    NSRange r1 = [str rangeOfString:@"*u" options:NSCaseInsensitiveSearch];
    NSRange r2 = [str rangeOfString:@"*u" options:NSBackwardsSearch|NSCaseInsensitiveSearch];
    NSArray<NSString*>* points = [[str substringWithRange:NSMakeRange(r1.location + r1.length, r2.location - r1.location - r1.length)] componentsSeparatedByString:@"\r"];
    
    UIBezierPath* bp = [UIBezierPath bezierPath];
    
    [points enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray<NSString*>* childPoint = [obj componentsSeparatedByString:@" "];
        if ([childPoint.lastObject localizedCaseInsensitiveContainsString:@"m"]) {
            [bp moveToPoint:CGPointMake([childPoint[0] floatValue] , rect.size.height - [childPoint[1] floatValue])];
        }else if ([childPoint.lastObject localizedCaseInsensitiveContainsString:@"l"]){
            [bp addLineToPoint:CGPointMake([childPoint[0] floatValue], rect.size.height - [childPoint[1] floatValue])];
        }else if ([@"yYvV" containsString:childPoint.lastObject]){
            [bp addQuadCurveToPoint:CGPointMake([childPoint[2] floatValue], rect.size.height - [childPoint[3] floatValue]) controlPoint:CGPointMake([childPoint[0] floatValue], rect.size.height - [childPoint[1] floatValue])];
        }else if ([childPoint.lastObject localizedCaseInsensitiveContainsString:@"c"]){
             [bp addCurveToPoint:CGPointMake([childPoint[4] floatValue] , rect.size.height - [childPoint[5] floatValue]) controlPoint1:CGPointMake([childPoint[0] floatValue] , rect.size.height - [childPoint[1] floatValue]) controlPoint2:CGPointMake([childPoint[2] floatValue] , rect.size.height - [childPoint[3] floatValue])];
        }
    }];
    return bp;
}


@end
