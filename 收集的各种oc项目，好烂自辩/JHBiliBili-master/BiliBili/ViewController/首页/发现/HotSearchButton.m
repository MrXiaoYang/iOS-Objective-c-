//
//  HotSearchButton.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/23.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "HotSearchButton.h"
@implementation HotSearchButton
- (instancetype)initWithKeyWord:(NSString*)keyWord{
    if (self = [super init]) {
        self.label.text = keyWord;
        [self addSubview: self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
    }
    return self;
}

- (UILabel *)label {
	if(_label == nil) {
		_label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize: 13];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
	}
	return _label;
}

@end
