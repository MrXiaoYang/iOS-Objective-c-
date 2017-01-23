//
//  NHHomeTableViewCell.m
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHHomeTableViewCell.h"
#import "NHHomeTableViewCellFrame.h"
#import "NHDiscoverSearchCommonCellFrame.h"
#import "NHHomeServiceDataModel.h"
#import "UIView+Layer.h"
#import "NHHomeTableViewCellCommentView.h"
#import "UIView+Tap.h"
#import "NHHomeTableViewCellGifImageView.h"
#import "NHDownloadImageManager.h"
#import "NHCustomGifImageView.h"
#import "NHHomeTableCellVideoCoverImageView.h"
#import "YYWebImage.h"


#define kBottomBtnTextColor [UIColor colorWithRed:0.55f green:0.55f blue:0.55f alpha:1.00f]
@interface NHHomeTableViewCell ()
/** 头像*/
@property (nonatomic, weak) NHBaseImageView *iconImg;
/** 名字*/
@property (nonatomic, weak) UILabel *nameL;
/** 文本*/
@property (nonatomic, weak) UILabel *contentL;
/** 关闭*/
@property (nonatomic, weak) NHBaseImageView *closeImg;
/** 分类*/
@property (nonatomic, weak) UIButton *version_Btn;
/** 关注*/
@property (nonatomic, weak) UIButton *attBtn;
/** 点赞*/
@property (nonatomic, weak) UIButton *likeCountBtn;
/** 踩*/
@property (nonatomic, weak) UIButton *dontLikeCountBtn;
/** 评论*/
@property (nonatomic, weak) UIButton *commentCountBtn;
/** 分享*/
@property (nonatomic, weak) UIButton *shareBtn;
/** 底部*/
@property (nonatomic, weak) UIView *bottomView;
/** 热门标签*/
@property (nonatomic, weak) UILabel *tagL;
/** 大图*/
@property (nonatomic, weak) NHBaseImageView *largeImageCover;
/** 视频封面*/
@property (nonatomic, weak) NHHomeTableCellVideoCoverImageView *videoCover;
/** GIF大图*/
@property (nonatomic, weak) NHCustomGifImageView *gifCover;
/** 高亮的关键字*/
@property (nonatomic, copy) NSString *keyWord;
/** 精华*/
@property (nonatomic, weak) NHBaseImageView *essImgCover;
/** 查看内涵精华*/
@property (nonatomic, weak) UIButton *lookEssBtn;
/** 详情页面*/
@property (nonatomic, assign) BOOL isDetail;
@end

@implementation NHHomeTableViewCell

#pragma mark - 设置
- (void)setSearchCellFrame:(NHDiscoverSearchCommonCellFrame *)searchCellFrame keyWord:(NSString *)keyWord {
    _keyWord = keyWord;
    self.searchCellFrame = searchCellFrame;
}

- (void)setCellFrame:(NHHomeTableViewCellFrame *)cellFrame isDetail:(BOOL)isDetail {
    _isDetail = isDetail;
    self.cellFrame = cellFrame;
}

- (void)setSearchCellFrame:(NHDiscoverSearchCommonCellFrame *)searchCellFrame {
    _searchCellFrame = searchCellFrame;
    self.cellFrame = _searchCellFrame;
}

