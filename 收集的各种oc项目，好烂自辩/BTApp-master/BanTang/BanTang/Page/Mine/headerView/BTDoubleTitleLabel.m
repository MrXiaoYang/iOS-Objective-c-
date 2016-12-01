//
//  BTDoubleTitleLabel.m
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTDoubleTitleLabel.h"
#import <Masonry.h>
@implementation BTDoubleTitleLabel
{
    UILabel *_titleLabel;
    UILabel *_numLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(tap)];
        [self addGestureRecognizer:tap];
        
        _numLabel = [[UILabel alloc] init];
        _numLabel.font = BTFont(15);
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.textColor = [UIColor whiteColor];
        [self addSubview:_numLabel];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(4);
            make.centerX.mas_equalTo(self.centerX);
            make.size.mas_equalTo(CGSizeMake(18.5, 17.5));
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = BTFont(12);
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_numLabel.mas_bottom).offset(2);
            make.centerX.mas_equalTo(self.centerX);
            make.size.mas_equalTo(CGSizeMake(24, 14));
        }];
    }
    return self;
}

- (void)tap
{
    if (self.tapBlock) {
        self.tapBlock();
    }
}

- (void)setNum:(NSString *)num
{
    _num = num;
    _numLabel.text = num;
	
	CGSize titleSize = [num titleSizeWithfontSize:15 maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
	
	[_numLabel mas_updateConstraints:^(MASConstraintMaker *make) {
		make.size.mas_equalTo(CGSizeMake(titleSize.width, titleSize.height));
	}];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _titleLabel.text = title;
}
@end
