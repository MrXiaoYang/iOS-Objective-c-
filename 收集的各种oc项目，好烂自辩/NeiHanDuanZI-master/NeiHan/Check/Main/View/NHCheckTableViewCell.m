//
//  NHCheckTableViewCell.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHCheckTableViewCell.h"
#import "NHCheckViewCellFrame.h"
#import "NHHomeServiceDataModel.h"
#import "UIButton+Addition.h"
#import "UIView+Layer.h"
#import "NHCheckTableViewProgressBar.h"
#import "UIImageView+Addition.h"
#import "NHCustomGifImageView.h"

@interface NHCheckTableViewCell ()
/** 滚动视图(容器)*/
@property (nonatomic, weak) UIScrollView *scrollView;
/** 文本*/
@property (nonatomic, weak) UILabel *contentL;
/** 顶部白色区域*/
@property (nonatomic, weak) UIView *topContentL;
/** 举报*/
@property (nonatomic, weak) UIButton *reportBtn;
/** 大图*/
@property (nonatomic, weak) NHBaseImageView *largeImageCover;
/** 视频封面*/
@property (nonatomic, weak) NHBaseImageView *videoCover;
/** Gif图*/
@property (nonatomic, weak) NHCustomGifImageView *gifCover;
/** 喜欢*/
@property (nonatomic, weak) UIButton *likeBtn;
/** 喜欢*/
@property (nonatomic, weak) UILabel *likeL;
/** 不喜欢*/
@property (nonatomic, weak) UIButton *disLikeBtn;
/** 不喜欢*/
@property (nonatomic, weak) UILabel *disLikeL;
/** 底部bar*/
@property (nonatomic, weak) NHCheckTableViewProgressBar *bar;
@end

@implementation NHCheckTableViewCell

- (void)setCellFrame:(NHCheckViewCellFrame *)cellFrame {
    _cellFrame = cellFrame;
    
    // 容器
    self.scrollView.frame = cellFrame.scrollViewF;
    self.scrollView.contentSize = cellFrame.contentSize;
    
    // 举报、顶部白色区域
    self.topContentL.frame = cellFrame.topContentLF;
    self.reportBtn.frame = cellFrame.reportBtnF;
    
    // 文本
    self.contentL.frame = cellFrame.contentLF;
    NHHomeServiceDataElementGroup *group = cellFrame.model.group;
    self.contentL.attributedText = [NHUtils attStringWithString:group.content keyWord:nil];
    
    [self removeAllImages];
    
    // 判断类型设置数据
    switch (group.media_type) {
            
        case NHHomeServiceDataElementMediaTypeLargeImage: { // 大图
            self.largeImageCover.frame = cellFrame.largeImageCoverF;
            NHHomeServiceDataElementGroupLargeImageUrl *urlModel = group.large_image.url_list.firstObject;
            [self.largeImageCover setImageWithURL:[NSURL URLWithString:urlModel.url]];
        } break;
            
        case NHHomeServiceDataElementMediaTypeGif: { // Gif
            self.gifCover.frame = cellFrame.gifCoverF;
            NHHomeServiceDataElementGroupLargeImageUrl *urlModel = group.large_image.url_list.firstObject;
            [self.gifCover setImageWithUrl:urlModel.url placeHolder:nil progressHandle:^(CGFloat progress) {
                self.gifCover.progress = progress;
            } finishHandle:nil];
        } break;
            
        case NHHomeServiceDataElementMediaTypeVideo: { // 视频
            self.videoCover.frame = cellFrame.videoCoverF;
            NHHomeServiceDataElementGroupLargeImageUrl *urlModel = group.large_cover.url_list.firstObject;
            [self.videoCover setImageWithURL:[NSURL URLWithString:urlModel.url]];
        } break;
            
        case NHHomeServiceDataElementMediaTypeLittleImages: { // 小图
            for (int i = 0; i < cellFrame.imageFrameArray.count; i++) {
                NSString *rectStr = cellFrame.imageFrameArray[i];
                NHBaseImageView *img = [[NHBaseImageView alloc] init];
                [self.contentView addSubview:img];
                img.tag = i + 1;
                img.frame = CGRectFromString(rectStr);
                img.clipsToBounds = YES;
                img.contentMode = UIViewContentModeScaleAspectFill;
                img.userInteractionEnabled  = YES;
                [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapGest:)]];
                NHHomeServiceDataElementGroupLargeImage *imageModel = group.large_image_list[i];
                [img sd_setImageWithURL:[NSURL URLWithString:imageModel.url]];
            }
        }  break;
            
        default:
            break;
    }
    
    // 喜欢
    self.likeBtn.frame = cellFrame.likeF;
    self.likeL.frame = cellFrame.likeLF;
    
    // 动画
    [self removeBar];
    self.bar.frame = cellFrame.barF;
    
    // 不喜欢
    self.disLikeBtn.frame = cellFrame.disLikeF;
    self.disLikeL.frame = cellFrame.disLikeLF;
}

