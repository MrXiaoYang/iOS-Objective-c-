//
//  BTListPostInfoCell.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/29.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTListPost,BTListPostInfoCell,BTListPostInfoView,BTTag;
@protocol BTListPostInfoCellDelegate <NSObject>

/** 点击了头像 */
- (void)listPostInfoCell:(BTListPostInfoCell *)listPostInfoCell didClickIconButtonWithListPost:(BTListPost *)listPost;

/** 点击了关注 */
- (void)listPostInfoCell:(BTListPostInfoCell *)listPostInfoCell didClickAttentionButtonWithListPost:(BTListPost *)listPost;

/** 点击了tag标签 */
- (void)listPostInfoCell:(BTListPostInfoCell *)listPostInfoCell didClickTag:(BTTag *)tag;

@end

@interface BTListPostInfoCell : UITableViewCell

@property (nonatomic, strong) BTListPost *listPost;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) id <BTListPostInfoCellDelegate> delegate;

@property (nonatomic, strong,readonly) BTListPostInfoView *infoView;

@end
