//
//  RecommendTitleViewCell.h
//  BiliBili
//
//  Created by JimHuang on 16/1/14.
//  Copyright © 2016年 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendTitleViewCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIImageView *titleImg;
- (void)setTitle:(NSString*)title titleImg:(NSString*)titleimg;
@end
