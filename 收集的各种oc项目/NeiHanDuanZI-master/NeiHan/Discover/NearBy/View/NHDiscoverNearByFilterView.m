//
//  NHDiscoverNearByFilterView.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDiscoverNearByFilterView.h"
#import "UIButton+Addition.h"
#import "UIView+Layer.h"
#import "UIView+Tap.h"

@interface NHDiscoverNearByFilterView ()
/** 性别*/
@property (nonatomic, assign) NSInteger gender;
/** 透明背景*/
@property (nonatomic, weak) UIView *bgView;
/** 容器视图*/
@property (nonatomic, weak) UIView *contentView;
/** 性别筛选*/
@property (nonatomic, weak) UILabel *nameL;
/** 分割线*/
@property (nonatomic, weak) CALayer *line;
/** 清除位置信息*/
@property (nonatomic, weak) UIButton *clearLocBtn;
/** 标题数组*/
@property (nonatomic, strong) NSArray *titleArray;
/** 图片数组*/
@property (nonatomic, strong) NSArray *imageArray;
/** 当前选中按钮*/
@property (nonatomic, weak) UIButton *selectedButton;
@end

@implementation NHDiscoverNearByFilterView

+ (instancetype)filterViewWithGender:(NSInteger)gender {
    NHDiscoverNearByFilterView *filter = [[self alloc] init];
    filter.gender = gender;
    return filter;
}

- (void)show {
    
    self.frame = [[UIScreen mainScreen] bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self configSubViews];
    
    self.bgView.alpha = 0.0;
    
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        self.bgView.alpha = 1.0;
        self.contentView.y = kScreenHeight - 150;
    } completion:NULL];
}

- (void)dismiss {
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        self.contentView.y = kScreenHeight;
        self.bgView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.bgView removeFromSuperview];
            [self.contentView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

- (void)configSubViews {
    
    self.bgView.frame = self.bounds;
    [self sendSubviewToBack:self.bgView];
    
    CGFloat contentX = 0;
    CGFloat contentY = kScreenHeight;
    CGFloat contentW = kScreenWidth;
    CGFloat contentH = 150;
    self.contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
    CGFloat leftMargin = 25;
    CGFloat nameX = leftMargin;
    CGFloat nameY = 5;
    CGFloat nameW = kScreenWidth - leftMargin * 2;
    CGFloat nameH = self.contentView.height / 8.0;
    self.nameL.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat btnH = self.contentView.height / 4.0;
    CGFloat btnW = (kScreenWidth - leftMargin * 2) / self.titleArray.count;
    for (int i = 0; i < self.titleArray.count; i++) {
        UIButton *btn = (UIButton *)[self.contentView viewWithTag:i + 1];
        btn.frame = CGRectMake(leftMargin + btnW * i, self.nameL.bottom + 8, btnW, btnH);
        btn.layerBorderColor = kLightGrayColor;
        btn.layerBorderWidth = kLineHeight;
    }
    
    CGFloat clearX = leftMargin;
    CGFloat clearY = self.contentView.height / 2.0 + self.contentView.height / 8.0;
    CGFloat clearW = kScreenWidth - leftMargin * 2;
    CGFloat clearH = self.contentView.height / 4.0;
    self.clearLocBtn.frame = CGRectMake(clearX, clearY, clearW, clearH);
}

- (void)btnClick:(UIButton *)btn {
    
    // 1. 设置选中
    if (btn.tag != self.titleArray.count + 1) {
        self.selectedButton.backgroundColor = [UIColor whiteColor];
        btn.backgroundColor = kCommonBgColor;
        self.selectedButton = btn;
    }
    
    // 2. 回调
    if ([self.delegate respondsToSelector:@selector(discoverNearByFilterView:didFilterWithType:)]) {
        [self.delegate discoverNearByFilterView:self didFilterWithType:btn.tag];
    }
    
    // 3. 移除
    [self dismiss];
}

- (void)setGender:(NSInteger)gender {
    _gender = gender;
    
    [self setUpViews];
    
    [self config];
    
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    self.line.frame = CGRectMake(0, self.contentView.height / 2.0, kScreenWidth, kLineHeight);
}

- (void)setUpViews {
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithTitle:self.titleArray[i] normalColor:kBlackColor selectedColor:kBlackColor fontSize:15 target:self action:@selector(btnClick:)];
        [self.contentView addSubview:btn];
        btn.tag = i + 1;
        //        [btn setImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
        //        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
        //        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 45, 0, 0);
    }
}

- (void)config {
    
    //    if (filterType == NHDiscoverNearByFilterTypeAll) {
    //        self.gender = -1;
    //    } else if (filterType == NHDiscoverNearByFilterTypeMale) {
    //        self.gender = 1;
    //    } else if (filterType == NHDiscoverNearByFilterTypeFemale) {
    //        self.gender = 2;
    //    } else if (filterType == NHDiscoverNearByFilterTypeUnknown) {
    //        self.gender = 0;
    //    }
    NSInteger tag = 1;
    if (self.gender == 1) {
        tag = 2;
    } else if (self.gender == -1) {
        tag = 1;
    } else if (self.gender == 0) {
        tag = 4;
    } else if (self.gender == 2) {
        tag = 3;
    }
    UIButton *btn = (UIButton *)[self.contentView viewWithTag:tag];
    //   设置选中
    if (btn.tag != self.titleArray.count + 1) {
        self.selectedButton.backgroundColor = [UIColor whiteColor];
        btn.backgroundColor = kCommonBgColor;
        self.selectedButton = btn;
    }
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"全部", @"男", @"女", @"不明"];
    }
    return _titleArray;
}

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = @[@"", @"user-men", @"user-women", @"Unknown"];
    }
    return _imageArray;
}

- (UIView *)bgView {
    if (!_bgView) {
        UIView *bg = [[UIView alloc] init];
        [self addSubview:bg];
        _bgView = bg;
        bg.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        WeakSelf(weakSelf);
        [bg setTapActionWithBlock:^{
            [weakSelf dismiss];
        }];
    }
    return _bgView;
}

- (CALayer *)line {
    if (!_line) {
        CALayer *line = [CALayer layer];
        [self.contentView.layer addSublayer:line];
        _line = line;
        line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
    }
    return _line;
}

- (UIView *)contentView {
    if (!_contentView) {
        UIView *content = [[UIView alloc] init];
        [self addSubview:content];
        _contentView = content;
        content.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *name = [[UILabel alloc] init];
        [self.contentView addSubview:name];
        _nameL = name;
        name.text = @"性别筛选";
        name.textColor = kLightGrayColor;
        name.font = kFont(14);
    }
    return _nameL;
}

- (UIButton *)clearLocBtn {
    if (!_clearLocBtn) {
        UIButton *clear = [UIButton buttonWithTitle:@"清除位置信息" normalColor:kBlackColor selectedColor:kBlackColor fontSize:15.0 target:self action:@selector(btnClick:)];
        [self.contentView addSubview:clear];
        _clearLocBtn = clear;
        clear.layerBorderColor = kLightGrayColor;
        clear.layerBorderWidth = kLineHeight;
        clear.tag = self.titleArray.count + 1;
    }
    return _clearLocBtn;
}
@end
