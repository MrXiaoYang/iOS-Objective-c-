//
//  NHDiscoverSearchFriendUserCell.m
//  NeiHan
//
//  Created by Charles on 16/9/11.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDiscoverSearchFriendUserCell.h"
#import "NHNeiHanUserInfoModel.h"
#import "UIView+Layer.h"

@interface NHDiscoverSearchFriendUserCell ()
/** 头像*/
@property (nonatomic, weak) NHBaseImageView *iconImg;
/** 名字*/
@property (nonatomic, weak) UILabel *nameL;
/** 文本*/
@property (nonatomic, weak) UILabel *contentL;
@end

@implementation NHDiscoverSearchFriendUserCell

- (void)setUserInfoModel:(NHNeiHanUserInfoModel *)userInfoModel {
    _userInfoModel = userInfoModel;
    // 名字
    if (userInfoModel.name.length) {
        self.nameL.text = userInfoModel.name;
    }
    
    // 文本
    if (userInfoModel.desc.length) {
        self.contentL.text = userInfoModel.desc;
    }
    
    // 头像
    [self.iconImg setImageWithURL:[NSURL URLWithString:userInfoModel.avatar_url]];
    self.iconImg.layerCornerRadius = 3.0;
    

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
    CGFloat nameW = self.contentView.width - self.iconImg.right - 15 * 2 - 15;
    CGFloat nameH = 15;
    self.nameL.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    // 描述
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
