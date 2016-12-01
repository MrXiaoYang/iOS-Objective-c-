//
//  SearchShiBanTableViewCell.m
//  BiliBili
//
//  Created by apple-jd24 on 15/12/13.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SearchShiBanTableViewCell.h"
@interface SearchShiBanTableViewCell()
/**
 *  封面
 */
@property (nonatomic, strong)UIImageView* coverImgView;
/**
 *  番剧标签
 */
@property (nonatomic, strong)UILabel* shiBanSignLabel;
/**
 *  标题
 */
@property (nonatomic, strong)UILabel* titleLabel;
/**
 *  点击数
 */
@property (nonatomic, strong)UILabel* clicklabel;
/**
 *  订阅
 */
@property (nonatomic, strong)UILabel* favoriteLabel;
/**
 *  最新集
 */
@property (nonatomic, strong)UILabel* episodeLabel;
@end

@implementation SearchShiBanTableViewCell
- (void)setWithDic:(NSDictionary*)dic{
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString: @"coverImgView"]) {
            [self.coverImgView setImageWithURL: obj];
        }else{
            [self setValue:obj forKeyPath:key];
        }
    }];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.shiBanSignLabel.text = @"番剧";
        self.titleLabel.text = @"";
        self.clicklabel.text = @"点击：";
        self.favoriteLabel.text = @"订阅：";
        self.episodeLabel.text = @"";
        self.contentView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"lightBackGroundColor"];
    }
    return self;
}

#pragma mark - 懒加载
- (UIImageView *)coverImgView {
	if(_coverImgView == nil) {
		_coverImgView = [[UIImageView alloc] init];
        [self addSubview: _coverImgView];
        [_coverImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(80);
            make.left.top.mas_offset(10);
            make.bottom.mas_offset(-10);
        }];
	}
	return _coverImgView;
}

- (UILabel *)shiBanSignLabel{
	if(_shiBanSignLabel == nil) {
		_shiBanSignLabel = [[UILabel alloc] init];
        _shiBanSignLabel.textColor = [UIColor whiteColor];
        _shiBanSignLabel.backgroundColor = [[ColorManager shareColorManager] colorWithString: @"themeColor"];
        _shiBanSignLabel.textAlignment = NSTextAlignmentCenter;
        _shiBanSignLabel.font = [UIFont systemFontOfSize: 12];
        [self addSubview: _shiBanSignLabel];
        [_shiBanSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.coverImgView.mas_right).mas_offset(10);
            make.top.mas_equalTo(self.coverImgView.mas_top).mas_offset(10);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(20);
        }];
	}
	return _shiBanSignLabel;
}

- (UILabel *)titleLabel{
	if(_titleLabel == nil) {
		_titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize: 13];
        _titleLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        _titleLabel.lineBreakMode = NSLineBreakByClipping;
        [self addSubview: _titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.shiBanSignLabel);
            make.left.mas_equalTo(self.shiBanSignLabel.mas_right).mas_offset(5);
            make.right.mas_offset(-10);
        }];
	}
	return _titleLabel;
}

- (UILabel *) clicklabel {
	if(_clicklabel == nil) {
		_clicklabel = [[UILabel alloc] init];
        _clicklabel.font = [UIFont systemFontOfSize: 12];
        _clicklabel.textColor = [[ColorManager shareColorManager] colorWithString:@"assistantTextColor"];
        [self addSubview: _clicklabel];
        [_clicklabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.shiBanSignLabel);
            make.top.mas_equalTo(self.shiBanSignLabel.mas_bottom).mas_offset(10);
        }];
	}
	return _clicklabel;
}

- (UILabel *) favoriteLabel {
	if(_favoriteLabel == nil) {
		_favoriteLabel = [[UILabel alloc] init];
        _favoriteLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"assistantTextColor"];
        _favoriteLabel.font = [UIFont systemFontOfSize: 12];
        [self addSubview: _favoriteLabel];
        [_favoriteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.clicklabel);
            make.left.mas_equalTo(self.clicklabel.mas_right).mas_offset(15);
        }];
	}
	return _favoriteLabel;
}

- (UILabel *) episodeLabel {
	if(_episodeLabel == nil) {
		_episodeLabel = [[UILabel alloc] init];
        _episodeLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"assistantTextColor"];
        _episodeLabel.font = [UIFont systemFontOfSize: 12];
        [self addSubview: _episodeLabel];
        [_episodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.clicklabel.mas_bottom).mas_offset(10);
            make.left.equalTo(self.clicklabel);
        }];
	}
	return _episodeLabel;
}

@end
