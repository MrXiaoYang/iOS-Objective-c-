//
//  RecommendContentCollectionViewCell.m
//  BiliBili
//
//  Created by JimHuang on 16/1/14.
//  Copyright © 2016年 JimHuang. All rights reserved.
//

#import "RecommendContentCollectionViewCell.h"

@implementation RecommendContentCollectionViewCell
- (void)setUpProperty{
    self.titleLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
    self.danMuLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
    self.playLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
    
    self.danMuIcon.tintColor = [[ColorManager shareColorManager] colorWithString:@"themeColor"];
    self.danMuIcon.image = [self.danMuIcon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.playIcon.tintColor = [[ColorManager shareColorManager] colorWithString:@"themeColor"];
    self.playIcon.image = [self.playIcon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.contentView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"lightBackGroundColor"];
}

#pragma mark - 懒加载
- (UIImageView *)imgv {
    if(_imgv == nil) {
        _imgv = [[UIImageView alloc] init];
        [self addSubview: _imgv];
        [_imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.width.mas_equalTo(self);
            make.height.mas_equalTo(self.mas_width).multipliedBy(0.61);
        }];
    }
    return _imgv;
}

- (UILabel *)titleLabel {
    if(_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode = NSLineBreakByClipping;
        _titleLabel.font = [UIFont systemFontOfSize: 13];
        _titleLabel.font = [UIFont systemFontOfSize: 14];
        [self addSubview: _titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imgv.mas_bottom).mas_offset(5);
            make.width.mas_equalTo(self.mas_width).mas_offset(-10);
            make.centerX.mas_offset(0);
            make.bottom.mas_equalTo(self.playIcon.mas_top).mas_offset(-10);
        }];
    }
    return _titleLabel;
}

- (UIImageView *)playIcon {
    if(_playIcon == nil) {
        _playIcon = [[UIImageView alloc] init];
        [_playIcon setImage: [UIImage imageNamed:@"list_playnumb_icon"]];
        [self addSubview: _playIcon];
        [_playIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(13);
            make.height.mas_equalTo(10);
            make.left.equalTo(self.imgv).mas_offset(2);
            make.bottom.mas_offset(-5);
        }];
        
    }
    return _playIcon;
}

- (UILabel *)playLabel {
    if(_playLabel == nil) {
        _playLabel = [[UILabel alloc] init];
        _playLabel.font = [UIFont systemFontOfSize: 10];
        [self addSubview: _playLabel];
        [_playLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.playIcon);
            make.left.mas_equalTo(self.playIcon.mas_right).mas_offset(2);
        }];
    }
    return _playLabel;
}

- (UIImageView *)danMuIcon {
    if(_danMuIcon == nil) {
        _danMuIcon = [[UIImageView alloc] init];
        [_danMuIcon setImage:[UIImage imageNamed:@"list_danmaku_icon"]];
        [self addSubview: _danMuIcon];
        [_danMuIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self.playIcon);
            make.centerY.equalTo(self.playIcon);
            make.right.mas_equalTo(self.danMuLabel.mas_left).mas_offset(-2);
        }];
    }
    return _danMuIcon;
}

- (UILabel *)danMuLabel {
    if(_danMuLabel == nil) {
        _danMuLabel = [[UILabel alloc] init];
        _danMuLabel.font = [UIFont systemFontOfSize: 10];
        [self addSubview: _danMuLabel];
        [_danMuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.playIcon);
            make.right.equalTo(self.titleLabel).mas_offset(-2);
        }];
    }
    return _danMuLabel;
}

@end