- (void)removeBar {
    [self.bar removeFromSuperview];
    _bar = nil;
    
    UIWebView *web1 = (UIWebView *)[self.likeBtn viewWithTag:1];
    [web1 removeFromSuperview];
    UIWebView *web2 = (UIWebView *)[self.disLikeBtn viewWithTag:1];
    [web2 removeFromSuperview];
}

- (void)removeAllImages {
    _videoCover.image = nil;
    _gifCover.image = nil;
    _largeImageCover.image = nil;
    [_gifCover removeFromSuperview];
    [_videoCover removeFromSuperview];
    [_largeImageCover removeFromSuperview];
    _gifCover = nil;
    _videoCover = nil;
    _largeImageCover = nil;
    for (int i = 0; i < 9; i++) {
        NHBaseImageView *img = [self.contentView viewWithTag:i + 1];
        if (img != nil || img.superview) {
            [img removeFromSuperview];
            img = nil;
        }
    }
}

// 查看大图
- (void)coverImageTapGest:(UITapGestureRecognizer *)tapGest {
    NHBaseImageView *imageView = (NHBaseImageView *)tapGest.view;
    NHHomeServiceDataElementGroupLargeImageUrl *urlModel = self.cellFrame.model.group.large_image.url_list.firstObject;
    if ([self.delegate respondsToSelector:@selector(checkTableViewCell:didClickImageView:currentIndex:urls:)]) {
        [self.delegate checkTableViewCell:self didClickImageView:imageView currentIndex:0 urls:@[[NSURL URLWithString:urlModel.url]]];
    }
}

// 查看大图
- (void)imageTapGest:(UITapGestureRecognizer *)tapGest {
    NHBaseImageView *imageView = (NHBaseImageView *)tapGest.view;
    NSMutableArray *urls = [NSMutableArray array];
    
    for (int i = 0; i < self.cellFrame.imageFrameArray.count; i++) {
        NHHomeServiceDataElementGroupLargeImage *imageModel = self.cellFrame.model.group.large_image_list[i];
        [urls addObject:[NSURL URLWithString:imageModel.url]];
    }
    if ([self.delegate respondsToSelector:@selector(checkTableViewCell:didClickImageView:currentIndex:urls:)]) {
        [self.delegate checkTableViewCell:self didClickImageView:imageView currentIndex:imageView.tag - 1 urls:urls];
    }
}

// 举报
- (void)reportBtnClick {
    if ([self.delegate respondsToSelector:@selector(checkTableViewCell:didClickReport:)]) {
        [self.delegate checkTableViewCell:self didClickReport:YES];
    }
}

- (void)likeBtnClick:(UIButton *)btn {
    [self addGifForButton:btn imagename:@"digupicon_review_press.gif"];
    CGFloat leftScale = (self.cellFrame.model.group.digg_count + 1) * 1.0 / (self.cellFrame.model.group.digg_count + 1 + self.cellFrame.model.group.bury_count);
    [self showPercentWithLeftScale:leftScale];
}

// 进度条
- (void)showPercentWithLeftScale:(CGFloat)leftScale {
    self.bar.leftScale = leftScale;
    self.bar.rightScale = 1 - leftScale;
}

- (void)disLikeBtnClick:(UIButton *)btn {
    [self addGifForButton:btn imagename:@"digdownicon_review_press.gif"];
    CGFloat leftScale = 1 - (self.cellFrame.model.group.bury_count + 1)* 1.0 / (self.cellFrame.model.group.digg_count + self.cellFrame.model.group.bury_count + 1) ;
    [self showPercentWithLeftScale:leftScale];
}

// 添加gif图片
- (void)addGifForButton:(UIButton *)btn imagename:(NSString *)imagename {
    UIWebView *web = [[UIWebView alloc] init];
    [btn addSubview:web];
    web.opaque = NO; 
    web.backgroundColor = self.scrollView.backgroundColor;
    web.tag = 1;
    web.frame = btn.bounds;
    web.scalesPageToFit = YES;
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imagename ofType:nil]];
    [web loadData:data MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL new]];
}

