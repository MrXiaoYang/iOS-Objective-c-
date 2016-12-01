//
//  NHDiscoverNearByTableViewCell.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDiscoverNearByTableViewCell.h"
#import "NHDiscoverNearByUserModel.h"
#import "UIView+Layer.h"
#import "NSString+Size.h"

@interface NHDiscoverNearByTableViewCell ()
/** 头像*/
@property (nonatomic, weak) NHBaseImageView *iconImg;
/** 名字*/
@property (nonatomic, weak) UILabel *nameL;
/** 描述*/
@property (nonatomic, weak) UILabel *descL;
/** 订阅数*/
@property (nonatomic, weak) UILabel *distanceL;
/** 总贴数*/
@property (nonatomic, weak) UILabel *timeL;
/** 订阅*/
@property (nonatomic, weak) UIButton *sexBtn;

@property (nonatomic, weak) CALayer *lineLayer;
@end
@implementation NHDiscoverNearByTableViewCell

- (void)setUserModel:(NHDiscoverNearByUserModel *)userModel {
    _userModel = userModel;
    
    // 名字
    self.nameL.text = userModel.name;
    
    // 头像
    [self.iconImg setImageWithURL:[NSURL URLWithString:userModel.avatar_url]];
    
    // 时间
    self.timeL.text = [NHUtils updateTimeForTimeInterval:userModel.last_update];
    
    // 距离
    self.distanceL.text = [NSString stringWithFormat:@"%.0fm",userModel.distance.floatValue];
    
    // 性别
    if (userModel.gender == 0) {
        [self.sexBtn setImage:[UIImage imageNamed:@"Unknown"] forState:UIControlStateNormal];
    } else if (userModel.gender == 1) {
        [self.sexBtn setImage:[UIImage imageNamed:@"user-men"] forState:UIControlStateNormal];
    } else if (userModel.gender == 2) {
        [self.sexBtn setImage:[UIImage imageNamed:@"user-women"] forState:UIControlStateNormal];
    }
    
    // 描述
    if (userModel.desc.length) {
        self.descL.hidden = NO;
        self.descL.text = userModel.desc;
    } else {
        self.descL.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    CGFloat iconX = 15;
    CGFloat iconY = 15;
    CGFloat iconH = self.contentView.height - iconY * 2;
    CGFloat iconW = iconH;
    self.iconImg.frame = CGRectMake(iconX, iconY, iconW, iconH);
    self.iconImg.layerCornerRadius = iconH / 2.0;
    
    CGFloat nameW = [self.nameL.text widthWithFont:self.nameL.font constrainedToHeight:18] > kScreenWidth / 2.0 ? kScreenWidth / 2.0 : [self.nameL.text widthWithFont:self.nameL.font constrainedToHeight:18];
    CGFloat nameX = self.iconImg.right + 15;
    CGFloat nameY = 15;
    CGFloat nameH = 18;
    self.nameL.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat sexBtnW = 24;
    CGFloat sexBtnX = self.nameL.right + 5;
    CGFloat sexBtnH = 24;
    CGFloat sexBtnY = nameY;
    self.sexBtn.frame = CGRectMake(sexBtnX, sexBtnY, sexBtnW, sexBtnH);
    self.sexBtn.centerY = self.nameL.centerY;
    
    CGFloat locX = nameX;
    CGFloat locY = self.nameL.bottom + 10;
    CGFloat locH = nameH;
    CGFloat locW = [self.distanceL.text widthWithFont:self.distanceL.font constrainedToHeight:locH];
    self.distanceL.frame = CGRectMake(locX, locY, locW, locH);
    
    CGFloat lineX = self.distanceL.right + 5;
    CGFloat lineY = locY;
    CGFloat lineW = 1;
    CGFloat lineH = locH;
    self.lineLayer.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat timeX = self.distanceL.right + 11;
    CGFloat timeY = locY;
    CGFloat timeH = nameH;
    CGFloat timeW = [self.timeL.text widthWithFont:self.timeL.font constrainedToHeight:timeH];
    self.timeL.frame = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat descY = 15;
    
    CGSize boundSize = CGSizeMake(100, self.contentView.height - 15 * 2);
    CGSize size = [self.descL.text boundingRectWithSize:boundSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.descL.font} context:nil].size;
    
    self.descL.frame = (CGRect){CGPointMake(kScreenWidth - size.width - 15, descY), size};
    
    self.descL.centerY = self.contentView.centerY;
}

- (UILabel *)descL {
    if (!_descL) {
        UILabel *desc = [[UILabel alloc] init];
        [self.contentView addSubview:desc];
        _descL = desc;
        desc.numberOfLines = 0;
        desc.backgroundColor = [kLightGrayColor colorWithAlphaComponent:0.3];
        desc.layerCornerRadius = 1.0;
        desc.textColor = kCommonBlackColor;
        desc.font = kFont(14);
        desc.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _descL;
}

- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _nameL = label;
        label.font = kFont(16);
        label.textColor = kBlackColor;
    }
    return _nameL;
}

- (UILabel *)distanceL {
    if (!_distanceL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _distanceL = label;
        label.font = kFont(13);
        label.textColor = [kTextColor colorWithAlphaComponent:0.6];
    }
    return _distanceL;
}

- (UILabel *)timeL {
    if (!_timeL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _timeL = label;
        label.font = kFont(13);
        label.textColor = [kTextColor colorWithAlphaComponent:0.6];
    }
    return _timeL;
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

- (UIButton *)sexBtn {
    if (!_sexBtn) {
        UIButton *sexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:sexBtn];
        _sexBtn = sexBtn;
        
        [sexBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    }
    return _sexBtn;
}

- (CALayer *)lineLayer {
    if (!_lineLayer) {
        CALayer *line = [CALayer layer];
        [self.contentView.layer addSublayer:line];
        _lineLayer = line;
        line.backgroundColor = [UIColor blackColor].CGColor;
    }
    return _lineLayer;
}

@end
