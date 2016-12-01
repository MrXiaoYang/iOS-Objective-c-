//
//  ProfileTableViewCell.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/19.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ProfileTableViewCell.h"
@interface ProfileTableViewCell ()
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIImageView* imgView;
@end

@implementation ProfileTableViewCell

- (instancetype)initWithTitle:(NSString*)title imgName:(NSString*)imgName{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize: 13];
        self.titleLabel.text = title;
        self.titleLabel.textColor = kRGBColor(129, 129, 129);

        UIImage* img = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.imgView = [[UIImageView alloc] initWithImage:img];
        self.imgView.tintColor = kRGBColor(129, 129, 129);
        [self.contentView addSubview: self.titleLabel];
        [self.contentView addSubview: self.imgView];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(self.contentView.mas_height).mas_offset(-20);
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).mas_offset(10);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.contentView);
            make.left.mas_equalTo(self.imgView.mas_right).mas_offset(20);
        }];
    }
    return self;
}

@end
