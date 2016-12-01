//
//  BestGroupDetailIntroCell.m
//  BaseProject
//
//  Created by jiyingxin on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BestGroupDetailIntroCell.h"

@implementation BestGroupDetailIntroCell

#define kIconSpace  (kWindowW - 52 * 5)/6
- (TRImageView *)iconView1 {
    if(_iconView1 == nil) {
        _iconView1 = [[TRImageView alloc] init];
        [self.contentView addSubview:_iconView1];
        [_iconView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kIconSpace);
            make.top.mas_equalTo(self.titleLb.mas_bottom).mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(52, 52));
        }];
    }
    return _iconView1;
}

- (TRImageView *)iconView2 {
    if(_iconView2 == nil) {
        _iconView2 = [[TRImageView alloc] init];
        [self.contentView addSubview:_iconView2];
        [_iconView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView1.mas_right).mas_equalTo(kIconSpace);
            make.centerY.mas_equalTo(self.iconView1);
            make.size.mas_equalTo(CGSizeMake(52, 52));
        }];
    }
    return _iconView2;
}

- (TRImageView *)iconView3 {
    if(_iconView3 == nil) {
        _iconView3 = [[TRImageView alloc] init];
        [self.contentView addSubview:_iconView3];
        [_iconView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView2.mas_right).mas_equalTo(kIconSpace);
            make.centerY.mas_equalTo(self.iconView1);
            make.size.mas_equalTo(CGSizeMake(52, 52));
        }];
    }
    return _iconView3;
}

- (TRImageView *)iconView4 {
    if(_iconView4 == nil) {
        _iconView4 = [[TRImageView alloc] init];
        [self.contentView addSubview:_iconView4];
        [_iconView4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView3.mas_right).mas_equalTo(kIconSpace);
            make.centerY.mas_equalTo(self.iconView1);
            make.size.mas_equalTo(CGSizeMake(52, 52));
        }];
    }
    return _iconView4;
}

- (TRImageView *)iconView5 {
    if(_iconView5 == nil) {
        _iconView5 = [[TRImageView alloc] init];
        [self.contentView addSubview:_iconView5];
        [_iconView5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView4.mas_right).mas_equalTo(kIconSpace);
            make.centerY.mas_equalTo(self.iconView1);
            make.size.mas_equalTo(CGSizeMake(52, 52));
        }];
    }
    return _iconView5;
}

- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLb];
        _titleLb.numberOfLines = 0;
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
    }
    return _titleLb;
}

- (UILabel *)descLb {
    if(_descLb == nil) {
        _descLb = [[UILabel alloc] init];
        _descLb.font=[UIFont systemFontOfSize:16];
        [self.contentView addSubview:_descLb];
        [_descLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconView1.mas_bottom).mas_equalTo(10);
            make.bottom.right.mas_equalTo(-10);
            make.left.mas_equalTo(10);
        }];
        _descLb.numberOfLines = 0;
    }
    return _descLb;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
