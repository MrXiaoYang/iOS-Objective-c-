//
//  NHPersonalCenterCountView.m
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHPersonalCenterHeaderCountView.h"

@interface NHPersonalCenterHeaderCountViewLabelButton : UIButton
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, weak) UILabel *topLabel;
@property (nonatomic, weak) UILabel *bottomLabel;
@property (nonatomic, assign)  NHPersonalCenterHeaderViewItemType type;
@end

@implementation NHPersonalCenterHeaderCountViewLabelButton

- (void)setText:(NSString *)text {
    _text = text;
    self.bottomLabel.text = text;
}

- (void)setCount:(NSInteger)count {
    _count = count;
    // 如果count <= 0 则显示0 不要显示负数
    self.topLabel.text = [NSString stringWithFormat:@"%ld", count <= 0 ? 0 : (long)count];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //    CGFloat labelH = self.frame.size.height / 2.0;
    CGFloat labelW = self.frame.size.width;
    self.topLabel.frame = CGRectMake(0, 5, labelW, 20);
    self.bottomLabel.frame = CGRectMake(0, self.topLabel.bottom, labelW, 20);
}

- (UILabel *)topLabel {
    if (!_topLabel) {
        UILabel *topL = [[UILabel alloc] init];
        [self addSubview:topL];
        _topLabel = topL;
        topL.textAlignment = NSTextAlignmentCenter;
        topL.text = [NSString stringWithFormat:@"%ld", (long)self.count];
        topL.font = [UIFont systemFontOfSize:16];
        topL.textColor = kCommonBlackColor;
    }
    return _topLabel;
}

- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        UILabel *bottomL = [[UILabel alloc] init];
        [self addSubview:bottomL];
        _bottomLabel = bottomL;
        bottomL.textAlignment = NSTextAlignmentCenter;
        bottomL.text = self.text;
        bottomL.font = [UIFont systemFontOfSize:12];
        bottomL.textColor = kCommonBlackColor;
    }
    return _bottomLabel;
}

@end

@interface NHPersonalCenterHeaderCountView ()
@property (nonatomic, weak) CALayer *topLayer;
@property (nonatomic, weak) CALayer *bottomLayer;
@property (nonatomic, weak) NHPersonalCenterHeaderCountViewLabelButton *attentionButton;
@property (nonatomic, weak) NHPersonalCenterHeaderCountViewLabelButton *fansButton;
@property (nonatomic, weak) NHPersonalCenterHeaderCountViewLabelButton *stateButton;
@end
@implementation NHPersonalCenterHeaderCountView

- (void)buttonAction:(NHPersonalCenterHeaderCountViewLabelButton *)button {
    if ([self.delegate respondsToSelector:@selector(personalCenterHeaderCountView:buttonType:)]) {
        [self.delegate personalCenterHeaderCountView:self buttonType:button.type];
    }
}

- (void)setFollow_count:(NSInteger)follow_count {
    _follow_count = follow_count;
    self.attentionButton.count = follow_count;
}

- (void)setShare_count:(NSInteger)share_count {
    _share_count = share_count;
    self.stateButton.count = share_count;
}

- (void)setFans_count:(NSInteger)fans_count {
    _fans_count = fans_count;
    self.fansButton.count = fans_count;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat leftRightMargin = kScreenWidth < 375 ? 40 : 50;
    CGFloat margin = kScreenWidth < 375 ? 25 : 30;
    CGFloat btnW = (kScreenWidth - leftRightMargin * 2 - margin * 2 ) / 3.0;
    CGFloat btnY = 15;
    CGFloat btnH = self.frame.size.height - btnY;
    
    self.attentionButton.frame = CGRectMake(leftRightMargin,  btnY, btnW, btnH);
    self.fansButton.frame = CGRectMake(self.attentionButton.right + margin, btnY, btnW, btnH);
    self.stateButton.frame = CGRectMake(self.fansButton.right + margin, btnY, btnW, btnH);
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    CGFloat layerW = self.layer.frame.size.width;
    CGFloat layerH = self.layer.frame.size.height;
    self.topLayer.frame = CGRectMake(0, 0, layerW, kLineHeight);
    self.bottomLayer.frame = CGRectMake(0, layerH - kLineHeight, layerW, kLineHeight);
}

- (CALayer *)topLayer {
    if (!_topLayer) {
        CALayer *topLayer = [CALayer layer];
        [self.layer addSublayer:topLayer];
        _topLayer = topLayer;
        topLayer.backgroundColor = kSeperatorColor.CGColor;
    }
    return _topLayer;
}

- (CALayer *)bottomLayer {
    if (!_bottomLayer) {
        CALayer *bottomLayer = [CALayer layer];
        [self.layer addSublayer:bottomLayer];
        _bottomLayer = bottomLayer;
        bottomLayer.backgroundColor = kSeperatorColor.CGColor;
    }
    return _bottomLayer;
}

- (NHPersonalCenterHeaderCountViewLabelButton *)attentionButton {
    if (!_attentionButton) {
        NHPersonalCenterHeaderCountViewLabelButton *attention = [NHPersonalCenterHeaderCountViewLabelButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:attention];
        _attentionButton = attention;
        [attention addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        attention.type = NHPersonalCenterHeaderViewItemTypeGotoAtt;
        attention.text = @"关注";
    }
    return _attentionButton;
}

- (NHPersonalCenterHeaderCountViewLabelButton *)fansButton {
    if (!_fansButton) {
        NHPersonalCenterHeaderCountViewLabelButton *fans = [NHPersonalCenterHeaderCountViewLabelButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:fans];
        _fansButton = fans;
        [fans addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        fans.type = NHPersonalCenterHeaderViewItemTypeGotoFans;
        fans.text = @"粉丝";
    }
    return _fansButton;
}

- (NHPersonalCenterHeaderCountViewLabelButton *)stateButton {
    if (!_stateButton) {
        NHPersonalCenterHeaderCountViewLabelButton *state = [NHPersonalCenterHeaderCountViewLabelButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:state];
        _stateButton = state;
        [state addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        state.type = NHPersonalCenterHeaderViewItemTypeGotoIntegral;
        state.text = @"积分";
    }
    return _stateButton;
}
@end
