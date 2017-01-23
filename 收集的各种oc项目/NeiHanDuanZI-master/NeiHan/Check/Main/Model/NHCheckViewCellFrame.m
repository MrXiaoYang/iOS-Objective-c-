//
//  NHCheckViewCellFrame.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHCheckViewCellFrame.h"
#import "NSString+Size.h"
#import "NHHomeServiceDataModel.h"
#import "NSAttributedString+Size.h"

@implementation NHCheckViewCellFrame
- (NSMutableArray *)imageFrameArray {
    if (!_imageFrameArray) {
        _imageFrameArray = [NSMutableArray new];
    }
    return _imageFrameArray;
}

- (void)setModel:(NHHomeServiceDataElement *)model {
    _model = model;
    NHHomeServiceDataElementGroup *group = model.group;
    if (group == nil) {
        return ;
    }
    // 文本
    CGFloat contentX = 17;
    CGFloat contentW = kScreenWidth - 32;
    CGFloat contentH = [[NHUtils attStringWithString:group.content keyWord:nil] heightWithConstrainedWidth:contentW];
    CGFloat contentY = 15;
    if (group.content.length == 0) {
        contentY = 8.0;
    }
    self.contentLF = CGRectMake(contentX, contentY, contentW, contentH);
    
    // 举报
    CGFloat reportBtnY = CGRectGetMaxY(self.contentLF) + 15;
    
    switch (group.media_type) {
        case NHHomeServiceDataElementMediaTypeLargeImage: {
            CGFloat largeX = 20;
            CGFloat largeY = CGRectGetMaxY(self.contentLF) + 10;
            CGFloat largeW = kScreenWidth - 20 * 2;
            CGFloat largeH = largeW * group.large_image.r_height / group.large_image.r_width;
            self.largeImageCoverF = CGRectMake(largeX, largeY, largeW, largeH);
            reportBtnY = CGRectGetMaxY(self.largeImageCoverF) + 15;
        } break;
            
        case NHHomeServiceDataElementMediaTypeGif: {
            CGFloat gifX = 20;
            CGFloat gifY = CGRectGetMaxY(self.contentLF) + 10;
            CGFloat gifW = kScreenWidth - 20 * 2;
            CGFloat gifH = gifW * group.large_image.r_height / group.large_image.r_width;
            self.gifCoverF = CGRectMake(gifX, gifY, gifW, gifH);
            reportBtnY = CGRectGetMaxY(self.gifCoverF) + 15;
        } break;
            
        case NHHomeServiceDataElementMediaTypeVideo: {
            CGFloat videoX = 20;
            CGFloat videoY = CGRectGetMaxY(self.contentLF) + 10;
            CGFloat videoW = kScreenWidth - 20 * 2;
            CGFloat videoH = videoW * group.video_720P.height / group.video_720P.width;
            self.videoCoverF = CGRectMake(videoX, videoY, videoW, videoH);
            reportBtnY = CGRectGetMaxY(self.videoCoverF) + 15;
        } break;
            
        case NHHomeServiceDataElementMediaTypeLittleImages: {
            [self.imageFrameArray removeAllObjects];
            if (group.large_image_list.count) {
                for (int i = 0; i < group.large_image_list.count; i++) {
                    int col = i % 3; // 第几列
                    int row = i / 3;
                    CGFloat margin = 15;
                    CGFloat imageW = (kScreenWidth - 15 * 4) / 3.0;
                    CGFloat imageX =  margin * (col + 1) + col * imageW;
                    CGFloat imageH = imageW;
                    CGFloat imageY = margin * (row + 1) + row * imageH + CGRectGetMaxY(self.contentLF) + 10;
                    CGRect imageRect = CGRectMake(imageX, imageY, imageW, imageH);
                    reportBtnY = CGRectGetMaxY(imageRect) + 15;
                    [self.imageFrameArray addObject:NSStringFromCGRect(imageRect)];
                }
            }
        } break;
            
        default:
            break;
    }
    
    CGFloat reportBtnX = 15;
    CGFloat reportBtnW = 50;
    CGFloat reportBtnH = 30;
    self.reportBtnF = CGRectMake(reportBtnX, reportBtnY, reportBtnW, reportBtnH);
    
    // 顶部白色区域
    CGFloat topContentLX = 0;
    CGFloat topContentLY = 0;
    CGFloat topContentLW = kScreenWidth;
    CGFloat topContentLH = CGRectGetMaxY(self.reportBtnF) + 10;
    self.topContentLF = CGRectMake(topContentLX, topContentLY, topContentLW, topContentLH);
    
    // 喜欢
    CGFloat likeX = 15;
    CGFloat likeY = CGRectGetMaxY(self.topContentLF) + 10;
    CGFloat likeW = 50;
    CGFloat likeH = 50;
    self.likeF = CGRectMake(likeX, likeY, likeW, likeH);
    
    // 喜欢
    CGFloat likeLX = likeX;
    CGFloat likeLY = CGRectGetMaxY(self.likeF) + 5;
    CGFloat likeLW = 50;
    CGFloat likeLH = 20;
    self.likeLF = CGRectMake(likeLX, likeLY, likeLW, likeLH);
    
    // 不喜欢
    CGFloat disLikeX = kScreenWidth - 15 - 50;
    CGFloat disLikeY = likeY;
    CGFloat disLikeW = likeW;
    CGFloat disLikeH = likeH;
    self.disLikeF = CGRectMake(disLikeX, disLikeY, disLikeW, disLikeH);
    
    // 不喜欢
    CGFloat disLikeLX = disLikeX;
    CGFloat disLikeLY = CGRectGetMaxY(self.disLikeF) + 5;
    CGFloat disLikeLW = 50;
    CGFloat disLikeLH = 20;
    self.disLikeLF = CGRectMake(disLikeLX, disLikeLY, disLikeLW, disLikeLH);
    
    // 动画
    CGFloat barX = CGRectGetMaxX(self.likeF) + 10;
    CGFloat barY = CGRectGetMinY(self.likeF);
    CGFloat barW = kScreenWidth - barX * 2.0;
    CGFloat barH = likeH;
    self.barF = CGRectMake(barX, barY, barW, barH);
    
    // 容器
    CGFloat scX = 0;
    CGFloat scY = 0;
    CGFloat scW = kScreenWidth;
    CGFloat scH = kScreenHeight - kTopBarHeight - kTabBarHeight;
    self.scrollViewF = CGRectMake(scX, scY, scW, scH);
    self.cellHeight = scH;
    self.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(self.disLikeLF) + 10);
}
@end
