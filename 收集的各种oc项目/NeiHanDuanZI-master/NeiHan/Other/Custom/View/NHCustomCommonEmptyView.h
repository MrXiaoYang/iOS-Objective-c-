//
//  NHCustomCommonEmptyView.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//  公共空界面显示视图

#import <UIKit/UIKit.h>

@interface NHCustomCommonEmptyView : UIView
@property (nonatomic, weak) UIImageView *topTipImageView;
@property (nonatomic, weak) UILabel *firstL;
@property (nonatomic, weak) UILabel *secondL;

- (instancetype)initWithTitle:(NSString *)title
                  secondTitle:(NSString *)secondTitle
                     iconname:(NSString *)iconname;
- (instancetype)initWithAttributedTitle:(NSMutableAttributedString *)attributedTitle
                  secondAttributedTitle:(NSMutableAttributedString *)secondAttributedTitle
                               iconname:(NSString *)iconname;
- (void)showInView:(UIView *)view;

@end
