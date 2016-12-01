//
//  RecommendTitleViewCell.m
//  BiliBili
//
//  Created by JimHuang on 16/1/14.
//  Copyright © 2016年 JimHuang. All rights reserved.
//

#import "RecommendTitleViewCell.h"

@implementation RecommendTitleViewCell
- (void)setTitle:(NSString*)title titleImg:(NSString*)titleimg{
    self.title.text = title;
    self.title.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
    [self.titleImg setImage:[UIImage imageNamed: titleimg]];
}

- (UILabel *)title{
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize: 13];
        [self addSubview: _title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleImg);
            make.left.equalTo(self.titleImg.mas_right).mas_offset(5);
        }];
    }
    return _title;
}

- (UIImageView *)titleImg{
    if (_titleImg == nil) {
        _titleImg = [[UIImageView alloc] init];
        [self addSubview: _titleImg];
        [_titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_offset(0);
            make.left.mas_offset(20);
            make.width.height.mas_equalTo(15);
        }];
    }
    return _titleImg;
}
@end
