//
//  NHCheckTableViewCell.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NHCheckViewCellFrame, NHCheckTableViewCell; 
@protocol NHCheckTableViewCellDelegate <NSObject>

/** 点击浏览大图*/
- (void)checkTableViewCell:(NHCheckTableViewCell *)cell
        didClickImageView:(UIImageView *)imageView
             currentIndex:(NSInteger)currentIndex
                     urls:(NSArray <NSURL *>*)urls;

/** 点击举报*/
- (void)checkTableViewCell:(NHCheckTableViewCell *)cell didClickReport:(BOOL)didClickReport;

/** 点击喜欢和不喜欢*/
- (void)checkTableViewCell:(NHCheckTableViewCell *)cell didFinishLoadingHandleWithLikeFlag:(BOOL)likeFlag;
@end

@interface NHCheckTableViewCell : UICollectionViewCell
/** 审核的cellFrame*/
@property (nonatomic, strong) NHCheckViewCellFrame *cellFrame;
@property (nonatomic, weak) id <NHCheckTableViewCellDelegate> delegate;
@end