- (void)setCellFrame:(NHHomeTableViewCellFrame *)cellFrame {
    
    if (_cellFrame == cellFrame && _cellFrame) {
        return ;
    }
    _cellFrame = cellFrame;
    
    
    NHHomeServiceDataElementGroup *group = nil;
    
    if ([cellFrame isMemberOfClass:[NHHomeTableViewCellFrame class]]) {
        group = cellFrame.model.group;
    } else {
        NHDiscoverSearchCommonCellFrame *searchCellFrame = (NHDiscoverSearchCommonCellFrame *)cellFrame;
        group = searchCellFrame.group;
    }
    
    if (group == nil) return ;
    
    [self removeAllImages];
    
    [self removeAllCommentViews];
    
    
    // 精华
    if (group.media_type == 5) {
        self.essImgCover.frame = cellFrame.essenceCoverF;
        NHHomeServiceDataElementGroupLargeImageUrl *urlModel = group.large_cover.url_list.firstObject;
        [self.essImgCover setImageWithUrl:urlModel.url];
        
        self.lookEssBtn.frame = cellFrame.lookEssEnceF;
        self.bottomView.frame = cellFrame.bottomViewF;
        return ;
    }
    
    // 头像
    self.iconImg.frame = cellFrame.iconImgF;
    self.iconImg.layerCornerRadius = cellFrame.iconImgF.size.height / 2.0;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:group.user.avatar_url]];
    
    // 名字
    self.nameL.frame = cellFrame.nameLF;
    self.nameL.text = group.user.name;
    
    // 热门
    if ([group.status_desc containsString:@"热门"] != NSNotFound) {
        self.tagL.frame = cellFrame.tagF;
        self.tagL.text = @"热门";
    } else {
        [self.tagL removeFromSuperview];
        _tagL = nil;
    }
    
    
    // 分类
    self.version_Btn.frame = cellFrame.version_BtnF;
    [self.version_Btn setTitle:group.category_name forState:UIControlStateNormal];
    
    
    // 文本
    self.contentL.frame = cellFrame.contentLF;
    self.contentL.attributedText = [NHUtils attStringWithString:group.content keyWord:self.keyWord];
    
    
    // 判断类型设置数据
    switch (group.media_type) {
            
        case NHHomeServiceDataElementMediaTypeLargeImage: { // 大图
            self.largeImageCover.frame = cellFrame.largeImageCoverF;
            NHHomeServiceDataElementGroupLargeImageUrl *urlModel = group.large_image.url_list.firstObject;
            [self.largeImageCover setImageWithUrl:urlModel.url];
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
            [self.videoCover setImageWithUrl:urlModel.url];
        } break;
            
        case NHHomeServiceDataElementMediaTypeLittleImages: { // 小图
            for (int i = 0; i < cellFrame.imageFrameArray.count; i++) {
                NHHomeServiceDataElementGroupLargeImage *imageModel = group.thumb_image_list[i];
                NSString *rectStr = cellFrame.imageFrameArray[i];
                NHBaseImageView *img = nil;
                if (imageModel.is_gif) {
                    img = [[NHHomeTableViewCellGifImageView alloc] init];
                } else {
                    img = [[NHBaseImageView alloc] init];
                }
                [self.contentView addSubview:img];
                img.tag = i + 1;
                img.frame = CGRectFromString(rectStr);
                img.clipsToBounds = YES;
                img.contentMode = UIViewContentModeScaleAspectFill;
                img.userInteractionEnabled  = YES;
                [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapGest:)]];
                [img setImageWithUrl:imageModel.url];
            }
        }  break;
            
        default:
            break;
    }
    
    
    // 如果是从详情页面进入，有关注按钮
    if (self.isDetail) {
        self.attBtn.hidden = NO;
        self.attBtn.frame = cellFrame.attBtnF;
    } else {
        self.attBtn.hidden = YES;
    }
    
    if (self.isFromHomeController) {
        self.closeImg.hidden = NO;
        self.closeImg.frame = cellFrame.closeImgF;
    } else { 
        self.closeImg.hidden = YES;
    }
    // 评论
    if (cellFrame.model.comments.count) {
        for (int i = 0; i < cellFrame.commentFrameArray.count; i++) {
            CGRect commentRect = CGRectFromString( cellFrame.commentFrameArray[i]);
            NHHomeTableViewCellCommentView *commentView = [[NHHomeTableViewCellCommentView alloc] init];
            [self.contentView addSubview:commentView];
            commentView.tag = 100 + i;
            commentView.frame = commentRect;
            commentView.comment = cellFrame.model.comments[i];
        }
    }
    // 点赞
    self.likeCountBtn.frame = cellFrame.likeCountBtnF;
    [self.likeCountBtn setTitle:kIntegerToStr(group.digg_count) forState:UIControlStateNormal];
    [self.likeCountBtn setImage:[UIImage imageNamed:group.user_digg ? @"digupicon_textpage_press" : @"digupicon_textpage"] forState:UIControlStateNormal];
    [self.likeCountBtn setTitleColor:group.user_digg ? kCommonHighLightRedColor : kCommonGrayTextColor forState:UIControlStateNormal];
    
    // 分享
    self.shareBtn.frame = cellFrame.shareBtnF;
    [self.shareBtn setTitle:kIntegerToStr(group.share_count) forState:UIControlStateNormal];
    
    // 踩
    self.dontLikeCountBtn.frame = cellFrame.dontLikeCountBtnF;
    [self.dontLikeCountBtn setTitle:kIntegerToStr(group.bury_count) forState:UIControlStateNormal];
    [self.dontLikeCountBtn setImage:[UIImage imageNamed:group.user_bury ? @"digdownicon_textpage_press" : @"digdownicon_textpage"] forState:UIControlStateNormal];
    [self.dontLikeCountBtn setTitleColor:group.user_bury ? kCommonHighLightRedColor : kCommonGrayTextColor  forState:UIControlStateNormal];
    
    // 评论
    self.commentCountBtn.frame = cellFrame.commentCountBtnF;
    [self.commentCountBtn setTitle:kIntegerToStr(group.comment_count) forState:UIControlStateNormal];
    
    self.bottomView.frame = cellFrame.bottomViewF;
}

