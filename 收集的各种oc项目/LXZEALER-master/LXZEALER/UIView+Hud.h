//
//  UIView+Hud.h
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/2.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface UIView (Hud)

@property (nonatomic, strong) MBProgressHUD * hud;

- (void)showHud;

- (void)hideHud;

@end
