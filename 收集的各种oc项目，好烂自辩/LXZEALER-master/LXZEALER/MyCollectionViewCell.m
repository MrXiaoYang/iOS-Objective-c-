//
//  MyCollectionViewCell.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/1.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell{
    NSMutableArray *_imageNameArray;
}

- (void)awakeFromNib{
    _imageNameArray = [NSMutableArray arrayWithObjects:
                      @"icon_me_wdtz",
                      @"icon_me_wdcc",
                      @"icon_me_group",
                      @"icon_me_wdxx",
                      @"icon_me_notice",
                      @"icon_me_qchc",
                      @"icon_me_yjfk",
                      @"icon_me_about",
                      @"icon_me_wddd",
                      nil];
}

- (void)setImageForCellWithIndexPath:(NSIndexPath *)indexPath{
    self.nemuItemImage.image = [UIImage imageNamed:_imageNameArray[indexPath.row]];
}

@end
