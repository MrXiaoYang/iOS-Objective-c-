//
//  MyCollectionViewCell.h
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/1.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *nemuItemImage;

- (void)setImageForCellWithIndexPath:(NSIndexPath*)indexPath;

@end
