//
//  NHHomeTableViewCellGifImageView.m
//  NeiHan
//
//  Created by Charles on 16/9/9.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHHomeTableViewCellGifImageView.h"
#import "UIView+Layer.h"

@interface NHHomeTableViewCellGifImageView ()
/** GIF*/
@property (nonatomic, weak) UILabel *gifFlagL;
@end

@implementation NHHomeTableViewCellGifImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.gifFlagL.text = @" GIF";
    }
    return self;
}

- (UILabel *)gifFlagL {
    if (!_gifFlagL) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _gifFlagL = label;
        label.textColor = kWhiteColor;
        label.backgroundColor = [kBlackColor colorWithAlphaComponent:0.6];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = kFont(14);
        WeakSelf(weakSelf);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).mas_offset(-10);
            make.bottom.equalTo(weakSelf).mas_offset(2);
            make.size.mas_equalTo(CGSizeMake(50, 18));
        }];
        label.layerCornerRadius = 5.0;
    }
    return _gifFlagL;
}

@end
