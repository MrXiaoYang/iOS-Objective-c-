//
//  NHHomeTableCellVideoCoverImageView.m
//  NeiHan
//
//  Created by Charles on 16/9/9.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHHomeTableCellVideoCoverImageView.h"

@interface NHHomeTableCellVideoCoverImageView ()

@property (nonatomic, weak) UIButton *playBtn;

@end

@implementation NHHomeTableCellVideoCoverImageView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
    return self;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        UIButton *play = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:play];
        _playBtn = play;
        WeakSelf(weakSelf);
        [play mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.center.equalTo(weakSelf);
        }];
        [play addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (void)playBtnClick:(UIButton *)btn {
    if (self.homeTableCellVideoDidBeginPlayHandle) {
        self.homeTableCellVideoDidBeginPlayHandle(btn);
    }
}
@end
