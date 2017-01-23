//
//  UIColor+Art.h
//  TMusic
//
//  Created by Alex Zhao on 13-8-9.
//  Copyright (c) 2013年 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Art)

+ (UIColor *) colorWith256Red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;
+ (UIColor *) colorWithHex:(long)hex;
+ (UIColor *) colorWithHex:(long)hex andAlpha:(float)alpha;
@end
