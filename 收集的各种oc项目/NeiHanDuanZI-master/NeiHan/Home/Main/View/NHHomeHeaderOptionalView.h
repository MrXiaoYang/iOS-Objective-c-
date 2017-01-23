//
//  NHHomeHeaderOptionalView.h
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//  首页顶部滚动选择条

#import <UIKit/UIKit.h>

@interface NHHomeHeaderOptionalView : UIView
/** 标题数组*/
@property (nonatomic, strong) NSArray <NSString *>*titles;
/** 点击item回调*/
@property (nonatomic, copy) void(^homeHeaderOptionalViewItemClickHandle)(NHHomeHeaderOptionalView *optialView, NSString *title, NSInteger currentIndex);
/** 偏移量*/
@property (nonatomic, assign) CGPoint contentOffset;

@end
