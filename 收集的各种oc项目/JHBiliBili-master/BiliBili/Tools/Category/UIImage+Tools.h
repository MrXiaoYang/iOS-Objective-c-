//
//  UIImage+Tools.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/4.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UIImage (Tools)
//获取图片的一部分
- (UIImage*)clipImageWithRect:(CGRect)rect;
@end
