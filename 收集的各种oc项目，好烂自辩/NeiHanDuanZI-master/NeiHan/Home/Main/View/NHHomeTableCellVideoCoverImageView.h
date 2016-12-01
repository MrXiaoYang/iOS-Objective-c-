//
//  NHHomeTableCellVideoCoverImageView.h
//  NeiHan
//
//  Created by Charles on 16/9/9.
//  Copyright © 2016年 Charles. All rights reserved.
//  视频封面

#import "NHBaseImageView.h"

@interface NHHomeTableCellVideoCoverImageView : NHBaseImageView

@property (nonatomic, copy) void(^homeTableCellVideoDidBeginPlayHandle)(UIButton *playBtn);

@end
