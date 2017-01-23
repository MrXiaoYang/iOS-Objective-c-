//
//  UIBarButtonItem+KPLBlocks.h
//  开发中用到的文件
//
//  Created by apple on 17/1/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPLDefine.h"

@interface UIBarButtonItem (KPLBlocks)

//  系统
- (instancetype)kpl_initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemStyle handler:(void(^)(id sender))handler KPL_INITIALIZER;
//  标题
- (instancetype)kpl_initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style handler:(void(^)(id sender))handler KPL_INITIALIZER;
//  图片
- (instancetype)kpl_initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style handler:(void(^)(id sender))handler KPL_INITIALIZER;
//  横竖
- (instancetype)kpl_initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style handler:(void(^)(id sender))handler KPL_INITIALIZER;

@end
