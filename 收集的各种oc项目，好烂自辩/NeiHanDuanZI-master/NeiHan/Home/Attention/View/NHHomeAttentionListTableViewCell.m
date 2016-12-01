//
//  NHHomeAttentionListTableViewCell.m
//  NeiHan
//
//  Created by Charles on 16/8/31.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHHomeAttentionListTableViewCell.h"
#import "NHHomeAttentionListModel.h"
#import "UIView+Layer.h"
#import "UIView+Tap.h"

@interface NHHomeAttentionListTableViewCell ()
/** 头像*/
@property (nonatomic, weak) NHBaseImageView *iconImg;
/** 名字*/
@property (nonatomic, weak) UILabel *nameL;
/** 文本*/
@property (nonatomic, weak) UILabel *contentL;
/** 关注按钮*/
@property (nonatomic, weak) UIButton *attBtn;
/** 点击关注loading视图*/
@property (nonatomic, weak) UIActivityIndicatorView *loadingView;
/** 关注标签*/
@property (nonatomic, weak) UILabel *animationLabel;
@end
@implementation NHHomeAttentionListTableViewCell

- (void)setModel:(NHHomeAttentionListModel *)model {
    _model = model;
    
    // 名字
    if (model.name.length) {
        self.nameL.text = model.name;
    }
    
    // 文本
    if (model.last_update.length) {
        self.contentL.text = model.last_update;
    }
    
    // 头像
    [self.iconImg setImageWithURL:[NSURL URLWithString:model.avatar_url]];
    self.iconImg.layerCornerRadius = self.iconImg.height / 2.0;
    
    if ([NHUtils isCurrentUserWithUserId:model.user_id]) {
        self.attBtn.hidden = YES;
    } else {
        // 关注按钮
        if (model.is_following) {
            [self.attBtn setTitle:@"已关注" forState:UIControlStateNormal];
            self.attBtn.layerBorderColor = kCommonGrayTextColor;
            [self.attBtn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
        } else {
            [self.attBtn setTitle:@"关注" forState:UIControlStateNormal];
            self.attBtn.layerBorderColor = kCommonHighLightRedColor;
            [self.attBtn setTitleColor:kCommonHighLightRedColor forState:UIControlStateNormal];
        }
    }
}

// 关注成功或者取消关注成功
- (void)attSuccessWithAttFlag:(BOOL)flag { // 关注按钮
    [self.loadingView removeFromSuperview];
    if (flag) {
        [self.attBtn setTitle:@"已关注" forState:UIControlStateNormal];
        self.attBtn.layerBorderColor = kCommonGrayTextColor;
        [self.attBtn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
    } else {
        [self.attBtn setTitle:@"关注" forState:UIControlStateNormal];
        self.attBtn.layerBorderColor = kCommonHighLightRedColor;
        [self.attBtn setTitleColor:kCommonHighLightRedColor forState:UIControlStateNormal];
    }
}

- (void)attBtnClick:(UIButton *)btn {
    
    if (self.model.is_followed == 0) {
        [btn setTitle:@"" forState:UIControlStateNormal];
        self.attBtn.layerBorderColor = kClearColor;
        self.loadingView.hidden = NO;
        self.animationLabel.hidden = NO;
        [self.loadingView startAnimating];
        
        [UIView animateWithDuration:1.0 animations:^{
            
            self.animationLabel.transform = CGAffineTransformMakeScale(0.9, 0.9);
            self.animationLabel.y = - 40;
            self.animationLabel.alpha = 0.2;
        } completion:^(BOOL finished) {
            _animationLabel.alpha = 0.0;
            [_animationLabel removeFromSuperview];
        }];
    } else {
        [btn setTitle:@"" forState:UIControlStateNormal];
        self.loadingView.hidden = NO;
        self.animationLabel.hidden = NO;
        [self.loadingView startAnimating];
    }
    if ([self.delegate respondsToSelector:@selector(homeAttentionListTableViewCellDidClickAttention:)]) {
        [self.delegate homeAttentionListTableViewCellDidClickAttention:self];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 关注
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
    
    // 描述
    CGFloat contentX = nameX;
    CGFloat contentY = self.nameL.bottom + 8;
    CGFloat contentW = nameW;
    CGFloat contentH = 13;
    self.contentL.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
    self.loadingView.frame = CGRectMake(self.attBtn.width / 2.0 - 15, self.attBtn.height / 2.0 - 15, 30, 30);
    self.animationLabel.frame = self.attBtn.bounds;
    
}

- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _nameL = label;
        label.font = kFont(15);
        label.textColor = kTextColor;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameL;
}

- (UILabel *)contentL {
    if (!_contentL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _contentL = label;
        label.font = kFont(13);
        label.textColor = kTextColor;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _contentL;
}

- (UILabel *)animationLabel {
    if (!_animationLabel) {
        UILabel *animation = [[UILabel alloc] init];
        [self.attBtn addSubview:animation];
        animation.textAlignment = NSTextAlignmentCenter;
        _animationLabel = animation;
        animation.textColor = kOrangeColor;
        animation.font = kFont(13);
        animation.adjustsFontSizeToFitWidth = YES;
        animation.text = @"关注";
        animation.hidden = YES;
    }
    return _animationLabel;
}

- (NHBaseImageView *)iconImg {
    if (!_iconImg) {
        NHBaseImageView *img = [[NHBaseImageView alloc] init];
        [self.contentView addSubview:img];
        _iconImg = img;
        img.layer.masksToBounds = YES;
        img.backgroundColor = kCommonGrayTextColor;
        WeakSelf(weakSelf);
        [img setTapActionWithBlock:^{
            if ([weakSelf.delegate respondsToSelector:@selector(homeAttentionListTableViewCell:didGotoPersonalCenterWithUserId:)]) {
                [weakSelf.delegate homeAttentionListTableViewCell:weakSelf didGotoPersonalCenterWithUserId:weakSelf.model.user_id];
            }
        }];
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

- (UIActivityIndicatorView *)loadingView {
    if (!_loadingView) {
        UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.attBtn addSubview:loading];
        _loadingView = loading;
        loading.hidden = YES;
    }
    return _loadingView;
}
@end
