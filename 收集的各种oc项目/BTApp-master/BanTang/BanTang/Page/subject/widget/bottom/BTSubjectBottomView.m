//
//  BTSubjectBottomView.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTSubjectBottomView.h"
#import "BTLoadingView.h"
@interface BTSubjectBottomView()

@property (nonatomic, weak) UIButton *joinButton;

@property (nonatomic, strong) BTLoadingView *loadingView;

@end

@implementation BTSubjectBottomView

+ (instancetype)bottomView
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [joinButton setImage:[UIImage imageNamed:@"btn_subject_participate"]
                    forState:UIControlStateNormal];
        [joinButton setImage:[UIImage imageNamed:@"btn_subject_participate_highlighted"]
                    forState:UIControlStateHighlighted];
        [joinButton addTarget:self action:@selector(joinButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:joinButton];
        self.joinButton = joinButton;
    }
    return self;
}

- (void)joinButtonDidClick
{
    if (self.joinButtonDidBlock) {
        self.joinButtonDidBlock();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = 137;
    CGFloat buttonH = 60;
    CGFloat buttonX = (self.width - buttonW) * 0.5;
    CGFloat buttonY = (self.height - buttonH) * 0.5;
    self.joinButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
}

@end
