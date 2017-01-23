//
//  ProfileHeadView.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/20.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ProfileHeadView.h"
@interface ProfileHeadView ()
@property (nonatomic, strong) UIImage* img;
@end
@implementation ProfileHeadView

- (void)drawRect:(CGRect)rect {
    self.img = [UIImage imageNamed:@"bili_drawerbg_logined"];
    CGSize size = self.img.size;
    CGFloat scale = size.width / (self.frame.size.width / 1.5);
    size.width /= scale;
    size.height /= scale;
    [self.img drawInRect:CGRectMake(self.frame.size.width - size.width, self.frame.size.height - size.height, size.width, size.height) blendMode:kCGBlendModeOverlay alpha:0.7];
}

- (UIImage *)img{
    if (_img == nil) {
        _img = [UIImage imageNamed:@"bili_drawerbg_logined"];
    }
    return _img;
}
@end
