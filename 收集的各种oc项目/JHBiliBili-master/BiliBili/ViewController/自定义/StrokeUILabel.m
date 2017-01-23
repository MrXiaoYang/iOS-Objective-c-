//
//  StrokeUILabel.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/22.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "StrokeUILabel.h"

@implementation StrokeUILabel

- (void)drawTextInRect:(CGRect)rect{
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 2);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = [UIColor blackColor];
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
}

@end
