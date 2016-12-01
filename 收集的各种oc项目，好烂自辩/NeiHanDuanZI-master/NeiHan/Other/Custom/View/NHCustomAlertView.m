//
//  NHCustomAlertView.m
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHCustomAlertView.h"
#import "FXBlurView.h"
#import "NHAnimationManager.h"
#import "NSAttributedString+Size.h"
#import "UIImage+Addition.h"

#define kTag 111111

@interface NHCustomAlertView ()
@property (nonatomic, strong) FXBlurView *blurView;
@property (nonatomic, strong) UIView *dimmingView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIButton *cancelBtn;
@property (nonatomic, weak) UIButton *sureBtn;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cancel;
@property (nonatomic, copy) NSString *sure;
@property (nonatomic, copy) BOOL(^touchBlock)();
@property (nonatomic, copy) BOOL(^cancelBlock)();
@property (nonatomic, weak) UIView *btnLine;
@property (nonatomic, weak) UILabel *tipL;
@end

@implementation NHCustomAlertView

+ (BOOL)alertIsShowingInView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    UIView *alert = [view viewWithTag:kTag];
    return alert != nil;
}

- (instancetype)initWithTitle:(NSString *)title cancel:(NSString *)cancel sure:(NSString *)sure {
    if (self = [super init]) {
        _title = title;
        _cancel = cancel;
        _sure = sure;
        [self setup];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
    
    _blurView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _blurView.tintColor = [UIColor clearColor];
    
    
    UILabel *tip = [[UILabel alloc] init];
    [self.contentView addSubview:tip];
    _tipL = tip;
    tip.text = @"提示";
    tip.textAlignment = NSTextAlignmentCenter;
    tip.font = [UIFont systemFontOfSize:kScreenWidth > 320 ? 16 : 15];
    tip.textColor = kCommonBlackColor;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:kValidStr(self.title.length ? self.title : @"")];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[kCommonBlackColor colorWithAlphaComponent:0.8] range:NSMakeRange(0, attributedText.length)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    [attributedText addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attributedText.length)];
    [attributedText addAttribute:NSFontAttributeName value:kFont(kScreenWidth > 320 ? 15 : 14) range:NSMakeRange(0, attributedText.length)];
    contentLabel.attributedText = attributedText;
    
    [self.contentView addSubview:contentLabel];
    _contentLabel = contentLabel;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.textColor = kCommonBlackColor;
    contentLabel.numberOfLines = 0;
    
    UIButton *cancel = [[UIButton alloc] init];
    [cancel setTitle:self.cancel.length ? self.cancel : @"取消" forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancel addTarget:self action:@selector(cancelTouch) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:kCommonBlackColor forState:UIControlStateNormal];
    [cancel setBackgroundImage:[NHUtils imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3]] forState:UIControlStateNormal];
    [cancel setBackgroundImage:[NHUtils imageWithColor:[[UIColor lightTextColor] colorWithAlphaComponent:0.3]] forState:UIControlStateHighlighted];
    
    [self.contentView addSubview:cancel];
    _cancelBtn = cancel;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kSeperatorColor;
    [self.contentView addSubview:line];
    _line = line;
    
    UIButton *sure = [[UIButton alloc] init];
    [ sure setTitle:self.sure.length ? self.sure : @"确定" forState:UIControlStateNormal];
    sure.titleLabel.font = [UIFont systemFontOfSize:15];
    [sure addTarget:self action:@selector(sureTouch) forControlEvents:UIControlEventTouchUpInside];
    [sure setTitleColor:kRedColor forState:UIControlStateNormal];
    [sure setBackgroundImage:[NHUtils imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3]] forState:UIControlStateNormal];
    [sure setBackgroundImage:[NHUtils imageWithColor:[[UIColor lightTextColor] colorWithAlphaComponent:0.3]] forState:UIControlStateHighlighted];
    
    [self.contentView addSubview:sure];
    _sureBtn = sure;
    
    UIView *btnLine = [[UIView alloc] init];
    [self.contentView addSubview:btnLine];
    _btnLine = btnLine;
    btnLine.backgroundColor = kLightGrayColor;
    
    [self addSubview:_contentView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView setFrame:CGRectMake(0, 0, kScreenWidth * 0.7, 150)];
    
    self.tipL.frame = CGRectMake(0, 20, self.contentView.width, 13);
    
    NSAttributedString *string = self.contentLabel.attributedText;
    CGFloat labelH = [string heightWithConstrainedWidth:self.contentView.width - 40];
    
    self.contentLabel.frame = CGRectMake(20, self.tipL.bottom + 25, self.contentView.width - 40, labelH);
    
    self.line.frame = CGRectMake(0, self.contentLabel.bottom + 25, self.contentView.width, 0.5);
    if (self.cancel.length == 0 && self.sure.length != 0) {
        
        self.sureBtn.frame = CGRectMake(0, self.line.bottom, self.contentView.width , 50);
        [self.cancelBtn removeFromSuperview];
        [self.btnLine removeFromSuperview];
    } else if (self.cancel.length != 0 && self.sure.length == 0) {
        
        self.cancelBtn.frame = CGRectMake(0, self.line.bottom, self.contentView.width, 50);
        [self.sureBtn removeFromSuperview];
        [self.btnLine removeFromSuperview];
        
    } else if (self.cancel.length != 0 && self.sure.length != 0) {
        
        
        self.cancelBtn.frame = CGRectMake(0, self.line.bottom, self.contentView.width / 2.0f, 50);
        self.btnLine.frame = CGRectMake(self.cancelBtn.right, self.line.bottom + 10, kLineHeight, 30);
        self.sureBtn.frame = CGRectMake(self.cancelBtn.right, self.line.bottom, self.contentView.width /2.0f, 50);
    }
    self.contentView.height = (self.line.bottom + 50);
    self.contentView.center = self.center;
}

