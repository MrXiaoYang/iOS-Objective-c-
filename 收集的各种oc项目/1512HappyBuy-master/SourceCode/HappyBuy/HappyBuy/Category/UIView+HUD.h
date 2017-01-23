//
//  UIView+HUD.h
//  HappyBuy
//
//  Created by tarena on 16/3/28.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface UIView (HUD)
/** 显示文字提示 */
- (void)showWarning:(NSString *)words;
/** 显示忙提示 */
- (void)showBusyHUD;
/** 隐藏忙提示 */
- (void)hideBusyHUD;
@end









