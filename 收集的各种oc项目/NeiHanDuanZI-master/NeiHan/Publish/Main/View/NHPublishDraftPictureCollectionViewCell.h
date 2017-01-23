//
//  NHPublishDraftPictureCollectionViewCell.h
//  NeiHan
//
//  Created by Charles on 16/9/2.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHPublishDraftPictureCollectionViewCell : UICollectionViewCell
/** 图片*/
@property (nonatomic, strong) UIImage *image;
/** 删除图片回调*/
@property (nonatomic, copy) void(^publishDraftPictureCellDeleteImgHandle)(NHPublishDraftPictureCollectionViewCell *cell);
/** 添加图片回调*/
@property (nonatomic, copy) void(^publishDraftPictureCellAddImgHandle)(NHPublishDraftPictureCollectionViewCell *cell);
/** 是否显示关闭按钮*/
@property (nonatomic, assign) BOOL hiddenCloseBtn;
@end
