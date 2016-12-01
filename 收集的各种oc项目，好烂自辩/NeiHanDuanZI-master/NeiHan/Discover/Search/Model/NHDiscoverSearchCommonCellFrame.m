//
//  NHDiscoverSearchCommonCellFrame.m
//  NeiHan
//
//  Created by Charles on 16/9/4.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDiscoverSearchCommonCellFrame.h"


#import "NHHomeServiceDataModel.h"
#import "NSString+Size.h"
#import "NSAttributedString+Size.h"

@implementation NHDiscoverSearchCommonCellFrame

- (void)setGroup:(NHHomeServiceDataElementGroup *)group {
    _group = group;
    if (group == nil) {
        return ;
    }
    
    
    CGFloat contentX = 17;
    CGFloat contentY = 15;
    CGFloat contentW = kScreenWidth - 32;
    // 计算高度与关键字无关紧要
    CGFloat contentH  = [[NHUtils attStringWithString:group.content keyWord:nil] heightWithConstrainedWidth:contentW];
    
    self.contentLF = CGRectMake(contentX, contentY, contentW, contentH);
    
    
    CGFloat versionX = 15;
    CGFloat versionY = CGRectGetMaxY(self.contentLF) + 10;
    CGFloat versionH = 20;
    CGFloat versionW = [group.category_name widthWithFont:kFont(14) constrainedToHeight:versionH] + 25;
    self.version_BtnF = CGRectMake(versionX, versionY, versionW, versionH);
    
    
    
    CGFloat likeBtnY = CGRectGetMaxY(self.version_BtnF) + 15;
    
    if (group.media_type == 1) {
        // 大图
        CGFloat largeX = 20;
        CGFloat largeY = CGRectGetMaxY(self.version_BtnF) + 10;
        CGFloat largeW = kScreenWidth - 20 * 2;
        CGFloat largeH = largeW * group.large_image.r_height / group.large_image.r_width;
        self.largeImageCoverF = CGRectMake(largeX, largeY, largeW, largeH);
        likeBtnY = CGRectGetMaxY(self.largeImageCoverF) + 15;
    } else if (group.media_type == 3) {
        // 视频
        CGFloat videoX = 20;
        CGFloat videoY = CGRectGetMaxY(self.version_BtnF) + 10;
        CGFloat videoW = kScreenWidth - 20 * 2;
        CGFloat videoH = videoW * group.video_720P.height / group.video_720P.width;
        self.videoCoverF = CGRectMake(videoX, videoY, videoW, videoH);
        likeBtnY = CGRectGetMaxY(self.videoCoverF) + 15;
    }else if (group.media_type == 4) {
        // 小图
        [self.imageFrameArray removeAllObjects];
        
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
    
    
    CGFloat likeBtnX = 20;
    CGFloat likeBtnW = (kScreenWidth - 20 - 10 * 3) / 4.0;
    CGFloat likeBtnH = 35;
    self.likeCountBtnF = CGRectMake(likeBtnX, likeBtnY, likeBtnW, likeBtnH);
    
    CGFloat dontlikeBtnX = CGRectGetMaxX(self.likeCountBtnF) + 10;
    CGFloat dontlikeBtnY = likeBtnY;
    CGFloat dontlikeBtnW = likeBtnW;
    CGFloat dontlikeBtnH = likeBtnH;
    self.dontLikeCountBtnF = CGRectMake(dontlikeBtnX, dontlikeBtnY, dontlikeBtnW, dontlikeBtnH);
    
    CGFloat commentX = CGRectGetMaxX(self.dontLikeCountBtnF) + 10;
    CGFloat commentY = likeBtnY;
    CGFloat commentW = likeBtnW;
    CGFloat commentH = likeBtnH;
    self.commentCountBtnF = CGRectMake(commentX, commentY, commentW, commentH);
    
    CGFloat shareW = likeBtnW;
    CGFloat shareX = CGRectGetMaxX(self.commentCountBtnF) + 10;
    CGFloat shareY = likeBtnY;
    CGFloat shareH = likeBtnH;
    self.shareBtnF = CGRectMake(shareX, shareY, shareW, shareH);
    
    
    self.cellHeight = CGRectGetMaxY(self.shareBtnF) + 10;
    
    if (isnan(self.cellHeight)) {
        self.cellHeight = self.shareBtnF.origin.y + self.shareBtnF.size.height + 10;
    }

    
}

@end
