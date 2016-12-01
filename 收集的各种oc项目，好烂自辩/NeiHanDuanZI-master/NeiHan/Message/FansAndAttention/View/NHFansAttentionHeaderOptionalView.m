//
//  NHFansAttentionHeaderOptionalView.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHFansAttentionHeaderOptionalView.h"

@interface NHFansAttentionHeaderOptionalView ()
@property (nonatomic, weak) UIButton *selectedBtn;
@end

@implementation NHFansAttentionHeaderOptionalView

+ (instancetype)optionalView {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)clickDefaultWithIndex:(NSInteger)index {
    [self btnClick:(UIButton *)[self viewWithTag:index + 1]];
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    UIButton *btn = (UIButton *)[self viewWithTag:selectIndex + 1];
    
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}

- (void)setUpViews {
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0.88f green:0.54f blue:0.65f alpha:1.00f] forState:UIControlStateSelected];
        btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        btn.titleLabel.font = kFont(15);
        if (i == 0) {
            [btn setTitle:@"关注" forState:UIControlStateNormal];
        } else if (i == 1) {
            [btn setTitle:@"粉丝" forState:UIControlStateNormal];
        }
    }
}

- (void)btnClick:(UIButton *)btn {
    
    // 选中操作
    self.selectIndex = btn.tag - 1;
    
    // 回调事件
    if (self.fansAttentionHeaderOptionalViewBtnClickHandle) {
        self.fansAttentionHeaderOptionalViewBtnClickHandle(self, btn, btn.tag - 1);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnW = self.width / 2.0;
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i + 1];
        btn.frame = CGRectMake(btnW * i, 0, btnW, self.height);
    }
}
@end
