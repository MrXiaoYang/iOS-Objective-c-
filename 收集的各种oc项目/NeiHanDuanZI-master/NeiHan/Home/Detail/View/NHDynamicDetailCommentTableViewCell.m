//
//  NHDynamicDetailCommentTableViewCell.m
//  NeiHan
//
//  Created by Charles on 16/9/3.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDynamicDetailCommentTableViewCell.h"
#import "NHHomeServiceDataModel.h"
#import "NSString+Addition.h"
#import "NHDynamicDetailCommentCellFrame.h"
#import "UIView+Layer.h"
#import "YYLabel.h"
#import "NSAttributedString+YYText.h"
#import "UIView+Tap.h"

@interface NHDynamicDetailCommentTableViewCell () <UIGestureRecognizerDelegate>
/** 头像*/
@property (nonatomic, weak) NHBaseImageView *iconImg;
/** 名字*/
@property (nonatomic, weak) UILabel *nameL;
/** 文本*/
@property (nonatomic, weak) YYLabel *contentL;
/** 时间*/
@property (nonatomic, weak) UILabel *timeL;
/** 点赞*/
@property (nonatomic, weak) UIButton *likeCountBtn;
/** 分享*/
@property (nonatomic, weak) UIButton *shareBtn;
@end

@implementation NHDynamicDetailCommentTableViewCell

- (void)setCellFrame:(NHDynamicDetailCommentCellFrame *)cellFrame {
    _cellFrame = cellFrame;
    
    NHHomeServiceDataElementComment *commentModel = cellFrame.commentModel;
    
    // 头像
    self.iconImg.frame = cellFrame.iconImgF;
    self.iconImg.layerCornerRadius = cellFrame.iconImgF.size.height / 2.0;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:commentModel.user_profile_image_url]];
    
    // 名字
    self.nameL.frame = cellFrame.nameLF;
    self.nameL.text = commentModel.user_name;
    
    // 时间
    self.timeL.frame = cellFrame.timeLF;
    self.timeL.text = [kIntegerToStr(commentModel.create_time) convertTimesTampWithDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // 点赞
//    self.likeCountBtn.frame = cellFrame.likeCountBtnF;
//    [self.likeCountBtn setTitle:kIntegerToStr(commentModel.user_bury) forState:UIControlStateNormal];
//    
//    // 分享
//    self.shareBtn.frame = cellFrame.shareBtnF;
    
    // 文本
    NSMutableString *mutableContent = [NSMutableString stringWithString:commentModel.text];
    // 记录下所有的人的名字
    NSMutableArray *replyNameArray = [NSMutableArray array];
    if (commentModel.reply_comments.count) {
        for (NHHomeServiceDataElementComment *replyComment in commentModel.reply_comments) {
            if (replyComment.text.length && replyComment.user_name.length) {
                NSString *replyName = [NSString stringWithFormat:@"//@%@：", replyComment.user_name];
                [replyNameArray addObject:replyName];
                [mutableContent appendString:replyName];
                [mutableContent appendString:replyComment.text];
            }
        }
    }
    WeakSelf(weakSelf);
    NSMutableAttributedString *attContent = [[NSMutableAttributedString alloc] initWithString:mutableContent];
    [attContent yy_setFont:kFont(16) range:NSMakeRange(0, attContent.length)];
    [attContent yy_setColor:kCommonBlackColor range:NSMakeRange(0, attContent.length)];
    for (NSString *replyName in replyNameArray) {
        NSRange range = [mutableContent rangeOfString:[replyName substringToIndex:replyName.length - 1]];
        // 筛选出来
        if (range.location != NSNotFound) {
            [attContent yy_setTextHighlightRange:range color:kCommonHighLightRedColor backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                if ([weakSelf.delegate respondsToSelector:@selector(commentTableViewCell:didClickUserNameWithCommentModel:)]) {
                    [weakSelf.delegate commentTableViewCell:weakSelf didClickUserNameWithCommentModel:weakSelf.cellFrame.commentModel];
                }
            }];
        }
    } 
    self.contentL.frame = cellFrame.contentLF;
    self.contentL.attributedText = attContent;
    
}

// 分享
- (void)shareBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(commentTableViewCell:didShareWithCommentModel:)]) {
        [self.delegate commentTableViewCell:self didShareWithCommentModel:self.cellFrame.commentModel];
    }
}

// 点赞
- (void)likeCountBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(commentTableViewCell:didLikeWithCommentModel:)]) {
        [self.delegate commentTableViewCell:self didLikeWithCommentModel:self.cellFrame.commentModel];
    }
}

- (UILabel *)timeL {
    if (!_timeL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _timeL = label;
        label.font = kFont(11);
        label.textColor = kCommonGrayTextColor;
    }
    return _timeL;
}

- (UIButton *)likeCountBtn {
    if (!_likeCountBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
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
        [self.contentView addSubview:btn];
        _shareBtn = btn;
        [btn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(13.0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [btn setImage:[UIImage imageNamed:@"moreicon_textpage"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _nameL = label;
        label.font = kFont(14);
        label.textColor = kCommonBlackColor;
    }
    return _nameL;
}

- (YYLabel *)contentL {
    if (!_contentL) {
        YYLabel *label = [[YYLabel alloc] init];
        [self.contentView addSubview:label];
        _contentL = label;
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
        WeakSelf(weakSelf);
        [img setTapActionWithBlock:^{
            if ([weakSelf.delegate respondsToSelector:@selector(commentTableViewCell:didClickUserNameWithCommentModel:)]) {
                [weakSelf.delegate commentTableViewCell:weakSelf didClickUserNameWithCommentModel:weakSelf.cellFrame.commentModel];
            }
        }];
    }
    return _iconImg;
}

@end
