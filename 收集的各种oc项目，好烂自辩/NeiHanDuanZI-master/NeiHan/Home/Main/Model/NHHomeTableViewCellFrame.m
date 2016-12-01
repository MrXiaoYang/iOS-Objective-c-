//
//  NHHomeTableViewCellFrame.m
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHHomeTableViewCellFrame.h"

#import "NHHomeServiceDataModel.h"
#import "NSString+Size.h"
#import "NSAttributedString+Size.h"

#import "NHHomeTableViewCellCommentView.h"

@interface NHHomeTableViewCellFrame ()
@property (nonatomic, assign) BOOL isDetail;

@end

@implementation NHHomeTableViewCellFrame

- (NSMutableArray *)imageFrameArray {
    if (!_imageFrameArray) {
        _imageFrameArray = [NSMutableArray new];
    }
    return _imageFrameArray;
}

- (NSMutableArray *)commentFrameArray {
    if (!_commentFrameArray) {
        _commentFrameArray = [NSMutableArray new];
    }
    return _commentFrameArray;
}

- (void)setModel:(NHHomeServiceDataElement *)model isDetail:(BOOL)isDetail {
    _isDetail = isDetail;
    self.model = model;
}

- (void)setModel:(NHHomeServiceDataElement *)model {
    if (model == nil) {
        return ;
    }
    _model = model;
    NHHomeServiceDataElementGroup *group = model.group;
    if (group == nil) {
        return ;
    }
    
    
    // 精华
    if (group.media_type == 5) {
        CGFloat essX = 20;
        CGFloat essY = 10;
        CGFloat essW = kScreenWidth - 20 * 2;
        CGFloat essH = essW * group.large_image.r_height / group.large_image.r_width;
        self.essenceCoverF = CGRectMake(essX, essY, essW, essH);
        
        CGFloat lookEssW = kScreenWidth;
        CGFloat lookEssX = 0;
        CGFloat lookEssY = CGRectGetMaxY(self.essenceCoverF) + 10;
        CGFloat lookEssH = 20;
        self.lookEssEnceF = CGRectMake(lookEssX, lookEssY, lookEssW, lookEssH);
        
        CGFloat bottomX = 0;
        CGFloat bottomY = CGRectGetMaxY(self.lookEssEnceF) + 15;
        CGFloat bottomW = kScreenWidth;
        CGFloat bottomH = 10;
        self.bottomViewF = CGRectMake(bottomX, bottomY, bottomW, bottomH);
    
        self.cellHeight = CGRectGetMaxY(self.bottomViewF) + 10;
        return ;
    }
    
    
    // 热门
    CGFloat tagX = 0;
    CGFloat tagY = 20;
    CGFloat tagW = 15;
    CGFloat tagH = 30;
    self.tagF = CGRectMake(tagX, tagY, tagW, tagH);
    
    // 头像
    CGFloat iconX = 20;
    CGFloat iconY = 15;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    self.iconImgF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 关注
    if (self.isDetail) {
        CGFloat attX = kScreenWidth - 40 - 15;
        CGFloat attY = 15;
        CGFloat attW = 50;
        CGFloat attH = 28;
        self.attBtnF = CGRectMake(attX, attY, attW, attH);
    }
    
    // 名字
    CGFloat nameH = 15;
    CGFloat nameX = CGRectGetMaxX(self.iconImgF) + 10;
    CGFloat nameY = iconY + (iconH - nameH) / 2.0;
    CGFloat nameW = kScreenWidth - nameX - 10 - 30;
    self.nameLF = CGRectMake(nameX, nameY, nameW, nameH);
    
    // 文本
    CGFloat contentX = 17;
    CGFloat contentY = CGRectGetMaxY(self.iconImgF) + 10;
    CGFloat contentW = kScreenWidth - 32;
    NSAttributedString *string = [NHUtils attStringWithString:group.content keyWord:nil];
    CGFloat contentH  = [string heightWithConstrainedWidth:contentW];
    if (group.content.length == 0) {
        contentY = CGRectGetMaxY(self.iconImgF) + 2;
    }
    self.contentLF = CGRectMake(contentX, contentY, contentW, contentH);
    
    // 分类
    CGFloat versionX = 15;
    CGFloat versionY = CGRectGetMaxY(self.contentLF) + 10;
    CGFloat versionH = 20;
    CGFloat versionW = [group.category_name widthWithFont:kFont(14) constrainedToHeight:versionH] + 25;
    self.version_BtnF = CGRectMake(versionX, versionY, versionW, versionH);
    CGFloat likeBtnY = CGRectGetMaxY(self.version_BtnF) + 15;
    
    // 关闭
    CGFloat closeImgX = kScreenWidth - 30;
    CGFloat closeImgY = 0;
    CGFloat closeImgW = 30;
    CGFloat closeImgH = 30;
    self.closeImgF = CGRectMake(closeImgX, closeImgY, closeImgW, closeImgH);
    
    
    // 小图
    [self.imageFrameArray removeAllObjects];
    [self.commentFrameArray removeAllObjects];
    if (group.media_type == 1) {
        // 大图
        CGFloat largeX = 20;
        CGFloat largeY = CGRectGetMaxY(self.version_BtnF) + 10;
        CGFloat largeW = kScreenWidth - 20 * 2;
        CGFloat largeH = largeW * group.large_image.r_height / group.large_image.r_width;
        self.largeImageCoverF = CGRectMake(largeX, largeY, largeW, largeH);
        likeBtnY = CGRectGetMaxY(self.largeImageCoverF) + 15;
    } else if (group.media_type == 2) {
        // gif
        CGFloat gifX = 20;
        CGFloat gifY = CGRectGetMaxY(self.version_BtnF) + 10;
        CGFloat gifW = kScreenWidth - 20 * 2;
        CGFloat gifH = gifW * group.large_image.r_height / group.large_image.r_width;
        self.gifCoverF = CGRectMake(gifX, gifY, gifW, gifH);
        likeBtnY = CGRectGetMaxY(self.gifCoverF) + 10;
    } else if (group.media_type == 3) {
        // 视频
        CGFloat videoX = 20;
        CGFloat videoY = CGRectGetMaxY(self.version_BtnF) + 10;
        CGFloat videoW = kScreenWidth - 20 * 2;
        CGFloat videoH = videoW * group.video_720P.height / group.video_720P.width;
        self.videoCoverF = CGRectMake(videoX, videoY, videoW, videoH);
        likeBtnY = CGRectGetMaxY(self.videoCoverF) + 15;
    } else if (group.media_type == 4) {
        
        if (group.large_image_list.count) {
            for (int i = 0; i < group.large_image_list.count; i++) {
                int col = i % 3; // 第几列
                int row = i / 3; 
                CGFloat margin = 15;
                CGFloat imageW = (kScreenWidth - 15 * 4) / 3.0;
                CGFloat imageX =  margin * (col + 1) + col * imageW;
                CGFloat imageH = imageW;
                CGFloat imageY = margin * (row + 1) + row * imageH + CGRectGetMaxY(self.version_BtnF) + 10;
                CGRect imageRect = CGRectMake(imageX, imageY, imageW, imageH);
                likeBtnY = CGRectGetMaxY(imageRect) + 15;
                [self.imageFrameArray addObject:NSStringFromCGRect(imageRect)];
            }
        }
    }
    
    // 详情页无神评论
    if (!self.isDetail) {
        NSMutableArray <NHHomeServiceDataElementComment *>*comments = model.comments;
        if (comments.count) {
            for (int i = 0; i < comments.count; i++) {
                NHHomeServiceDataElementComment *comment = comments[i];
                CGFloat commentViewH = 60 + [[NHUtils attStringWithString:comment.text keyWord:nil] heightWithConstrainedWidth:kScreenWidth - 120] + 10;
                CGFloat commentViewX = 15;
                CGFloat commentViewY = likeBtnY;
                CGFloat commentViewW = kScreenWidth - 30;
                CGRect commentRect = CGRectMake(commentViewX, commentViewY, commentViewW, commentViewH);
                [self.commentFrameArray addObject:NSStringFromCGRect(commentRect)];
                likeBtnY = CGRectGetMaxY(commentRect) + 10;
            }
        }
    }
 
    
    // 点赞
    CGFloat likeBtnX = 20;
    CGFloat likeBtnW = (kScreenWidth - 20) / 5.0;
    CGFloat likeBtnH = 35;
    self.likeCountBtnF = CGRectMake(likeBtnX, likeBtnY, likeBtnW, likeBtnH);
    
    // 踩
    CGFloat dontlikeBtnX = CGRectGetMaxX(self.likeCountBtnF) + 0;
    CGFloat dontlikeBtnY = likeBtnY;
    CGFloat dontlikeBtnW = likeBtnW;
    CGFloat dontlikeBtnH = likeBtnH;
    self.dontLikeCountBtnF = CGRectMake(dontlikeBtnX, dontlikeBtnY, dontlikeBtnW, dontlikeBtnH);
    
    // 评论
    CGFloat commentX = CGRectGetMaxX(self.dontLikeCountBtnF) + 0;
    CGFloat commentY = likeBtnY;
    CGFloat commentW = likeBtnW;
    CGFloat commentH = likeBtnH;
    self.commentCountBtnF = CGRectMake(commentX, commentY, commentW, commentH);
    
    // 分享
    CGFloat shareW = likeBtnW;
    CGFloat shareX = kScreenWidth - shareW - 15;
    CGFloat shareY = likeBtnY;
    CGFloat shareH = likeBtnH;
    self.shareBtnF = CGRectMake(shareX, shareY, shareW, shareH);
    
    // 底部
    CGFloat bottomX = 0;
    CGFloat bottomY = CGRectGetMaxY(self.shareBtnF) + 15;
    CGFloat bottomW = kScreenWidth;
    CGFloat bottomH = 10;
    self.bottomViewF = CGRectMake(bottomX, bottomY, bottomW, bottomH);
    
    self.cellHeight = CGRectGetMaxY(self.bottomViewF);
    
    NSLog(@"-cellheight:%f", self.cellHeight);
}
@end
