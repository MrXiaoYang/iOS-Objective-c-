//
//  RecommendContentCollectionViewCell.h
//  BiliBili
//
//  Created by JimHuang on 16/1/14.
//  Copyright © 2016年 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendContentCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *imgv;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *playIcon;
@property (strong, nonatomic) UILabel *playLabel;
@property (strong, nonatomic) UIImageView *danMuIcon;
@property (strong, nonatomic) UILabel *danMuLabel;

- (void)setUpProperty;
@end
