//
//  NHPersonalCenterSectionHeaderView.m
//  NeiHan
//
//  Created by Charles on 16/9/8.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHPersonalCenterSectionHeaderView.h"
#import "UIButton+Addition.h"

@interface NHPersonalCenterSectionHeaderView ()
@property (nonatomic, weak) UIButton *colBtn;
@property (nonatomic, weak) UIButton *publishBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *selectButton;
@property (nonatomic, weak) CALayer *runningLineLayer;
@property (nonatomic, weak) CALayer *lineLayer;
@end

@implementation NHPersonalCenterSectionHeaderView

- (void)clickDefault {
    [self btnClick:self.publishBtn];
}


- (void)btnClick:(UIButton *)btn {
    
    self.selectButton.selected = NO;
    btn.selected = YES;
    self.selectButton = btn;
    
    if ([self.delegate respondsToSelector:@selector(personalCenterSectionHeaderView:didClickItemwithType:)]) {
        [self.delegate personalCenterSectionHeaderView:self didClickItemwithType:btn.tag];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.runningLineLayer.frame = CGRectMake(btn.x, self.runningLineLayer.frame.origin.y, self.runningLineLayer.frame.size.width, self.runningLineLayer.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat buttonW = 80;
    CGFloat buttonMargin = (kScreenWidth - 80 * 3) / 4.0;
    self.publishBtn.frame = CGRectMake(buttonMargin,  5, buttonW, self.height * 0.5 - kLineHeight);
    self.colBtn.frame =  CGRectMake(self.publishBtn.right + buttonMargin, self.publishBtn.y, buttonW, self.publishBtn.height);
    self.commentBtn.frame = CGRectMake(self.colBtn.right + buttonMargin, self.colBtn.y, buttonW, self.colBtn.height);
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    
//    self.lineLayer.frame = CGRectMake(0, 0, kScreenWidth, kLineHeight);
    
    if (self.selectButton == nil) {
        self.selectButton = self.publishBtn;
    }
    self.runningLineLayer.frame = CGRectMake(self.selectButton.x, self.height - 2, self.colBtn.width, 2);
}

- (CALayer *)lineLayer {
    if (!_lineLayer) {
        CALayer *line = [CALayer layer];
        [self.layer addSublayer:line];
        _lineLayer = line;
        line.backgroundColor = [kSeperatorColor CGColor];
    }
    return _lineLayer;
}

- (CALayer *)runningLineLayer {
    if (!_runningLineLayer) {
        CALayer *runningLineLayer = [CALayer layer];
        [self.layer addSublayer:runningLineLayer];
        _runningLineLayer = runningLineLayer;
        runningLineLayer.backgroundColor = [kCommonHighLightRedColor CGColor];
    }
    return _runningLineLayer;
}

- (UIButton *)commentBtn {
    if (!_commentBtn) {
        UIButton *commentBtn = [[UIButton alloc] init];
        [self addSubview:commentBtn];
        _commentBtn = commentBtn;
        [commentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
        commentBtn.tag = 3;
        commentBtn.titleLabel.font = kFont(16);
        [commentBtn setTitleColor:kCommonBlackColor forState:UIControlStateNormal];
        [commentBtn setTitleColor:kCommonHighLightRedColor forState:UIControlStateSelected];
    }
    return _commentBtn;
}

- (UIButton *)colBtn {
    if (!_colBtn) {
        UIButton *col = [[UIButton alloc] init];
        [self addSubview:col];
        _colBtn = col;
        [col addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [col setTitle:@"收藏" forState:UIControlStateNormal];
        col.tag = 2;
        col.titleLabel.font = kFont(16);
        [col setTitleColor:kCommonBlackColor forState:UIControlStateNormal];
        [col setTitleColor:kCommonHighLightRedColor forState:UIControlStateSelected];
    }
    return _colBtn;
}

- (UIButton *)publishBtn {
    if (!_publishBtn) {
        UIButton *publishBtn = [[UIButton alloc] init];
        [self addSubview:publishBtn];
        _publishBtn = publishBtn;
        [publishBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [publishBtn setTitle:@"投稿" forState:UIControlStateNormal];
        publishBtn.tag = 1;
        publishBtn.titleLabel.font = kFont(16);
        [publishBtn setTitleColor:kCommonBlackColor forState:UIControlStateNormal];
        [publishBtn setTitleColor:kCommonHighLightRedColor forState:UIControlStateSelected];
    }
    return _publishBtn;
}

@end