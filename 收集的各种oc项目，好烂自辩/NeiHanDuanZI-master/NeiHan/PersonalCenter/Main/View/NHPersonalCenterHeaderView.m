//
//  NHPersonalCenterHeaderView.m
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHPersonalCenterHeaderView.h"
#import "UIView+Layer.h"
#import "NHNeiHanUserInfoModel.h"
#import "NHPersonalCenterHeaderCountView.h"
#import "UIView+Tap.h"
#import "NHUserInfoManager.h"

@interface NHPersonalCenterHeaderView () <NHPersonalCenterHeaderCountViewDelegate>

@property (nonatomic, weak) UILabel *nameL;
/** 封面*/
@property (nonatomic, weak) UIImageView *coverImg;
/** 头像*/
@property (nonatomic, weak) NHBaseImageView *iconImg;
/** 更改头像*/
@property (nonatomic, weak) UILabel *changeL;
/** 关注、粉丝、动态*/
@property (nonatomic, weak) NHPersonalCenterHeaderCountView *countView;
@end

@implementation NHPersonalCenterHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
    }
    return self;
}

- (void)setUserInfoModel:(NHNeiHanUserInfoModel *)userInfoModel {
    _userInfoModel = userInfoModel;
    
    self.nameL.text = userInfoModel.name;
    
    // 头像
    [self.iconImg setImageWithURL:[NSURL URLWithString:userInfoModel.avatar_url]];
 
    // 关注、粉丝、积分
    self.countView.fans_count = userInfoModel.followers;
    self.countView.follow_count = userInfoModel.followings;
    self.countView.share_count = userInfoModel.point;
    
    self.changeL.hidden = ![NHUtils isCurrentUserWithUserId:userInfoModel.user_id];
    
    [self setNeedsLayout];
 
}

#pragma mark - NHPersonalCenterHeaderCountViewDelegate
// 关注、粉丝、动态
- (void)personalCenterHeaderCountView:(NHPersonalCenterHeaderCountView *)countView buttonType:(NHPersonalCenterHeaderViewItemType)buttonType {
    if ([self.delegate respondsToSelector:@selector(personalCenterHeaderView:didClickItemWithType:)]) {
        [self.delegate personalCenterHeaderView:self didClickItemWithType:(NHPersonalCenterHeaderViewItemType)buttonType];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 封面
    CGFloat coverX = 0;
    CGFloat coverY = 0;
    CGFloat coverW = kScreenWidth;//self.width;
    CGFloat coverH = 200;
    self.coverImg.frame = CGRectMake(coverX, coverY, coverW, coverH);
    
    // 头像
    CGFloat iconX = 21 ;
    CGFloat iconY = self.coverImg.height - 65;
    CGFloat iconW = 80;
    CGFloat iconH = 80;
    self.iconImg.frame = CGRectMake(iconX, iconY, iconW, iconH);
    self.iconImg.layerCornerRadius = self.iconImg.width / 2.0;
    [self bringSubviewToFront:self.iconImg];
    
    CGFloat changeX = 0;
    CGFloat changeY = self.iconImg.height / 2.0 - 10.0;
    CGFloat changeW = self.iconImg.width;
    CGFloat changeH = 20;
    self.changeL.frame = CGRectMake(changeX, changeY, changeW, changeH);
    
    CGFloat nameX = self.iconImg.right + 15;
    CGFloat nameY = self.iconImg.y + 30;
    CGFloat nameW = kScreenWidth - nameX;
    CGFloat nameH = 20;
    self.nameL.frame = CGRectMake(nameX, nameY, nameW, nameH);
    [self bringSubviewToFront:self.nameL];
    
    // 关注、粉丝、积分
    CGFloat countX = 0;
    CGFloat countY = self.coverImg.bottom;
    CGFloat countW = kScreenWidth;
    CGFloat countH = 79;
    self.countView.frame = CGRectMake(countX, countY, countW, countH);
}

- (NHBaseImageView *)iconImg {
    if (!_iconImg) {
        NHBaseImageView *icon = [[NHBaseImageView alloc] init];
        [self addSubview:icon];
        _iconImg = icon;
        icon.contentMode = UIViewContentModeScaleAspectFill;
        [self bringSubviewToFront:icon];
        icon.layerBorderColor = [UIColor whiteColor];
        icon.backgroundColor = kCommonBgColor;
        WeakSelf(weakSelf);
        [icon setTapActionWithBlock:^{
            if ([weakSelf.delegate respondsToSelector:@selector(personalCenterHeaderView:didClickItemWithType:)]) {
                [weakSelf.delegate personalCenterHeaderView:weakSelf didClickItemWithType:NHPersonalCenterHeaderViewItemTypeAvatar];
            }
        }];
        icon.layerBorderColor = [UIColor whiteColor];
        icon.layerBorderWidth = kLineHeight;
        [self bringSubviewToFront:icon];
    }
    return _iconImg;
}

- (UIImageView *)coverImg {
    if (!_coverImg) {
        UIImageView *coverImg = [[UIImageView alloc] init];
        [self addSubview:coverImg];
        coverImg.image = [UIImage imageNamed:@"cover_kebi.jpg"];
        _coverImg = coverImg;
        coverImg.contentMode = UIViewContentModeScaleAspectFill;
        coverImg.layer.masksToBounds = YES;
    }
    return _coverImg;
}

- (NHPersonalCenterHeaderCountView *)countView {
    if (!_countView) {
        NHPersonalCenterHeaderCountView *count = [[NHPersonalCenterHeaderCountView alloc] init];
        [self addSubview:count];
        _countView = count;
        count.delegate = self;
        count.backgroundColor = [UIColor whiteColor];
    }
    return _countView;
}

- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *name = [[UILabel alloc] init];
        [self addSubview:name];
        _nameL = name;
        name.font = kFont(17);
        name.textColor = kCommonBlackColor;
    }
    return _nameL;
}

- (UILabel *)changeL {
    if (!_changeL) {
        UILabel *label = [[UILabel alloc] init];
        [self.iconImg addSubview:label];
        _changeL = label;
        label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        label.text = @"更改头像";
        label.font = kFont(11);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kWhiteColor;
    }
    return _changeL;
}
@end
