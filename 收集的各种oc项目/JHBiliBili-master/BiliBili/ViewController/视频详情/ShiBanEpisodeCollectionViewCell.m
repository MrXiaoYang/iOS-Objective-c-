//
//  ShiBanEpisodeCollectionViewCell.m
//  BiliBili
//
//  Created by apple-jd44 on 15/12/3.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ShiBanEpisodeCollectionViewCell.h"

@implementation ShiBanEpisodeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"ShiBanEpisodeCollectionViewCell.backgroundColor"];
        [self.contentView addSubview: self.titleLabel];
    }
    return self;
}
- (UILabel *)titleLabel {
	if(_titleLabel == nil) {
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_titleLabel setTextColor:[[ColorManager shareColorManager] colorWithString:@"textColor"]];
        _titleLabel.font = [UIFont systemFontOfSize: 13];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
	}
	return _titleLabel;
}

@end