// 取消
- (void)cancelTouch {
    if (!self.cancelBlock) {
        [UIView animateWithDuration:0.35 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
                [_blurView clearImage];
                [_blurView removeFromSuperview];
            }
        }];
    } else {
        [UIView animateWithDuration:0.35 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
                [_blurView clearImage];
                [_blurView removeFromSuperview];
                if (self.cancelBlock) {
                    self.cancelBlock();
                }
            }
        }];
    }
    
}

// 确定
- (void)sureTouch {
    if (self.touchBlock) {
        [UIView animateWithDuration:0.35 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
                [_blurView clearImage];
                [_blurView removeFromSuperview];
                if (self.touchBlock) {
                    self.touchBlock();
                }
            }
        }];
    } else {
        [UIView animateWithDuration:0.35 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
                [_blurView clearImage];
                [_blurView removeFromSuperview];
            }
        }];
        
        
    }
}

- (void)setupCancelBlock:(BOOL (^)())cancelBlock {
    _cancelBlock = cancelBlock;
}

- (void)setupSureBlock:(BOOL (^)())touchBlock {
    _touchBlock = touchBlock;
}

- (UIView *)contentView {
    if (_contentView == nil) {
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        _contentView = contentView;
        contentView.layer.cornerRadius = 4.0f;
        contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (void)showInView:(UIView *)view {
    
    BOOL isShowing = [NHCustomAlertView alertIsShowingInView:view];
    if (isShowing) return ;
    
    UIView *content = view ? view  : [UIApplication sharedApplication].keyWindow;
    _blurView.blurRadius = 0;
    self.frame = content.bounds;
    self.alpha = 0;
    self.tag = kTag;
    
    [content addSubview:_blurView];
    [content addSubview:self];
    
    [NHAnimationManager addTransformAnimationForView:self.contentView];
    
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 1;
        _blurView.blurRadius = 12.0f;
    } completion:^(BOOL finished) {
        _blurView.dynamic = NO;
        [FXBlurView setUpdatesDisabled];
    }];
}
@end
