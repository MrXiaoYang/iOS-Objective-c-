//
//  NHPublishDraftPictureCollectionViewCell.m
//  NeiHan
//
//  Created by Charles on 16/9/2.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHPublishDraftPictureCollectionViewCell.h"
#import "UIView+Tap.h"

@interface NHPublishDraftPictureCollectionViewCell ()
@property (nonatomic, weak) UIImageView *bgImgView;
@property (nonatomic, weak) UIButton *closeBtn;
@end

@implementation NHPublishDraftPictureCollectionViewCell

- (void)setImage:(UIImage *)image {
    _image = image;
    if (image) {
        self.bgImgView.image = image;
    }
}

- (void)setHiddenCloseBtn:(BOOL)hiddenCloseBtn {
    _hiddenCloseBtn = hiddenCloseBtn;
    self.closeBtn.hidden = hiddenCloseBtn;
}

// 删除
- (void)closeBtnClick:(UIButton *)btn {
    if (self.publishDraftPictureCellDeleteImgHandle) {
        self.publishDraftPictureCellDeleteImgHandle(self);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 删除按钮
    CGFloat closeW = self.closeBtn.currentImage.size.width;
    CGFloat closeH = self.closeBtn.currentImage.size.height;
    CGFloat closeX = self.contentView.width - closeW;
    CGFloat closeY = 0;
    self.closeBtn.frame = CGRectMake(closeX, closeY, closeW, closeH);
    [self bringSubviewToFront:self.closeBtn];
    
    // 图片
    CGFloat margin = 2.5;
    CGFloat bgX = margin;
    CGFloat bgY = margin;
    CGFloat bgW = self.contentView.width - margin * 2.0;
    CGFloat bgH = self.contentView.height - margin * 2.0;
    self.bgImgView.frame = CGRectMake(bgX, bgY, bgW, bgH);
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        UIImageView *bg = [[UIImageView alloc] init];
        [self.contentView addSubview:bg];
        _bgImgView = bg;
        bg.contentMode = UIViewContentModeScaleAspectFill;
        bg.clipsToBounds = YES;
        WeakSelf(weakSelf);
        [bg setTapActionWithBlock:^{
            if (weakSelf.closeBtn.hidden == NO) return ;
            if (weakSelf.publishDraftPictureCellAddImgHandle) {
                weakSelf.publishDraftPictureCellAddImgHandle(weakSelf);
            }
        }];
    }
    return _bgImgView;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        UIButton *btn = [[UIButton alloc] init];
        [self.contentView addSubview:btn];
        _closeBtn = btn;
        [btn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"publish_delete"] forState:UIControlStateNormal];
    }
    return _closeBtn;
}
@end
