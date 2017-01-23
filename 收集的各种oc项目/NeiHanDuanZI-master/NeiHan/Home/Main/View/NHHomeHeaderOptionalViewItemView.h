//
//  NHHomeHeaderOptionalViewItemView.h
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//  首页顶部滚动视图item

#import <UIKit/UIKit.h>

@interface NHHomeHeaderOptionalViewItemView : UILabel
/** 填充色，从左开始*/
@property (nonatomic, strong) UIColor *fillColor;
/** 滑动进度*/
@property (nonatomic, assign) CGFloat progress;
@end
