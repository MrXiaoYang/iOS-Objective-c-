//
//  ShiBanTitleCollectionViewCell.h
//  BiliBili
//
//  Created by JimHuang on 16/1/14.
//  Copyright © 2016年 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShiBanTitleCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *recommedLabel;
@property (nonatomic, strong) UIImageView* recommedIcon;
- (void)setUpProperty;
@end
