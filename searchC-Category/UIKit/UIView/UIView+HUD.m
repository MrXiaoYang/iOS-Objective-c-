//
//  UIView+HUD.m
//  HongheTeacher
//
//  Created by honey on 15/8/24.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "UIView+HUD.h"
#import "MBProgressHUD.h"
#import "NSString+PJR.h"

@implementation UIView (HUD)

- (void)showHUDLoading:(NSString *)text
{
    [self endEditing:YES];
    [MBProgressHUD hideAllHUDsForView:self animated:NO];
   
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self];
    if([text isValid])
    {
        hud.labelText = text;
    }
    hud.removeFromSuperViewOnHide = YES;
    [self addSubview:hud];
    [hud show:YES];
}
- (void)hideHUDLoading
{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}
- (void)showHUDTip:(NSString *)tip
{
    [self hideHUDLoading];
    
    [MBProgressHUD hideAllHUDsForView:self animated:NO];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self];
    CGFloat margin = 20;
    CGSize tipSize = [tip boundingRectWithSize:CGSizeMake(self.frame.size.width- 4*margin, 200) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:hud.labelFont} context:nil].size;
    
    UIView *labelView = [[UIView alloc]initWithFrame:CGRectMake(margin, margin, tipSize.width, tipSize.height)];
    labelView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tipSize.width, tipSize.height)];
    label.text = tip;
    label.font = hud.labelFont;
    label.textColor = hud.labelColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [labelView addSubview:label];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = labelView;
    hud.removeFromSuperViewOnHide = YES;
    [self addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:2.0];
}

- (void)showHUDTipTop:(NSString *)tip
{
    [self hideHUDLoading];
    
    [MBProgressHUD hideAllHUDsForView:self animated:NO];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self];
    hud.yOffset = -100;
    CGFloat margin = 20;
    CGSize tipSize = [tip boundingRectWithSize:CGSizeMake(self.frame.size.width- 4*margin, 200) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:hud.labelFont} context:nil].size;
    
    UIView *labelView = [[UIView alloc]initWithFrame:CGRectMake(margin, margin, tipSize.width, tipSize.height)];
    labelView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tipSize.width, tipSize.height)];
    label.text = tip;
    label.font = hud.labelFont;
    label.textColor = hud.labelColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [labelView addSubview:label];
    
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = labelView;
    hud.removeFromSuperViewOnHide = YES;
    [self addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:2.0];
}

@end
