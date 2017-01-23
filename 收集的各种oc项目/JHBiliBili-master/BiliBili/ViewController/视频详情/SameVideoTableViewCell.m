//
//  SameVideoTableViewCell.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/6.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SameVideoTableViewCell.h"
@interface SameVideoTableViewCell()
@property (strong, nonatomic) UIImageView *videoImgView;
@property (strong, nonatomic) UILabel *videoLabel;
@property (strong, nonatomic) UILabel *playNumLabel;
@property (strong, nonatomic) UILabel *danMuLabel;
@property (strong, nonatomic) UIImageView *playIcon;
@property (strong, nonatomic) UIImageView *DanMuIcon;
@end


@implementation SameVideoTableViewCell

- (void)setWithDic:(NSDictionary *)dic{
    __weak typeof(self)weakSelf = self;
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"videoImgView"]) {
            [weakSelf.videoImgView setImageWithURL:obj];
        }else{
            [weakSelf setValue:obj forKeyPath:key];
        }
    }];
}

- (UIImageView *)videoImgView {
	if(_videoImgView == nil) {
		_videoImgView = [[UIImageView alloc] init];
        [self addSubview: _videoImgView];
        [_videoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(106);
            make.height.mas_equalTo(66);
            make.top.left.mas_offset(10);
            make.bottom.mas_offset(-10);
        }];
	}
	return _videoImgView;
}

- (UILabel *)videoLabel {
	if(_videoLabel == nil) {
		_videoLabel = [[UILabel alloc] init];
        _videoLabel.font = [UIFont systemFontOfSize: 15];
        _videoLabel.numberOfLines = 2;
        _videoLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        
        
        [self addSubview: _videoLabel];
        [_videoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.videoImgView.mas_top).mas_offset(10);
            make.left.equalTo(self.videoImgView.mas_right).mas_offset(10);
            make.right.mas_offset(-10);
        }];
	}
	return _videoLabel;
}

- (UILabel *)playNumLabel {
	if(_playNumLabel == nil) {
		_playNumLabel = [[UILabel alloc] init];
        _playNumLabel.font = [UIFont systemFontOfSize: 10];
        [self addSubview: _playNumLabel];
        _playNumLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        [_playNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.playIcon.mas_right).mas_offset(5);
            make.centerY.equalTo(self.playIcon);
        }];
	}
	return _playNumLabel;
}

- (UILabel *)danMuLabel {
	if(_danMuLabel == nil) {
		_danMuLabel = [[UILabel alloc] init];
        _danMuLabel.font = [UIFont systemFontOfSize: 10];
        [self addSubview: _danMuLabel];
        _danMuLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        [_danMuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.left.mas_equalTo(self.DanMuIcon.mas_right).mas_offset(5);
            make.centerY.equalTo(self.playIcon);
        }];
	}
	return _danMuLabel;
}

- (UIImageView *)playIcon {
	if(_playIcon == nil) {
		_playIcon = [[UIImageView alloc] init];
        UIImage* image = [[UIImage imageNamed:@"list_playnumb_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _playIcon.image = image;
        _playIcon.tintColor = [[ColorManager shareColorManager] colorWithString:@"themeColor"];
        [self addSubview: _playIcon];
        [_playIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.videoLabel);
            make.top.mas_equalTo(self.videoLabel.mas_bottom).mas_offset(10);
            make.width.mas_equalTo(13);
            make.height.mas_equalTo(10);
        }];
	}
	return _playIcon;
}

- (UIImageView *)DanMuIcon {
	if(_DanMuIcon == nil) {
		_DanMuIcon = [[UIImageView alloc] init];
        
        UIImage* image = [[UIImage imageNamed:@"list_danmaku_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _DanMuIcon.image = image;
        _DanMuIcon.tintColor = [[ColorManager shareColorManager] colorWithString:@"themeColor"];
        
        [self addSubview: _DanMuIcon];
        [_DanMuIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.centerY.equalTo(self.playIcon);
        }];
	}
	return _DanMuIcon;
}

@end
