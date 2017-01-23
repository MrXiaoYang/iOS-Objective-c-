//
//  NHCustomAlertView.h
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//  自定义alertView，类似于系统的UIAlertView

#import <UIKit/UIKit.h>

@interface NHCustomAlertView : UIView
/**
 *  自定义取消按钮点击事件
 *
 *  @param cancelBlock 可选
 */
- (void)setupCancelBlock:(BOOL (^)())cancelBlock;
/**
 *  自定义确定或者自定义按钮点击事件
 *
 *  @param touchBlock 必选
 */
- (void)setupSureBlock:(BOOL (^)())touchBlock;

/**
 *  传nil默认为app window
 */
- (void)showInView:(UIView *)view;

/**
 *  构造方法
 *
 *  @param title  内容
 *  @param cancel 取消 左边
 *  @param sure   确定 右边
 */
- (instancetype)initWithTitle:(NSString *)title cancel:(NSString *)cancel sure:(NSString *)sure;
@end