// 点赞
- (void)didDigg {
    [self.likeCountBtn setImage:[UIImage imageNamed:@"digupicon_textpage_press"] forState:UIControlStateNormal];
    [self animationWithBtn:self.likeCountBtn];
    [self.likeCountBtn setTitle:kIntegerToStr(self.likeCountBtn.currentTitle.integerValue + 1) forState:UIControlStateNormal];
}

// 踩
- (void)didBury {
    [self.dontLikeCountBtn setImage:[UIImage imageNamed:@"digdownicon_textpage_press"] forState:UIControlStateNormal];
    [self animationWithBtn:self.dontLikeCountBtn];
    [self.dontLikeCountBtn setTitle:kIntegerToStr(self.dontLikeCountBtn.currentTitle.integerValue + 1) forState:UIControlStateNormal];
}

- (void)animationWithBtn:(UIButton *)btn {
    
    [btn setTitleColor:kCommonHighLightRedColor forState:UIControlStateNormal];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @" + 1";
    label.textColor = kCommonHighLightRedColor;
    label.font = kBoldFont(14);
    [self.contentView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = btn.frame;
    label.y = btn.y - 20;
    
    label.transform = CGAffineTransformMakeScale(0.2, 0.2);
    label.alpha = 0.0;
    [UIView animateWithDuration:0.2 animations:^{
        label.transform = CGAffineTransformMakeScale(1.2, 1.2);
        label.alpha = 1.0f;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [label removeFromSuperview];
        });
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        btn.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)removeAllImages {
    for (int i = 0; i < 9; i++) {
        NHBaseImageView *img = [self.contentView viewWithTag:i + 1];
        if (img != nil || img.superview) {
            [img removeFromSuperview];
            img = nil;
        }
    }
    
    [_gifCover removeFromSuperview];
    [_videoCover removeFromSuperview];
    [_largeImageCover removeFromSuperview];
    
    _gifCover.image = nil;
    _videoCover.image = nil;
    _largeImageCover.image = nil;
    
    _gifCover = nil;
    _videoCover = nil;
    _largeImageCover = nil;
}

- (void)removeAllCommentViews {
    for (int i = 0; i < 9; i++) {
        NHHomeTableViewCellCommentView *commentView = [self.contentView viewWithTag:i + 100];
        if (commentView != nil || commentView.superview) {
            [commentView removeFromSuperview];
        }
    }
}

#pragma mark - Actions
- (void)attBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(homeTableViewCellDidClickAttention:)]) {
        [self.delegate homeTableViewCellDidClickAttention:self];
    }
    
    // 模拟网络请求
    if ([self.attBtn.currentTitle isEqualToString:@"关注"]) {
        [self.attBtn setTitle:@"已关注" forState:UIControlStateNormal];
        self.attBtn.layerBorderColor = kCommonGrayTextColor;
        [self.attBtn setTitleColor:kCommonGrayTextColor forState:UIControlStateNormal];
    } else {
        [self.attBtn setTitle:@"关注" forState:UIControlStateNormal];
        self.attBtn.layerBorderColor = kCommonHighLightRedColor;
        [self.attBtn setTitleColor:kCommonHighLightRedColor forState:UIControlStateNormal];
    } 
}

- (void)versionBtnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(homeTableViewCellDidClickCategory:)]) {
        [self.delegate homeTableViewCellDidClickCategory:self];
    }
}

- (void)coverImageTapGest:(UITapGestureRecognizer *)tapGest {
    NHBaseImageView *imageView = (NHBaseImageView *)tapGest.view;
    NHHomeServiceDataElementGroupLargeImageUrl *urlModel = nil;
    if (self.cellFrame) {
        urlModel = self.cellFrame.model.group.large_image.url_list.firstObject;
    } else {
        urlModel = self.searchCellFrame.group.large_image.url_list.firstObject;
    }
    if (!urlModel) return;
    
    if ([self.delegate respondsToSelector:@selector(homeTableViewCell:didClickImageView:currentIndex:urls:)]) {
        [self.delegate homeTableViewCell:self didClickImageView:imageView currentIndex:0 urls:@[[NSURL URLWithString:urlModel.url]]];
    }
}

