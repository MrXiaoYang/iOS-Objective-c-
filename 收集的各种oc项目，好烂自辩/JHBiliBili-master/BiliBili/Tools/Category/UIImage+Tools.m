//
//  UIImage+Tools.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/4.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "UIImage+Tools.h"

@implementation UIImage (Tools)
- (UIImage*)clipImageWithRect:(CGRect)rect{
    UIGraphicsBeginImageContext(rect.size);
    
    UIBezierPath* path = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [path addClip];
    [self drawInRect:CGRectMake(-rect.origin.x, -rect.origin.y, self.size.width, self.size.height)];
    UIImage* newImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImg;
}
@end
