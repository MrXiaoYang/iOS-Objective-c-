//
//  NHHomeTopTipView.m
//  NeiHan
//
//  Created by Charles on 16/9/9.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHHomeTopTipView.h"

@interface NHHomeTopTipView ()
@property (nonatomic, weak) UILabel *tipL;
@end

@implementation NHHomeTopTipView

- (void)setTipText:(NSString *)tipText {
    _tipText = tipText;
    if (tipText) {
        self.tipL.text = tipText;
    }
}
- (UILabel *)tipL {
    if (!_tipL) {
        UILabel *tip = [[UILabel alloc] init];
        [self addSubview:tip];
        _tipL = tip;
        tip.textColor = kWhiteColor;
        tip.backgroundColor = kCommonHighLightRedColor;
        tip.textAlignment = NSTextAlignmentCenter;
        tip.font = kFont(12);
        WeakSelf(weakSelf);
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
    }
    return _tipL;
} 
@end
