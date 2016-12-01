//
//  UIView+Hud.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/2.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "UIView+Hud.h"
#import <UIImage+GIF.h>
#import <MBProgressHUD.h>
#import <objc/runtime.h>

@implementation UIView (Hud)

@dynamic hud;

- (MBProgressHUD*)hud{
    
    return objc_getAssociatedObject(self, @"hud");
}

- (void)setHud:(MBProgressHUD *)hud{
    objc_setAssociatedObject(self, @"hud", hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHud{
    self.hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    UIImage *image = [UIImage sd_animatedGIFNamed:@"Loading-225px-W"];
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    gifImageView.image = image;
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.customView = gifImageView;
    self.hud.labelText = @"正在加载...";
    [self.hud show:YES];
}

- (void)hideHud{
    [self.hud hide:YES];
}

@end
