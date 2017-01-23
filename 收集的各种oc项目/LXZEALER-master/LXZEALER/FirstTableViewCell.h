//
//  FirstTableViewCell.h
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/2.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTableViewCell : UITableViewCell

- (void)setImageForCellWithIndexpath:(NSIndexPath*)indexpath;

- (void)setImageForCommentCellWithIndexpath:(NSIndexPath*)indexpath;

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;

@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;

@end
