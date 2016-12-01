//
//  ShiBanIntroduceTableViewCell.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/25.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ShiBanIntroduceTableViewCell.h"
@interface ShiBanIntroduceTableViewCell ()
@property (strong, nonatomic) UILabel *introduceLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@end

@implementation ShiBanIntroduceTableViewCell

- (void)setUpWithIntroduce:(NSString*)introduce{
    self.introduceLabel.text = introduce;
}

- (void)setWithDic:(NSDictionary *)dic{
    __weak typeof(self)weakSelf = self;
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [weakSelf setValue:obj forKey:key];
    }];
}

- (UILabel *)titleLabel {
    if(_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize: 15];
        [_titleLabel setText:@"简介"];
        _titleLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        [self addSubview: _titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(18);
            make.left.top.mas_offset(10);
            make.bottom.mas_equalTo(self.introduceLabel.mas_top).mas_offset(-10);
        }];
    }
    return _titleLabel;
}

- (UILabel *)introduceLabel {
    if(_introduceLabel == nil) {
        _introduceLabel = [[UILabel alloc] init];
        _introduceLabel.font = [UIFont systemFontOfSize: 12];
        _introduceLabel.numberOfLines = 0;
        _introduceLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        [self addSubview: _introduceLabel];
        [_introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.right.mas_offset(-10);
            make.bottom.mas_offset(-10);
        }];
    }
    return _introduceLabel;
}

@end
