//
//  ReViewTableViewCell.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/6.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ReViewTableViewCell.h"
@interface ReViewTableViewCell ()
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UIImageView *genderImgView;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UILabel *lvLabel;
@property (strong, nonatomic) UILabel *goodLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *goodImgView;
@end

@implementation ReViewTableViewCell

- (void)setWithDic:(NSDictionary *)dic{
    __weak typeof(self)weakSelf = self;
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"imgView"]) {
            [weakSelf.imgView setImageWithURL: obj];
        }else if ([key isEqualToString:@"genderImgView"]){
            [weakSelf.genderImgView setImage:[UIImage imageNamed: [NSString stringWithFormat:@"ic_user_%@",@{@"男":@"male",@"女":@"female",@"保密":@"sox"}[obj]]]];
        }else{
            [weakSelf setValue:obj forKeyPath:key];
        }
    }];
}

- (UIImageView *)imgView {
	if(_imgView == nil) {
		_imgView = [[UIImageView alloc] init];
        _imgView.layer.cornerRadius = 18;
        _imgView.layer.masksToBounds = YES;
        [self addSubview: _imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(36);
            make.left.top.mas_offset(10);
        }];
	}
	return _imgView;
}

- (UIImageView *)genderImgView {
	if(_genderImgView == nil) {
		_genderImgView = [[UIImageView alloc] init];
        [self addSubview: _genderImgView];
        [_genderImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(13);
            make.centerY.equalTo(self.nameLabel);
            make.left.equalTo(self.nameLabel.mas_right).mas_offset(10);
        }];
	}
	return _genderImgView;
}

- (UILabel *)timeLabel {
	if(_timeLabel == nil) {
		_timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = kRGBColor(133, 133, 133);
        _timeLabel.font = [UIFont systemFontOfSize: 10];
        [self addSubview: _timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(10);
        }];
	}
	return _timeLabel;
}

- (UILabel *)messageLabel {
	if(_messageLabel == nil) {
		_messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        _messageLabel.font = [UIFont systemFontOfSize: 12];
        _messageLabel.numberOfLines = 0;
        [self addSubview: _messageLabel];
        [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.top.mas_equalTo(self.imgView.mas_bottom).mas_offset(10);
            make.bottom.mas_offset(-10);
        }];
	}
	return _messageLabel;
}

- (UILabel *)lvLabel {
	if(_lvLabel == nil) {
		_lvLabel = [[UILabel alloc] init];
        _lvLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        _lvLabel.font = [UIFont systemFontOfSize: 12];
        [self addSubview: _lvLabel];
        [_lvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView);
            make.right.equalTo(self.goodImgView.mas_left).mas_offset(-10);
        }];
	}
	return _lvLabel;
}

- (UILabel *)goodLabel {
	if(_goodLabel == nil) {
		_goodLabel = [[UILabel alloc] init];
        _goodLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        _goodLabel.font = [UIFont systemFontOfSize: 12];
        [self addSubview: _goodLabel];
        [_goodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodImgView);
            make.left.mas_equalTo(self.goodImgView.mas_right).mas_offset(10);
            make.right.mas_offset(-10);
        }];
	}
	return _goodLabel;
}

- (UILabel *)nameLabel {
	if(_nameLabel == nil) {
		_nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize: 12];
        _nameLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        [self addSubview: _nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView);
            make.left.mas_equalTo(self.imgView.mas_right).mas_offset(10);
        }];
	}
	return _nameLabel;
}

- (UIImageView *)goodImgView{
	if(_goodImgView == nil) {
		_goodImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_feedback_good"]];
        [self addSubview: _goodImgView];
        [_goodImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(10);
            make.top.equalTo(self.lvLabel);
        }];
	}
	return _goodImgView;
}

@end
