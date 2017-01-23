//
//  UIViewController+Addition.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Addition)

/**
 *  判断是否是正在显示的控制器
 */
- (BOOL)isCurrentAndVisibleViewController;

- (void)pushToNextViewController:(UIViewController *)nextVC;

@end
