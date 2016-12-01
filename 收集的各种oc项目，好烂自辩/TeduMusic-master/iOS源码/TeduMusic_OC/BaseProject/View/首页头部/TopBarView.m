//
//  TopBarView.m
//  BaseProject
//
//  Created by jiyingxin on 15/12/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TopBarView.h"

@implementation TopBarView

+ (TopBarView *)defaultTopBarView{
    static TopBarView *v = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        v = kViewForClass([self class]);
    });
    return v;
}

- (id)initWithDelegate:(id<TopBarViewDelegate>)delegate{
    TopBarView *tbView = kViewForClass([self class]);
    tbView.delegate = delegate;
    return tbView;
}

- (void)awakeFromNib{
    _currentBtn = _myBtn;
}

- (IBAction)discover:(UIButton *)sender {
    [self changeBtnState:sender];
    [_delegate topBarView:self clicksBtnWithType:TopBarViewBtnTypeDiscover];
}

- (IBAction)clickMy:(UIButton *)sender {
    [self changeBtnState:sender];
    [_delegate topBarView:self clicksBtnWithType:TopBarViewBtnTypeMy];
}

- (IBAction)clickMusicHouse:(UIButton *)sender {
    [self changeBtnState:sender];
    [_delegate topBarView:self clicksBtnWithType:TopBarViewBtnTypeMusicHouse];
}

- (IBAction)search:(UIButton *)sender {
    [_delegate topBarView:self clicksBtnWithType:TopBarViewBtnTypeSearch];
}

- (IBAction)clickHeadImg:(UIButton *)sender {
    [_delegate topBarView:self clicksBtnWithType:TopBarViewBtnTypeHeader];
}

- (void)changeBtnState:(UIButton *)sender{
    _currentBtn.enabled = YES;
    _currentBtn = sender;
    _currentBtn.enabled = NO;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
