//
//  NHPublishDraftBottomView.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHPublishDraftBottomView.h"
#import "NHCustomTopImageButton.h"

@interface NHPublishDraftBottomView ()
/** 图片*/
@property (nonatomic, weak) NHCustomTopImageButton *imgBtn;
/** 视频*/
@property (nonatomic, weak) NHCustomTopImageButton *videoBtn;
/** 输入字数*/
@property (nonatomic, weak) UILabel *countL;
/** 匿名*/
@property (nonatomic, weak) UIButton *anonymousBtn;
@end

@implementation NHPublishDraftBottomView

- (void)setLimitCount:(NSInteger)limitCount {
    _limitCount = limitCount;
    self.countL.text = [NSString stringWithFormat:@"还能输入%ld个字", limitCount];
}

- (NHCustomTopImageButton *)imgBtn {
    if (!_imgBtn) {
        NHCustomTopImageButton *btn = [NHCustomTopImageButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _imgBtn = btn;
        [btn setTitle:@"图片" forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(14);
        [btn setTitleColor:kCommonBlackColor forState:UIControlStateNormal];
        btn.tag = 1;
        [btn setImage:[UIImage imageNamed:@"publish_picture"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imgBtn;
}

- (NHCustomTopImageButton *)videoBtn {
    if (!_videoBtn) {
        NHCustomTopImageButton *btn = [NHCustomTopImageButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _videoBtn = btn;
        [btn setTitle:@"视频" forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(14);
        [btn setTitleColor:kCommonBlackColor forState:UIControlStateNormal];
        btn.tag = 2;
        [btn setImage:[UIImage imageNamed:@"publish_video"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoBtn;
}

- (UIButton *)anonymousBtn {
    if (!_anonymousBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _anonymousBtn = btn;
        [btn setTitle:@"匿名" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"anonymous"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"anonymous_press"] forState:UIControlStateSelected];
        btn.titleLabel.font = kFont(14);
        [btn setTitleColor:kCommonBlackColor forState:UIControlStateNormal];
        [btn setTitleColor:kCommonHighLightRedColor forState:UIControlStateSelected];
        btn.tag = 3;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _anonymousBtn;
}

- (UILabel *)countL {
    if (!_countL) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _countL = label;
        label.font = kFont(14);
        label.textColor = kTextColor;
        label.textAlignment = NSTextAlignmentRight;
    }
    return _countL;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 图片
    CGFloat imgX = 10;
    CGFloat imgY = 10;
    CGFloat imgW = 60;
    CGFloat imgH = self.height - imgY * 2;
    self.imgBtn.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
    // 视频
//    CGFloat videoX = self.imgBtn.right + 20;
//    CGFloat videoY = 10;
//    CGFloat videoW = 60;
//    CGFloat videoH = imgH;
//    self.videoBtn.frame = CGRectMake(videoX, videoY, videoW, videoH);
    
    // 匿名
    CGFloat anoX = self.width - 60;
    CGFloat anoY = self.height - 50;
    CGFloat anoW = 50;
    CGFloat anoH = 30;
    self.anonymousBtn.frame = CGRectMake(anoX, anoY, anoW, anoH);
    
    // 输入字数
    CGFloat countX = 0;
    CGFloat countY = 0;
    CGFloat countW = self.width - 10;
    CGFloat countH = 14;
    self.countL.frame = CGRectMake(countX, countY, countW, countH);
}

- (void)btnClick:(UIButton *)btn {
    
    btn.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(publishDraftBottomView:didClickItemWithType:)]) {
        [self.delegate publishDraftBottomView:self didClickItemWithType:btn.tag];
    }
}

@end
