//
//  BTIconLabelView.m
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTIconLabelView.h"
#import <Masonry.h>

@implementation BTIconLabelView
{
    UILabel *_titleLabel;
    UIImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(tap)];
        [self addGestureRecognizer:tap];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.centerX);
            make.top.mas_equalTo(2);
            make.size.mas_equalTo(CGSizeMake(18, 16));
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = BTFont(11);
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_imageView.mas_bottom).offset(4);
            make.centerX.mas_equalTo(self.centerX);
            make.size.mas_equalTo(CGSizeMake(15, 13));
        }];
    }
    return self;
}

- (void)tap
{
    if (self.tapIconBlock) {
        self.tapIconBlock();
    }
}

- (void)setNum:(NSString *)num
{
    _num = num;
	
    _titleLabel.text = num;
}

- (void)setIconImageName:(NSString *)iconImageName
{
    _iconImageName = iconImageName;
    _imageView.image = [UIImage imageNamed:iconImageName];
}

@end