- (NHCheckTableViewProgressBar *)bar {
    if (!_bar) {
        NHCheckTableViewProgressBar *bar = [NHCheckTableViewProgressBar bar];
        [self.scrollView addSubview:bar];
        WeakSelf(weakSelf);
        [bar setUpCheckTableViewProgressBarFinishLoadingHandle:^{
//            if ([weakSelf.delegate respondsToSelector:@selector(checkTableViewCellDidFinishLoadingHandle:)]) {
//                [weakSelf.delegate checkTableViewCellDidFinishLoadingHandle:weakSelf];
//            }
            // 简单直接的判断，看看有没有loading视图就知道有没有点击过
            BOOL likeFlag = [self.likeBtn viewWithTag:1] != nil;
            if ([weakSelf.delegate respondsToSelector:@selector(checkTableViewCell:didFinishLoadingHandleWithLikeFlag:)]) {
                [weakSelf.delegate checkTableViewCell:weakSelf didFinishLoadingHandleWithLikeFlag:likeFlag];
            }
        }];
        _bar = bar;
    }
    return _bar;
}

- (UILabel *)likeL {
    if (!_likeL) {
        UILabel *label = [[UILabel alloc] init];
        [self.scrollView addSubview:label];
        _likeL = label;
        label.text = @"好笑";
        label.font = kFont(12);
        label.textColor = kCommonBlackColor;
        label.textAlignment = NSTextAlignmentCenter;
    }
    return _likeL;
}

- (UILabel *)disLikeL {
    if (!_disLikeL) {
        UILabel *label = [[UILabel alloc] init];
        [self.scrollView addSubview:label];
        _disLikeL = label;
        label.text = @"不好笑";
        label.font = kFont(12);
        label.textColor = kCommonBlackColor;
        label.textAlignment = NSTextAlignmentCenter;
    }
    return _disLikeL;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *sc = [[UIScrollView alloc] init];
        [self.contentView addSubview:sc];
        _scrollView = sc;
        sc.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
        sc.showsVerticalScrollIndicator = NO;
        sc.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)topContentL {
    if (!_topContentL) {
        UIView *top = [[UIView alloc] init];
        [self.scrollView addSubview:top];
        _topContentL = top;
        top.backgroundColor = kWhiteColor;
    }
    return _topContentL;
}

- (UIButton *)reportBtn {
    if (!_reportBtn) {
        WeakSelf(weakSelf);
        UIButton *report = [UIButton buttonWithTitle:@"举报" normalColor:kCommonTintColor selectedColor:kCommonTintColor fontSize:15 touchBlock:^{
            [weakSelf reportBtnClick];
        }];
        [self.scrollView addSubview:report];
        _reportBtn = report;
        report.layerCornerRadius = 3.0;
        report.layerBorderColor = kCommonTintColor;
        report.layerBorderWidth = 1.0;
    }
    return _reportBtn;
}

- (UIButton *)likeBtn {
    if (!_likeBtn) {
        UIButton *btn = [[UIButton alloc] init];
        [self.scrollView addSubview:btn];
        _likeBtn = btn;
        [btn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"digupicon_review_press_1"] forState:UIControlStateNormal];
    }
    return _likeBtn;
}

- (UIButton *)disLikeBtn {
    if (!_disLikeBtn) {
        UIButton *btn = [[UIButton alloc] init];
        [self.scrollView addSubview:btn];
        _disLikeBtn = btn;
        [btn addTarget:self action:@selector(disLikeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"digdownicon_review_press_1"] forState:UIControlStateNormal];
    }
    return _disLikeBtn;
}

- (UILabel *)contentL {
    if (!_contentL) {
        UILabel *label = [[UILabel alloc] init];
        [self.scrollView addSubview:label];
        _contentL = label;
        label.font = kFont(16);
        label.textColor = kBlackColor;
        label.numberOfLines = 0;
    }
    return _contentL;
}

- (NHBaseImageView *)largeImageCover {
    if (!_largeImageCover) {
        NHBaseImageView *img = [[NHBaseImageView alloc] init];
        [self.scrollView addSubview:img];
        _largeImageCover = img;
        img.layer.masksToBounds = YES;
        img.backgroundColor = kCommonBgColor;
        img.userInteractionEnabled  = YES;
        [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageTapGest:)]];
    }
    return _largeImageCover;
}

- (NHBaseImageView *)videoCover {
    if (!_videoCover) {
        NHBaseImageView *img = [[NHBaseImageView alloc] init];
        [self.scrollView addSubview:img];
        _videoCover = img;
        img.layer.masksToBounds = YES;
        img.backgroundColor = kCommonBgColor;
    }
    return _videoCover;
}

- (NHCustomGifImageView*)gifCover {
    if (!_gifCover) {
        NHCustomGifImageView *img = [[NHCustomGifImageView alloc] init];
        [self.scrollView addSubview:img];
        _gifCover = img;
        img.layer.masksToBounds = YES;
        img.backgroundColor = kCommonBgColor;
        img.userInteractionEnabled  = YES;
        [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageTapGest:)]];
    }
    return _gifCover;
}
@end
