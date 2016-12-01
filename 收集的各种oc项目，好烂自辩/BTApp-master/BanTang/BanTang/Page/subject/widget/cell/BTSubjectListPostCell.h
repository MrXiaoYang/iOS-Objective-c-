//
//  BTSubjectListPostCell.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/28.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTListPost,BTSubjectListPostCell,BTTag;

@protocol BTSubjectListPostCellDelegate <NSObject>

/** 点击了头像 */
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickIconButtonWithIndex:(NSInteger)index;

/** 点击了关注 */
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickAttentionButtonWithIndex:(NSInteger)index;

/** 点击了tag标签 */
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickTag:(BTTag *)tag;

/** 点击了购买按钮 */
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickBuyButtonWithIndex:(NSInteger)index;

/** 点击了评论按钮 */
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickCommentButtonWithIndex:(NSInteger)index;

/** 点击了喜欢按钮 */
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickLikeButtonWithIndex:(NSInteger)index;

@end

@interface BTSubjectListPostCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) BTListPost *listPost;

@property (nonatomic, weak) id <BTSubjectListPostCellDelegate> delegate;

@property (nonatomic, assign, getter=isAttention) BOOL attention;

@property (nonatomic, assign) BOOL collect;

@end
