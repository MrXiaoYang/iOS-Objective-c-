//
//  TuWanImageCell.m
//  BaseProject
//
//  Created by tarena-ZeRO on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanImageCell.h"

@implementation TuWanImageCell
- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:17];
    }
    return _titleLb;
}

- (UILabel *)clicksNumLb {
    if(_clicksNumLb == nil) {
        _clicksNumLb = [[UILabel alloc] init];
        _clicksNumLb.textColor = [UIColor lightGrayColor];
        _clicksNumLb.font = [UIFont systemFontOfSize:12];
        _clicksNumLb.textAlignment = NSTextAlignmentRight;
    }
    return _clicksNumLb;
}

- (TRImageView *)iconIV0 {
    if(_iconIV0 == nil) {
        _iconIV0 = [[TRImageView alloc] init];
        //_iconIV0.contentMode = 2;
    }
    return _iconIV0;
}

- (TRImageView *)iconIV1 {
    if(_iconIV1 == nil) {
        _iconIV1 = [[TRImageView alloc] init];
        //_iconIV1.contentMode = 2;
    }
    return _iconIV1;
}

- (TRImageView *)iconIV2 {
    if(_iconIV2 == nil) {
        _iconIV2 = [[TRImageView alloc] init];
        //_iconIV2.contentMode = 2;
    }
    return _iconIV2;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.clicksNumLb];
        [self.contentView addSubview:self.iconIV0];
        [self.contentView addSubview:self.iconIV1];
        [self.contentView addSubview:self.iconIV2];
/** 题目 左上10 , 右10 */
        [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.mas_equalTo(_clicksNumLb.mas_left).mas_equalTo(-10);
        }];
/** 点击数 上右10像素, 宽度最大70,最小40像素 */
        [self.clicksNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.width.mas_lessThanOrEqualTo(70);
            make.width.mas_greaterThanOrEqualTo(40);
        }];
/** 图片 宽度相等 ,间距5,边缘10,高度88 */
        [self.iconIV0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(88);
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(_titleLb.mas_bottom).mas_equalTo(5);
        }];
        [self.iconIV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(_iconIV0);
            make.left.mas_equalTo(_iconIV0.mas_right).mas_equalTo(5);
            make.topMargin.mas_equalTo(_iconIV0);
        }];
        [self.iconIV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(_iconIV0);
            make.topMargin.mas_equalTo(_iconIV0);
            make.left.mas_equalTo(_iconIV1.mas_right).mas_equalTo(5);
            make.right.mas_equalTo(-10);
        }];
    }
    return self;
}

@end
