//
//  NHCheckReportBottomView.m
//  NeiHan
//
//  Created by Charles on 16/9/5.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHCheckReportBottomView.h"
#import "UIView+Tap.h"
#import "UIButton+Addition.h"

@interface NHCheckReportBottomView ()
@property (nonatomic, strong) NSArray *reportCategoryArray;
/** 透明背景*/
@property (nonatomic, weak) UIView *bgView;
/** 容器视图*/
@property (nonatomic, weak) UIView *contentView;
/** 举报*/
@property (nonatomic, weak) UIButton *cancelBtn;
@property (nonatomic, weak) CALayer *lineLayer;
@property (nonatomic, weak) UIButton *selectButton;
@end

@implementation NHCheckReportBottomView
- (void)showInView:(UIView *)view {
    UIWindow *window = nil;

    if (view == nil) {
        window = [UIApplication sharedApplication].keyWindow;
    } else {
        window = view.window;
    }
    [window addSubview:self];
    
    self.frame = window.bounds;
    self.bgView.frame = self.bounds;
    self.bgView.alpha = 0;
    
    
    CGFloat topMargin = 15;
    CGFloat cancelH = 44;
    CGFloat btnX;
    CGFloat btnY;
    CGFloat btnW = (kScreenWidth - 40) / 2.0;
    CGFloat btnH = 40;
    
    
    for (int i = 0; i < self.reportCategoryArray.count; i++) {
        UIButton *btn = (UIButton *)[self.contentView viewWithTag:i + 1];
        btnX = i % 2 * btnW + 20;
        btnY = i / 2 * btnH + topMargin;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    CGFloat lineX = 0;
    CGFloat lineY = btnH * self.reportCategoryArray.count / 2 + topMargin * 2;
    CGFloat lineW = kScreenWidth;
    CGFloat lineH = kLineHeight;
    self.lineLayer.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat cancelX = 0;
    CGFloat cancelY = lineY;
    CGFloat cancelW = kScreenWidth;
    self.cancelBtn.frame = CGRectMake(cancelX, cancelY, cancelW, cancelH);
    
    CGFloat contentX = 0;
    CGFloat contentH = topMargin * 2 + btnH * self.reportCategoryArray.count / 2 + cancelH + lineH;
    CGFloat contentY = kScreenHeight;
    CGFloat contentW = kScreenWidth;
    self.contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        self.bgView.alpha = 1.0;
        self.contentView.y = kScreenHeight - self.contentView.height;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        self.bgView.alpha = 0.0;
        self.contentView.y = kScreenHeight;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.bgView removeFromSuperview];
            [self.contentView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

- (void)cancelBtnClick:(UIButton *)btn {
    [self dismiss];
}

- (void)btnClick:(UIButton *)btn {
    if (self.selectButton == btn) {
        return ;
    }
    self.selectButton.selected = NO;
    btn.selected = YES;
    self.selectButton = btn;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.checkReportBottomViewDidClickReportReasonHandle) {
            self.checkReportBottomViewDidClickReportReasonHandle(self, btn.currentTitle, btn.tag - 1);
        }
    });
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    
    for (int i = 0; i < self.reportCategoryArray.count; i++) {
        UIButton *btn = [[UIButton alloc ]init];
        [self.contentView addSubview:btn];
        btn.tag = i + 1;
        [btn setTitle:self.reportCategoryArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(14);
        [btn setTitleColor:kBlackColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"selectround_detail_report"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"selectround_detail_report_press"] forState:UIControlStateSelected];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
    }
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        UIButton *cancel = [UIButton buttonWithTitle:@"取消" normalColor:[UIColor colorWithRed:0.48f green:0.82f blue:0.90f alpha:1.00f] selectedColor:[UIColor colorWithRed:0.48f green:0.82f blue:0.90f alpha:1.00f] fontSize:16.0 target:self action:@selector(cancelBtnClick:)];
        [self.contentView addSubview:cancel];
        _cancelBtn = cancel;
    }
    return _cancelBtn;
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

- (NSArray *)reportCategoryArray {
    if (!_reportCategoryArray) {
        _reportCategoryArray = @[@"垃圾广告", @"淫秽色情", @"煽情骗顶", @"以前看过", @"抄袭我的内容", @"其他"];
    }
    return _reportCategoryArray;
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
        [self sendSubviewToBack:bg];
    }
    return _bgView;
}

- (CALayer *)lineLayer {
    if (!_lineLayer) {
        CALayer *line = [CALayer layer];
        [self.contentView.layer addSublayer:line];
        _lineLayer = line;
        line.backgroundColor = [kBlackColor CGColor];
    }
    return _lineLayer;
}
@end
