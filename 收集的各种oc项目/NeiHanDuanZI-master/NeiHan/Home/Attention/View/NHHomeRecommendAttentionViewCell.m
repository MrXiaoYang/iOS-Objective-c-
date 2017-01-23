//
//  NHHomeRecommendAttentionViewCell.m
//  NeiHan
//
//  Created by Charles on 16/9/2.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHHomeRecommendAttentionViewCell.h"

@interface NHHomeRecommendAttentionViewCell ()
/** 名字*/
@property (nonatomic, weak) UILabel *nameL;
/** 头像*/
@property (nonatomic, weak) NHBaseImageView *iconImg;
/** 文本*/
@property (nonatomic, weak) UILabel *contentL;
/** 关注按钮*/
@property (nonatomic, weak) UIButton *attBtn;
@end

@implementation NHHomeRecommendAttentionViewCell

- (void)attBtnClick:(UIButton *)btn {
    if (self.homeRecommendAttentionViewCellAttentionHandle) {
        self.homeRecommendAttentionViewCellAttentionHandle(self);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 关注按钮
    CGFloat attW = 50;
    CGFloat attX = self.contentView.width - 15 - attW;
    CGFloat attH = 30;
    CGFloat attY = (self.height - attH) / 2.0;
    self.attBtn.frame = CGRectMake(attX, attY, attW, attH);
    self.attBtn.centerY = self.contentView.centerY;
    
    // 头像
    CGFloat iconX = 15;
    CGFloat iconY = 15;
    CGFloat iconW = 44;
    CGFloat iconH = 44;
    self.iconImg.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 名字
    CGFloat nameX = self.iconImg.right + 15;
    CGFloat nameY = 15;
    CGFloat nameW = self.contentView.width - self.iconImg.right - 15 * 2 - attW - 15;
    CGFloat nameH = 15;
    self.nameL.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    // 文本
    CGFloat contentX = nameX;
    CGFloat contentY = self.nameL.bottom + 8;
    CGFloat contentW = nameW;
    CGFloat contentH = 13;
    self.contentL.frame = CGRectMake(contentX, contentY, contentW, contentH);
}

- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _nameL = label;
        label.font = kFont(13);
        label.textColor = kTextColor;
    }
    return _nameL;
}

- (UILabel *)contentL {
    if (!_contentL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _contentL = label;
        label.font = kFont(15);
        label.textColor = kTextColor;
        label.numberOfLines = 0;
    }
    return _contentL;
}

- (NHBaseImageView *)iconImg {
    if (!_iconImg) {
        NHBaseImageView *img = [[NHBaseImageView alloc] init];
        [self.contentView addSubview:img];
        _iconImg = img;
        img.layer.masksToBounds = YES;
        img.backgroundColor = kCommonBgColor;
    }
    return _iconImg;
}

- (UIButton *)attBtn {
    if (!_attBtn) {
        UIButton *att = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:att];
        _attBtn = att;
        [att addTarget:self action:@selector(attBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        att.titleLabel.font = kFont(13);
        [att setTitleColor:[UIColor colorWithRed:0.88f green:0.54f blue:0.65f alpha:1.00f] forState:UIControlStateNormal];
        att.backgroundColor = [UIColor clearColor];
        att.layer.cornerRadius = 2.0;
        att.layer.borderColor = [UIColor colorWithRed:0.88f green:0.54f blue:0.65f alpha:1.00f].CGColor;
        att.layer.borderWidth = kLineHeight;
    }
    return _attBtn;
}
@end
