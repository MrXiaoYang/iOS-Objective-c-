//
//  UIImageView+Extension.m
//  BanTang
//
//  Created by Ryan on 16/1/8.
//  Copyright © 2016年 Ryan. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

- (void)fadeImageWithUrl:(NSString *)url
{
    [self yy_setImageWithURL:[NSURL URLWithString:url]
                 placeholder:[UIImage imageNamed:@"default_image"]
                     options:YYWebImageOptionSetImageWithFadeAnimation |
                             YYWebImageOptionProgressiveBlur           |
                             YYWebImageOptionShowNetworkActivity
                  completion:nil];
}

@end
