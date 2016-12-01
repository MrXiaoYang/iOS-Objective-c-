//
//  UIColor+Art.m
//  TMusic
//
//  Created by Alex Zhao on 13-8-9.
//  Copyright (c) 2013年 JimHuang. All rights reserved.
//

#import "UIColor+Art.h"

@implementation UIColor (Art)

+ (UIColor *) colorWith256Red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red / 255.0
                           green:green / 255.0
                            blue:blue / 255.0
                           alpha:alpha];
}

+ (UIColor *) colorWithHex:(long)hex
{
    return [UIColor colorWithHex:hex andAlpha:1.0];
}

+ (UIColor *) colorWithHex:(long)hex andAlpha:(float)alpha
{
    float red   = ((float)((hex & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hex & 0xFF00) >> 8))/255.0;
    float blue  = ((float)((hex & 0xFF)))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


@end
