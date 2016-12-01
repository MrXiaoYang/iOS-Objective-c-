//
//  NHHomeAttentionEmptyView.m
//  NeiHan
//
//  Created by Charles on 16/8/31.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHHomeAttentionEmptyView.h"
#import "NHCustomCommonEmptyView.h"

@interface NHHomeAttentionEmptyView ()
// 点我找朋友
@property (nonatomic, weak) UIButton *findFriendBtn;
// 空数据界面
@property (nonatomic, weak) NHCustomCommonEmptyView *commonEmptyView;
@end

@implementation NHHomeAttentionEmptyView
// 点我找朋友
- (void)findFriendBtnClick:(UIButton *)btn {
    if (self.homeAttentionEmptyViewFindFriendHandle) {
        self.homeAttentionEmptyViewFindFriendHandle();
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat commonX = 0;
    CGFloat commonY = 10;
    CGFloat commonW = self.width;
    CGFloat commonH = 170;
    self.commonEmptyView.frame = CGRectMake(commonX, commonY, commonW, commonH);
    
    CGFloat findX = 80;
    CGFloat findW = kScreenWidth - findX * 2;
    CGFloat findY = self.commonEmptyView.bottom + 15;
    CGFloat findH = 35;
    self.findFriendBtn.frame = CGRectMake(findX, findY, findW, findH);
}

- (UIButton *)findFriendBtn {
    if (!_findFriendBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _findFriendBtn = btn;
        [btn setTitle:@"点我找朋友" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRed:0.88f green:0.54f blue:0.65f alpha:1.00f];
        [btn addTarget:self action:@selector(findFriendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = kFont(15.0);
    }
    return _findFriendBtn;
}

- (NHCustomCommonEmptyView *)commonEmptyView {
    if (!_commonEmptyView) {
        NHCustomCommonEmptyView *view = [[NHCustomCommonEmptyView alloc] initWithTitle:@"段友圈空空，简直不能忍" secondTitle:@"已经关注了？别着急，他们还没更新呐~" iconname:nil];
        [self addSubview:view];
        _commonEmptyView = view;
    }
    return _commonEmptyView;
}

@end
