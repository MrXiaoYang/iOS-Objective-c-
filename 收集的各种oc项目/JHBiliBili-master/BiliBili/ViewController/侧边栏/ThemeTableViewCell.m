//
//  ThemeTableViewCell.m
//  BiliBili
//
//  Created by JimHuang on 15/11/23.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ThemeTableViewCell.h"

@implementation ThemeTableViewCell
- (instancetype)initWithTitle:(NSString*)title reuseIdentifier:(NSString*)reuseIdentifier{
    if (self = [super initWithStyle:0 reuseIdentifier:reuseIdentifier]) {
        
        UIView* v = [[UIView alloc] init];
        v.backgroundColor = [[ColorManager shareColorManager] theme:title colorWithString:@"themeColor"];
        v.layer.cornerRadius = 8;
        v.layer.masksToBounds = YES;
        [self addSubview: v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_offset(0);
            make.left.mas_offset(10);
            make.width.height.mas_equalTo(16);
        }];

        UILabel* label = [[UILabel alloc] init];
        label.text = title;
        if (![title isEqualToString:@"夜间模式"]) {
            label.textColor = [[ColorManager shareColorManager] theme:title colorWithString:@"themeColor"];
        }else{
            label.textColor = [[ColorManager shareColorManager] theme:title colorWithString:@"textColor"];
        }
        label.font = [UIFont systemFontOfSize: 14];
        [self addSubview: label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_offset(0);
            make.left.equalTo(v.mas_right).mas_offset(10);
        }];
    }
    return self;
}

@end
