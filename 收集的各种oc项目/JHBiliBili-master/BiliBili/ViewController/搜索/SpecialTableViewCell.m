//
//  SpecialTableViewCell.m
//  BiliBili
//
//  Created by apple-jd24 on 15/12/15.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SpecialTableViewCell.h"
@interface SpecialTableViewCell()
@property (nonatomic, strong)UIImageView* coverImgView;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UILabel* detailLabel;
@end

@implementation SpecialTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [[ColorManager shareColorManager] colorWithString: @"lightBackGroundColor"];
        self.titleLabel.text = @"";
        self.detailLabel.text = @"";
    }
    return self;
}


- (void)setWithDic:(NSDictionary*)dic{
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString: @"coverImageView"]) {
            [self.coverImgView setImageWithURL: obj];
        }else{
            [self setValue:obj forKeyPath:key];
        }
    }];
}


#pragma mark - 懒加载

- (UIImageView *) coverImgView {
	if(_coverImgView == nil) {
		_coverImgView = [[UIImageView alloc] init];
        [self addSubview: _coverImgView];
        [_coverImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(93);
            make.height.mas_equalTo(60);
            make.left.top.mas_offset(10);
            make.bottom.mas_offset(-10);
        }];
	}
	return _coverImgView;
}

- (UILabel *) titleLabel {
	if(_titleLabel == nil) {
		_titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        _titleLabel.font = [UIFont systemFontOfSize: 13];
        [self addSubview: _titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.coverImgView.mas_right).mas_offset(10);
            make.top.equalTo(self.coverImgView);
            make.right.mas_offset(-10);
        }];
	}
	return _titleLabel;
}

- (UILabel *) detailLabel {
	if(_detailLabel == nil) {
		_detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"assistantTextColor"];
        _detailLabel.font = [UIFont systemFontOfSize: 13];
        _detailLabel.numberOfLines = 2;
        [self addSubview: _detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(5);
            make.left.equalTo(self.titleLabel);
            make.right.mas_offset(-10);
        }];
	}
	return _detailLabel;
}

@end
