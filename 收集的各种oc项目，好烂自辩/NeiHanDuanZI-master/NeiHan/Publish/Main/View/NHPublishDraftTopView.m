//
//  NHPublishDraftTopView.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHPublishDraftTopView.h"
#import "UIButton+Addition.h"
#import "UIView+Layer.h"
#import "NSString+Size.h"

@interface NHPublishDraftTopView ()
/** 投稿至*/
@property (nonatomic, weak) UILabel *leftL;
/** 吧名*/
@property (nonatomic, weak) UIButton *topicBtn;
/** 点击更换吧*/
@property (nonatomic, weak) UIButton *indicatorBtn;
@end

@implementation NHPublishDraftTopView

+ (instancetype)topView {
    return [[self alloc] init];
}

- (void)setTopicName:(NSString *)topicName {
    _topicName = topicName;
    if (topicName.length == 0) {
        return ;
    }
    [self.topicBtn setTitle:topicName forState:UIControlStateNormal];
    
    [self setNeedsLayout];
    
}

- (void)topicBtnClick:(UIButton *)btn {
    if (self.publishDraftTopViewChangeTopicHandle) {
        self.publishDraftTopViewChangeTopicHandle();
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 投稿至
    CGFloat leftX = 10;
    CGFloat leftY = 0;
    CGFloat leftW = 40;
    CGFloat leftH = self.height;
    self.leftL.frame = CGRectMake(leftX, leftY, leftW, leftH);
    
    // 吧名
    CGFloat topicX = self.leftL.right + 8;
    CGFloat topicY = 15;
    CGFloat topicH = self.height - topicY * 2;
    CGFloat topicW = [self.topicBtn.currentTitle widthWithFont:self.topicBtn.titleLabel.font constrainedToHeight:topicH] + 18;
    self.topicBtn.frame = CGRectMake(topicX, topicY, topicW, topicH);
    
    // 点击更换吧
    CGFloat indX = self.topicBtn.right + 8;
    CGFloat indY = 10;
    CGFloat indH = self.height - 20;
    CGFloat indW = [self.indicatorBtn.currentTitle widthWithFont:self.indicatorBtn.titleLabel.font constrainedToHeight:indH] + 18;
    self.indicatorBtn.frame = CGRectMake(indX, indY, indW, indH);
}

- (UIButton *)indicatorBtn {
    if (!_indicatorBtn) {
        UIButton *btn = [UIButton buttonWithTitle:@"点击更换吧" normalColor:kLightGrayColor selectedColor:kLightGrayColor fontSize:14 target:nil action:nil];
        [self addSubview:btn];
        _indicatorBtn = btn;
        [btn setImage:[UIImage imageNamed:@"instructions"] forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    }
    return _indicatorBtn;
}

- (UIButton *)topicBtn {
    if (!_topicBtn) {
        UIButton *btn = [UIButton buttonWithTitle:@"聊电影" normalColor:kCommonHighLightRedColor selectedColor:kCommonHighLightRedColor fontSize:13 target:self action:@selector(topicBtnClick:)];
        [self addSubview:btn];
        _topicBtn = btn;
        btn.layerCornerRadius = 5.0;
        btn.layerBorderWidth = 1.0;
        btn.layerBorderColor = kCommonHighLightRedColor;
    }
    return _topicBtn;
}

- (UILabel *)leftL {
    if (!_leftL) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _leftL = label;
        label.font = kFont(13);
        label.textColor = kTextColor;
        label.text = @"投稿至";
    }
    return _leftL;
}
@end
