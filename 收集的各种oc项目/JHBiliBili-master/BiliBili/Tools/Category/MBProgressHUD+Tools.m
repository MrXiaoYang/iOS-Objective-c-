//
//  MBProgressHUD+Tools.m
//  BiliBili
//
//  Created by JimHuang on 16/2/24.
//  Copyright © 2016年 JimHuang. All rights reserved.
//

#import "MBProgressHUD+Tools.h"

@implementation MBProgressHUD (Tools)
+ (void)showMsg:(NSString *)msg WithView:(UIView *)view{
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    progressHUD.mode = MBProgressHUDModeText;
    progressHUD.labelText = msg;
    [progressHUD hide:YES afterDelay: 1];
}
@end
