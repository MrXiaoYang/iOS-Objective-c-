//
//  InvestorTableViewCell.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/6.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "InvestorTableViewCell.h"
@interface InvestorTableViewCell ()
@property (strong, nonatomic) UILabel *rankLabel;
@property (strong, nonatomic) UIImageView *invertorIcon;
@property (strong, nonatomic) UILabel *invertorName;
@property (strong, nonatomic) UILabel *replyLabel;
@end

@implementation InvestorTableViewCell


- (void)setWithDic:(NSDictionary *)dic{
    __weak typeof(self)weakSelf = self;
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"invertorIcon"]) {
            [weakSelf.invertorIcon setImageWithURL: obj];
        }else{
            [weakSelf setValue:obj forKeyPath:key];
        }
    }];
}

- (UILabel *)rankLabel {
	if(_rankLabel == nil) {
		_rankLabel = [[UILabel alloc] init];
        [self addSubview: _rankLabel];
        _rankLabel.font = [UIFont systemFontOfSize: 17];
        _rankLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        [_rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.width.mas_equalTo(25);
            make.centerY.equalTo(self.invertorIcon);
        }];
	}
	return _rankLabel;
}

- (UIImageView *)invertorIcon {
	if(_invertorIcon == nil) {
		_invertorIcon = [[UIImageView alloc] init];
        _invertorIcon.layer.cornerRadius = 18;
        _invertorIcon.layer.masksToBounds = YES;
        [self addSubview: _invertorIcon];
        [_invertorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(36);
            make.centerY.mas_equalTo(0);
            make.top.mas_greaterThanOrEqualTo(10);
            make.bottom.mas_lessThanOrEqualTo(-10);
            make.left.mas_equalTo(self.rankLabel.mas_right).mas_offset(10);
        }];
	}
	return _invertorIcon;
}

- (UILabel *)invertorName {
	if(_invertorName == nil) {
		_invertorName = [[UILabel alloc] init];
        _invertorName.font = [UIFont systemFontOfSize: 13];
        _invertorName.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        [self addSubview: _invertorName];
        [_invertorName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.invertorIcon.mas_right).mas_offset(10);
            make.bottom.mas_equalTo(self.invertorIcon.mas_centerY).mas_offset(-5);
        }];
	}
	return _invertorName;
}

- (UILabel *)replyLabel {
	if(_replyLabel == nil) {
		_replyLabel = [[UILabel alloc] init];
        _replyLabel.font = [UIFont systemFontOfSize: 13];
        _replyLabel.numberOfLines = 0;
        _replyLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        [self addSubview: _replyLabel];
        [_replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.invertorIcon.mas_right).mas_offset(10);
            make.top.mas_equalTo(self.invertorIcon.mas_centerY).mas_offset(5);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-10);
        }];
	}
	return _replyLabel;
}

@end
