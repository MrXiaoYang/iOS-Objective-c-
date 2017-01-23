//
//  SocialGroupCollectionViewCell.h
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/3.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialGroupCollectionViewCell : UICollectionViewCell

- (void)setImageForCellWithIndexpath:(NSIndexPath*)indexpath;

@property (weak, nonatomic) IBOutlet UIImageView *groupImageView;

@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;



@end
