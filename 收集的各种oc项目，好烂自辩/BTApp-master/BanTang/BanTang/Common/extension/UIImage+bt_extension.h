//
//  UIImage+bt_extension.h
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (bt_extension)
/**
 *  返回一张具有边界的图片
 *
 *  @param name        图片名字
 *  @param borderWidth 边界宽度
 *  @param borderColor 边界颜色
 */
- (instancetype)circleBorderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor;
@end
