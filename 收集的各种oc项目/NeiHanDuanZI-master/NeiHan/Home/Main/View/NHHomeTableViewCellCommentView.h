//
//  NHHomeTableViewCellCommentView.h
//  NeiHan
//
//  Created by Charles on 16/9/6.
//  Copyright © 2016年 Charles. All rights reserved.
//  首页cell的神评视图

#import <UIKit/UIKit.h>

@class NHHomeServiceDataElementComment, NHHomeTableViewCellCommentView;

@protocol NHHomeTableViewCellCommentViewDelegate <NSObject>

/** 分享*/
- (void)homeTableViewCellCommentView:(NHHomeTableViewCellCommentView *)commentView didShareWithCommentModel:(NHHomeServiceDataElementComment *)comment;
/** 回复*/
- (void)homeTableViewCellCommentView:(NHHomeTableViewCellCommentView *)commentView didReplyWithCommentModel:(NHHomeServiceDataElementComment *)comment;
/** 点赞*/
- (void)homeTableViewCellCommentView:(NHHomeTableViewCellCommentView *)commentView didLikeWithCommentModel:(NHHomeServiceDataElementComment *)comment;
/** 用户*/
- (void)homeTableViewCellCommentView:(NHHomeTableViewCellCommentView *)commentView didClickUserNameWithCommentModel:(NHHomeServiceDataElementComment *)comment;

@end
@interface NHHomeTableViewCellCommentView : UIView
/** 数据模型*/
@property (nonatomic, strong) NHHomeServiceDataElementComment *comment;
@property (nonatomic , weak) id <NHHomeTableViewCellCommentViewDelegate> delegate;
@end
