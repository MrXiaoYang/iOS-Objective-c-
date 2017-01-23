//
//  BTSubjectRankCell.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/28.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BTSubjectRankAuthor,BTSubjectRankCell;
@protocol BTSubjectRankCellDelegate <NSObject>

- (void)subjectRankCell:(BTSubjectRankCell *)rankCell
didClickAttentionButtonWithAuthor:(BTSubjectRankAuthor *)rankAuthor;

@end


@interface BTSubjectRankCell : UITableViewCell

@property (nonatomic, strong) BTSubjectRankAuthor *rankAuthor;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, assign,getter=isAttention) BOOL attention;

@property (nonatomic, weak)id <BTSubjectRankCellDelegate> delegate;

@end
