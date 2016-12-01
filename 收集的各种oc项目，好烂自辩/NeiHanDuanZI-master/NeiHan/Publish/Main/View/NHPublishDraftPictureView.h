//
//  NHPublishDraftPictureView.h
//  NeiHan
//
//  Created by Charles on 16/9/2.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NHPublishDraftPictureView;
@protocol NHPublishDraftPictureViewDelegate <NSObject>
/** 删除时需要回调，增加时也需要回调，控制器只需要接收*/
- (void)publishDraftPictureView:(NHPublishDraftPictureView *)pictureView picArrayDidChange:(NSArray *)picArray;
/** 添加图片*/
- (void)publishDraftPictureViewAddImage:(NHPublishDraftPictureView *)pictureView;
@end

@interface NHPublishDraftPictureView : UIView

@property (nonatomic, strong) NSMutableArray <UIImage *>*pictureArray;

/** 添加图片*/
- (void)addImages:(NSArray *)images;

@property (nonatomic, weak) id <NHPublishDraftPictureViewDelegate> delegate;

@end
