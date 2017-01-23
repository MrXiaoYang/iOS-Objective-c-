//
//  NHPublishSelectDraftTableViewCell.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHPublishSelectDraftTableViewCell.h"
#import "NHPublishSelectDraftModel.h"

@interface NHPublishSelectDraftTableViewCell ()
/** 头像*/
@property (nonatomic, weak) NHBaseImageView *iconImg;
/** 名字*/
@property (nonatomic, weak) UILabel *nameL;
/** 内容*/
@property (nonatomic, weak) UILabel *contentL;
/** 只能投*/
@property (nonatomic, weak) UILabel *limitL;
@end

@implementation NHPublishSelectDraftTableViewCell

- (void)setModel:(NHPublishSelectDraftModel *)model {
    _model = model;
    
    // 名字
    if (model.name) {
        self.nameL.text = model.name;
    }
    
    // 限制
    NSString *allow_video = model.allow_video ? @"视频、" : @"";
    NSString *allow_image = model.allow_text ? @"图片、" : @"";
    NSString *allow_text = model.allow_text ? @"文字、": @"";
    NSString *allow_gif = model.allow_text ? @"gif" : @"";
    NSString *text = [NSString stringWithFormat:@"%@%@%@%@",allow_video, allow_image, allow_text, allow_gif];
    if (text.length) {
        self.limitL.text = [NSString stringWithFormat:@"只能投%@",text];
    } else {
        self.limitL.text = @"";
    }
    
    // 文本
    self.contentL.text = [NSString stringWithFormat:@"%ld段友期待你的投稿", model.subscribe_count];
    
    // 头像
    if (model.icon) {
        [self.iconImg setImageWithURL:[NSURL URLWithString:model.icon]];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 头像
    CGFloat iconX = 15;
    CGFloat iconY = 15;
    CGFloat iconW = 44;
    CGFloat iconH = 44;
    self.iconImg.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 名字
    CGFloat nameX = self.iconImg.right + 15;
    CGFloat nameY = 15;
    CGFloat nameW = self.contentView.width - self.iconImg.right - 15 * 2;
    CGFloat nameH = 15;
    self.nameL.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    // 文本
    CGFloat contentX = nameX;
    CGFloat contentY = self.iconImg.bottom - 18;
    CGFloat contentW = nameW;
    CGFloat contentH = 13;
    self.contentL.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
    // 限制
    CGFloat limitX = kScreenWidth - 150;
    CGFloat limitY = 0;
    CGFloat limitW = 150;
    CGFloat limitH = 13;
    self.limitL.frame = CGRectMake(limitX, limitY, limitW, limitH);
    self.limitL.centerY = self.contentView.centerY;
    
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
        label.font = kFont(12);
        label.textColor = kTextColor;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _contentL;
}

- (UILabel *)limitL {
    if (!_limitL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _limitL = label;
        label.font = kFont(10);
        label.textColor = kCommonGrayTextColor;
    }
    return _limitL;
}

- (NHBaseImageView *)iconImg {
    if (!_iconImg) {
        NHBaseImageView *img = [[NHBaseImageView alloc] init];
        [self.contentView addSubview:img];
        _iconImg = img;
        img.layer.masksToBounds = YES;
        img.backgroundColor = kCommonGrayTextColor;
    }
    return _iconImg;
}
@end
