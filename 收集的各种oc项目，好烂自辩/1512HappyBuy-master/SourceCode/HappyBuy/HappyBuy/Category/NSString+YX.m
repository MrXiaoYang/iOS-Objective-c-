//
//  NSString+YX.m
//  HappyBuy
//
//  Created by jiyingxin on 16/4/10.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "NSString+YX.h"

@implementation NSString (YX)

- (NSURL *)yx_URL{
    return [NSURL URLWithString:self];
}

- (NSURL *)yx_fileURL{
    return [NSURL fileURLWithPath:self];
}

- (UIImage *)yx_image{
    return [UIImage imageNamed:self];
}

- (UIImageView *)yx_imageView{
    return [[UIImageView alloc] initWithImage:self.yx_image];
}

@end
