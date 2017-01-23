//
//  ShiBanTitleCollectionViewCell.m
//  BiliBili
//
//  Created by JimHuang on 16/1/14.
//  Copyright © 2016年 JimHuang. All rights reserved.
//

#import "ShiBanTitleCollectionViewCell.h"

@implementation ShiBanTitleCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview: self.recommedIcon];
        [_recommedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(15);
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(20);
        }];
        
        [self addSubview: self.recommedLabel];
        [self.recommedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.recommedIcon.mas_right).mas_offset(10);
            make.centerY.equalTo(self.recommedIcon);
        }];
    }
    return self;
}


- (void)setUpProperty{
    self.recommedLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
}


#pragma mark - 懒加载
- (UILabel *)recommedLabel {
    if(_recommedLabel == nil) {
        _recommedLabel = [[UILabel alloc] init];
        _recommedLabel.text = @"推荐番剧";
        _recommedLabel.font = [UIFont systemFontOfSize: 13];
    }
    return _recommedLabel;
}

- (UIImageView *)recommedIcon{
    if(_recommedIcon == nil) {
        _recommedIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_category_promo"]];
    }
    return _recommedIcon;
}
@end
