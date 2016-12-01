//
//  UIView+HUD.h
//  HongheTeacher
//
//  Created by honey on 15/8/24.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LOADING @"努力加载中..."
@interface UIView (HUD)
- (void)showHUDLoading:(NSString *)text;
- (void)hideHUDLoading;

- (void)showHUDTip:(NSString *)tip;
- (void)showHUDTipTop:(NSString *)tip;

@end
