//
//  NHHomeAttentionListSectionHeaderView.m
//  NeiHan
//
//  Created by Charles on 16/8/31.ns
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHHomeAttentionListSectionHeaderView.h"

@implementation NHHomeAttentionListSectionHeaderView

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    if (textColor) {
        self.tipL.textColor = textColor;
    }
}

- (void)setTipText:(NSString *)tipText {
    if (tipText == nil) {
        return ;
    }
    _tipText = tipText;
    self.tipL.text = [NSString stringWithFormat:@"  %@", tipText];
}

- (UILabel *)tipL {
    if (!_tipL) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _tipL = label;
        label.font = kFont(15);
        label.textColor = kTextColor;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _tipL;
}
@end
