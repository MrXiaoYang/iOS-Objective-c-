//
//  NHHomeTableViewCellCommentView.m
//  NeiHan
//
//  Created by Charles on 16/9/6.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHHomeTableViewCellCommentView.h"
#import "NHHomeServiceDataModel.h"
#import "NSAttributedString+Size.h"
#import "UIView+Layer.h"
#import "NSString+Addition.h"
#import "YYLabel.h"
#import "UIView+Tap.h"
#import "NSAttributedString+YYText.h"

@interface NHHomeTableViewCellCommentView ()

/** 头像*/
@property (nonatomic, weak) UIImageView *iconImg;
/** 名字*/
@property (nonatomic, weak) UILabel *nameL;
/** 文本*/
@property (nonatomic, weak) UILabel *contentL;
/** 点赞*/
@property (nonatomic, weak) UIButton *likeCountBtn;
/** 分享*/
@property (nonatomic, weak) UIButton *shareBtn;
@end

@implementation NHHomeTableViewCellCommentView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    }
    return self;
}

- (void)setComment:(NHHomeServiceDataElementComment *)comment {
    _comment = comment;
    
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:comment.user_profile_image_url]];
    self.nameL.text = comment.user_name;
    self.contentL.attributedText = [NHUtils attStringWithString:comment.text keyWord:nil];
    [self.likeCountBtn setTitle:kIntegerToStr(comment.user_bury) forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 头像
    CGFloat iconX = 20;
    CGFloat iconY = 15;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconImg.frame = CGRectMake(iconX, iconY, iconW, iconH);
    self.iconImg.layerCornerRadius = iconH / 2.0;
    
    // 名字
    CGFloat nameH = 15;
    CGFloat nameX = CGRectGetMaxX(self.iconImg.frame) + 10;
    CGFloat nameY = 15;
    CGFloat nameW = self.width - nameX - 40 * 2;
    self.nameL.frame = CGRectMake(nameX, nameY, nameW, nameH);
    self.nameL.centerY = self.iconImg.centerY;
    
    // 分享
//    CGFloat shareW = 35;
//    CGFloat shareX = self.width - shareW;
//    CGFloat shareY = nameY;
//    CGFloat shareH = 35;
//    self.shareBtn.frame = CGRectMake(shareX, shareY, shareW, shareH);
//    
//    // 点赞
//    CGFloat likeBtnY = shareY;
//    CGFloat likeBtnW = shareW;
//    CGFloat likeBtnX = CGRectGetMinX(self.shareBtn.frame) - shareW - 15;
//    CGFloat likeBtnH = shareH;
//    self.likeCountBtn.frame = CGRectMake(likeBtnX, likeBtnY, likeBtnW, likeBtnH);
    
    // 文本
    CGFloat contentX = self.iconImg.right + 5;
    CGFloat contentY = CGRectGetMaxY(self.iconImg.frame);
    CGFloat contentW = self.width - nameX - 30;
    CGFloat contentH = [[NHUtils attStringWithString:self.comment.text keyWord:nil] heightWithConstrainedWidth:contentW];
    self.contentL.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
}

- (UIButton *)likeCountBtn {
    if (!_likeCountBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _likeCountBtn = btn;
        [btn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(13.0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [btn setImage:[UIImage imageNamed:@"digupicon_comment"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn addTarget:self action:@selector(likeCountBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeCountBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _shareBtn = btn;
        btn.titleLabel.font = kFont(13.0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [btn setImage:[UIImage imageNamed:@"moreicon_textpage"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

// 分享
- (void)shareBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(homeTableViewCellCommentView:didShareWithCommentModel:)]) {
        [self.delegate homeTableViewCellCommentView:self didShareWithCommentModel:self.comment];
    }
}

// 点赞
- (void)likeCountBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(homeTableViewCellCommentView:didLikeWithCommentModel:)]) {
        [self.delegate homeTableViewCellCommentView:self didLikeWithCommentModel:self.comment];
    }
}

- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _nameL = label;
        label.font = kFont(14);
        label.textColor = kCommonBlackColor;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameL;
}

- (UILabel *)contentL {
    if (!_contentL) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _contentL = label;
        label.font = kFont(16);
        label.textColor = kCommonBlackColor;
        label.numberOfLines = 0;
        WeakSelf(weakSelf);
        [label setTapActionWithBlock:^{
            if ([weakSelf.delegate respondsToSelector:@selector(homeTableViewCellCommentView:didReplyWithCommentModel:)]) {
                [weakSelf.delegate homeTableViewCellCommentView:weakSelf didReplyWithCommentModel:weakSelf.comment];
            }
        }];
    }
    return _contentL;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        UIImageView *img = [[UIImageView alloc] init];
        [self addSubview:img];
        _iconImg = img;
        img.layer.masksToBounds = YES;
        img.backgroundColor = kCommonBgColor;
    }
    return _iconImg;
}

@end
