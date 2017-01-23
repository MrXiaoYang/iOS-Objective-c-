//
//  NHDynamicDetailCommentCellFrame.h
//  NeiHan
//
//  Created by Charles on 16/9/3.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NHHomeServiceDataElementComment;
@interface NHDynamicDetailCommentCellFrame : NSObject
@property (nonatomic, strong) NHHomeServiceDataElementComment *commentModel;
@property (nonatomic, assign)  CGRect iconImgF;
@property (nonatomic, assign) CGRect nameLF;
@property (nonatomic, assign) CGRect contentLF;
@property (nonatomic, assign) CGRect timeLF;
@property (nonatomic, assign) CGRect likeCountBtnF; 
@property (nonatomic, assign) CGRect shareBtnF; 
@property (nonatomic, assign) double cellHeight;
@end
