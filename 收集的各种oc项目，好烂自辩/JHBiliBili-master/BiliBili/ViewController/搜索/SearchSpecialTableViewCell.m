//
//  SearchSpecialTableViewCell.m
//  BiliBili
//
//  Created by apple-jd24 on 15/12/13.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SearchSpecialTableViewCell.h"

@interface SearchSpecialTableViewCell()
/**
 *  封面
 */
@property (nonatomic, strong)UIImageView* coverImgView;
/**
 *  专题标签
 */
@property (nonatomic, strong)UILabel* signLabel;
/**
 *  标题
 */
@property (nonatomic, strong)UILabel* titleLabel;
/**
 *  简介
 */
@property (nonatomic, strong)UILabel* detailLabel;
@end

@implementation SearchSpecialTableViewCell
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
        self.signLabel.text = @"专题";
        self.titleLabel.text = @"";
        self.detailLabel.text = @"";
        self.contentView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"lightBackGroundColor"];
    }
    return self;
}

#pragma mark -  懒加载
- (UILabel *)signLabel{
    if(_signLabel == nil) {
        _signLabel = [[UILabel alloc] init];
        _signLabel.textColor = [UIColor whiteColor];
        _signLabel.backgroundColor = [[ColorManager shareColorManager] colorWithString: @"themeColor"];
        _signLabel.textAlignment = NSTextAlignmentCenter;
        _signLabel.font = [UIFont systemFontOfSize: 13];
        [self addSubview: _signLabel];
        [_signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.coverImgView.mas_right).mas_offset(10);
            make.top.mas_equalTo(self.coverImgView.mas_top);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(20);
        }];
    }
    return _signLabel;
}
- (UIImageView *)coverImgView{
	if(_coverImgView == nil) {
		_coverImgView = [[UIImageView alloc] init];
        [self addSubview: _coverImgView];
        [_coverImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(60);
            make.top.left.mas_offset(10);
            make.bottom.mas_offset(-10);
        }];
	}
	return _coverImgView;
}

- (UILabel *) titleLabel {
	if(_titleLabel == nil) {
		_titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize: 13];
        _titleLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview: _titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.signLabel.mas_right).mas_offset(10);
            make.top.bottom.equalTo(self.signLabel);
        }];
	}
	return _titleLabel;
}

- (UILabel*)detailLabel{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize: 13];
        _detailLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"assistantTextColor"];
        _detailLabel.numberOfLines = 2;
        [self addSubview: _detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.signLabel);
            make.right.mas_offset(-10);
            make.top.mas_equalTo(self.signLabel.mas_bottom).mas_offset(5);
            make.bottom.equalTo(self.coverImgView);
        }];
    }
    return _detailLabel;
}
@end
