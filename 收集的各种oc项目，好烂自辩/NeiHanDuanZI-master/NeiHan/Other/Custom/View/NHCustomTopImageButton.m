//
//  NHCustomTopImageButton.m
//  NeiHan
//
//  Created by Charles on 16/9/2.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHCustomTopImageButton.h"

@implementation NHCustomTopImageButton


- (instancetype)init {
    self = [super init];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.width * 2 / 3, self.height * 2 / 3.0);
    self.imageView.contentMode = UIViewContentModeCenter;
    self.imageView.centerX = self.width / 2.0;
    self.titleLabel.frame = CGRectMake(0, self.imageView.bottom, self.width, self.height - self.imageView.height);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
