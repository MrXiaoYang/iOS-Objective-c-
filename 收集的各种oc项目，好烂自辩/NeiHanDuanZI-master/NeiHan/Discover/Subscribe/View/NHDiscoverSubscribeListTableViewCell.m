//
//  NHDiscoverSubscribeListTableViewCell.m
//  NeiHan
//
//  Created by Charles on 16/9/4.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDiscoverSubscribeListTableViewCell.h"
#import "NHDiscoverModel.h"
#import "NSAttributedString+Size.h"
#import "NSString+Size.h"

@interface NHDiscoverSubscribeListTableViewCell ()

/** 头像*/
@property (nonatomic, weak) NHBaseImageView *iconImg;
/** 名字 / 标题*/
@property (nonatomic, weak) UILabel *nameL;
/** 文本*/
@property (nonatomic, weak) UILabel *contentL;
/** 更新*/
@property (nonatomic, weak) UILabel *updateCountL;
@end

@implementation NHDiscoverSubscribeListTableViewCell

- (void)setElementModel:(NHDiscoverCategoryElement *)elementModel {
    _elementModel = elementModel;
    
    // 头像
    [self.iconImg setImageWithURL:[NSURL URLWithString:elementModel.icon_url]];
    
    // 名字
    self.nameL.text = elementModel.name;
    
    // 文本
    self.contentL.text = elementModel.intro;
    
    // 今日更新
    NSString *string = [NSString stringWithFormat:@"今日更新 %ld", elementModel.today_updates];
    NSMutableAttributedString *updateStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:@"今日更新 "];
    NSRange countRange = NSMakeRange(range.length, string.length - range.length);
    [updateStr addAttribute:NSFontAttributeName value:kFont(14) range:countRange];
    [updateStr addAttribute:NSForegroundColorAttributeName value:kCommonHighLightRedColor range:countRange];
    [updateStr addAttribute:NSFontAttributeName value:kFont(13) range:range];
    [updateStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.61f green:0.61f blue:0.61f alpha:1.00f] range:range];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentRight;
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    [updateStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
    self.updateCountL.attributedText = updateStr;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 头像
    CGFloat iconX = 15;
    CGFloat iconY = 15;
    CGFloat iconH = self.contentView.height - iconY * 2;
    CGFloat iconW = iconH;
    self.iconImg.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 名字/标题
    CGFloat nameW = [self.nameL.text widthWithFont:self.nameL.font constrainedToHeight:15];
    CGFloat nameX = self.iconImg.right + 15;
    CGFloat nameY = 15;
    CGFloat nameH = 15;
    self.nameL.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    // 更新
    CGFloat updateW = kScreenWidth - self.nameL.right - 15;
    CGFloat updateX = kScreenWidth - updateW - 15;
    CGFloat updateY = 15;
    CGFloat updateH = 14;
    self.updateCountL.frame = CGRectMake(updateX, updateY, updateW, updateH);
    
    // 文本
    CGFloat contentX = nameX;
    CGFloat contentY = self.nameL.bottom + 5;
    CGFloat contentW = kScreenWidth - self.iconImg.right - 70 - 15 * 2;
    CGFloat contentH = nameH;
    self.contentL.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
}

- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _nameL = label;
        label.font = kFont(15);
        label.textColor = kCommonBlackColor;
    }
    return _nameL;
}

- (UILabel *)contentL {
    if (!_contentL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _contentL = label;
        label.font = kFont(14);
        label.textColor = [UIColor colorWithRed:0.61f green:0.61f blue:0.61f alpha:1.00f];
    }
    return _contentL;
}

- (UILabel *)updateCountL {
    if (!_updateCountL) {
        UILabel *update = [[UILabel alloc] init];
        [self.contentView addSubview:update];
        _updateCountL = update;
    }
    return _updateCountL;
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
@end