- (void)imageTapGest:(UITapGestureRecognizer *)tapGest {
    NHBaseImageView *imageView = (NHBaseImageView *)tapGest.view;
    NSMutableArray *urls = [NSMutableArray array];
    
    for (int i = 0; i < self.cellFrame.imageFrameArray.count; i++) {
        NHHomeServiceDataElementGroupLargeImage *imageModel = self.cellFrame.model.group.large_image_list[i];
        [urls addObject:[NSURL URLWithString:imageModel.url]];
    }
    if ([self.delegate respondsToSelector:@selector(homeTableViewCell:didClickImageView:currentIndex:urls:)]) {
        [self.delegate homeTableViewCell:self didClickImageView:imageView currentIndex:imageView.tag - 1 urls:urls];
    }
}

- (void)btnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(homeTableViewCell:didClickItemWithType:)]) {
        [self.delegate homeTableViewCell:self didClickItemWithType:btn.tag - 10];
    }
}

- (UIView *)bottomView {
    if (!_bottomView) {
        UIView *bottom = [[UIView alloc] init];
        [self.contentView addSubview:bottom];
        _bottomView = bottom;
        bottom.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    }
    return _bottomView;
}

- (UIButton *)likeCountBtn {
    if (!_likeCountBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _likeCountBtn = btn;
        [btn setTitleColor:kBottomBtnTextColor forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(13.0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 1, 0, 0);
        [btn setImage:[UIImage imageNamed:@"digupicon_comment"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.tag = 11;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeCountBtn;
}

- (UIButton *)dontLikeCountBtn {
    if (!_dontLikeCountBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _dontLikeCountBtn = btn;
        [btn setTitleColor:kBottomBtnTextColor forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(13.0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 1, 0, 0);
        [btn setImage:[UIImage imageNamed:@"digdownicon_textpage"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.tag = 12;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dontLikeCountBtn;
}

- (UIButton *)commentCountBtn {
    if (!_commentCountBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _commentCountBtn = btn;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 1, 0, 0);
        [btn setTitleColor:kBottomBtnTextColor forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(13.0);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setImage:[UIImage imageNamed:@"commenticon_textpage"] forState:UIControlStateNormal];
        btn.tag = 13;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentCountBtn;
}

- (UIButton *)version_Btn {
    if (!_version_Btn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _version_Btn = btn;
        [btn setTitleColor:kCommonTintColor forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(14.0);
        [btn addTarget:self action:@selector(versionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layerBorderColor = kCommonTintColor;
        btn.layerBorderWidth = 1;
        btn.layerCornerRadius = 10.0;
    }
    return _version_Btn;
}

- (UIButton *)attBtn {
    if (!_attBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _attBtn = btn;
        [btn setTitleColor:kCommonHighLightRedColor forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(14.0);
        [btn setTitle:@"关注" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(attBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layerBorderColor = kCommonHighLightRedColor;
        btn.layerBorderWidth = 1;
        btn.layerCornerRadius = 3.0;
    }
    return _attBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _shareBtn = btn;
        [btn setTitleColor:kBottomBtnTextColor forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(13.0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 1, 0, 0);
        [btn setImage:[UIImage imageNamed:@"moreicon_textpage"] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        btn.tag = 14;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UIButton *)lookEssBtn {
    if (!_lookEssBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _lookEssBtn = btn;
        [btn setTitleColor:kRedColor forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(13.0);
        [btn setTitle:@"查看内涵精华 >" forState:UIControlStateNormal];
    }
    return _lookEssBtn;
}

- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _nameL = label;
        label.font = kFont(14);
        label.textColor = kCommonBlackColor;
    }
    return _nameL;
}

- (UILabel *)contentL {
    if (!_contentL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _contentL = label;
        label.font = kFont(16);
        label.textColor = kBlackColor;
        label.numberOfLines = 0;
    }
    return _contentL;
}

- (UILabel *)tagL {
    if (!_tagL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _tagL = label;
        _tagL.backgroundColor = [UIColor colorWithRed:0.99f green:0.44f blue:0.40f alpha:1.00f];
        label.numberOfLines = 0;
        label.font = kFont(11);
        label.textColor = kWhiteColor;
    }
    return _tagL;
}

- (NHBaseImageView *)iconImg {
    if (!_iconImg) {
        NHBaseImageView *img = [[NHBaseImageView alloc] init];
        [self.contentView addSubview:img];
        _iconImg = img;
        img.backgroundColor = kSeperatorColor;
        WeakSelf(weakSelf);
        [img setTapActionWithBlock:^{
            if ([weakSelf.delegate respondsToSelector:@selector(homeTableViewCell:gotoPersonalCenterWithUserInfo:)]) {
                if (weakSelf.searchCellFrame) {
                    [weakSelf.delegate homeTableViewCell:weakSelf gotoPersonalCenterWithUserInfo:weakSelf.searchCellFrame.group.user];
                } else {
                    [weakSelf.delegate homeTableViewCell:weakSelf gotoPersonalCenterWithUserInfo:weakSelf.cellFrame.model.group.user];
                }
            }
        }];
    }
    return _iconImg;
}

- (NHBaseImageView *)largeImageCover {
    if (!_largeImageCover) {
        NHBaseImageView *img = [[NHBaseImageView alloc] init];
        [self.contentView addSubview:img];
        _largeImageCover = img;
        img.backgroundColor = kSeperatorColor;
        img.userInteractionEnabled  = YES;
        [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageTapGest:)]];
    }
    return _largeImageCover;
}

- (NHBaseImageView *)essImgCover {
    if (!_essImgCover) {
        NHBaseImageView *img = [[NHBaseImageView alloc] init];
        [self.contentView addSubview:img];
        _essImgCover = img;
        img.backgroundColor = kSeperatorColor;
        img.userInteractionEnabled  = YES;
        [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageTapGest:)]];
    }
    return _largeImageCover;
}

- (NHHomeTableCellVideoCoverImageView *)videoCover {
    if (!_videoCover) {
        NHHomeTableCellVideoCoverImageView *img = [[NHHomeTableCellVideoCoverImageView alloc] init];
        [self.contentView addSubview:img];
        _videoCover = img;
        img.backgroundColor = kSeperatorColor;
        img.userInteractionEnabled = YES;
        WeakSelf(weakSelf);
        img.homeTableCellVideoDidBeginPlayHandle = ^(UIButton *playBtn) {
            if (weakSelf.searchCellFrame) {
                if ([weakSelf.delegate respondsToSelector:@selector(homeTableViewCell:didClickVideoWithVideoUrl:videoCover:)]) {
                    NHHomeServiceDataElementGroupLargeImageUrl *urlVideoModel = weakSelf.searchCellFrame.group.video_360P.url_list.firstObject;
                    [weakSelf.delegate homeTableViewCell:weakSelf didClickVideoWithVideoUrl:urlVideoModel.url videoCover:weakSelf.videoCover];
                }
            } else {
            if ([weakSelf.delegate respondsToSelector:@selector(homeTableViewCell:didClickVideoWithVideoUrl:videoCover:)]) {
                NHHomeServiceDataElementGroupLargeImageUrl *urlVideoModel = weakSelf.cellFrame.model.group.video_360P.url_list.firstObject;
                [weakSelf.delegate homeTableViewCell:weakSelf didClickVideoWithVideoUrl:urlVideoModel.url videoCover:weakSelf.videoCover];
            }
            }
        };
    }
    return _videoCover;
}

- (NHCustomGifImageView *)gifCover {
    if (!_gifCover) {
        NHCustomGifImageView *img = [[NHCustomGifImageView alloc] init];
        [self.contentView addSubview:img];
        _gifCover = img;
        img.backgroundColor = kSeperatorColor;
        img.userInteractionEnabled  = YES;
        [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageTapGest:)]];
        
    }
    return _gifCover;
}

- (NHBaseImageView *)closeImg {
    if (!_closeImg) {
        NHBaseImageView *img = [[NHBaseImageView alloc] init];
        [self.contentView addSubview:img];
        _closeImg = img;
        img.image = [UIImage imageNamed:@"dislike"];
        WeakSelf(weakSelf);
        [img setTapActionWithBlock:^{
            if ([weakSelf.delegate respondsToSelector:@selector(homeTableViewCellDidClickClose:)]) {
                [weakSelf.delegate homeTableViewCellDidClickClose:weakSelf];
            }
        }];
    }
    return _closeImg;
}

@end
