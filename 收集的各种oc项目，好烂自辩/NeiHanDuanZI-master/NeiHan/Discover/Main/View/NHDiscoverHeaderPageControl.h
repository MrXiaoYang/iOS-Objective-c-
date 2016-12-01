//
//  NHDiscoverHeaderPageControl.h
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//  发现界面顶部轮播视图，自定义pageControl，类似于UIPageControl

#import <UIKit/UIKit.h>

@interface NHDiscoverHeaderPageControl : UIView

@property (nonatomic, assign) NSInteger numberOfItems;
/** 当前索引*/
@property (nonatomic, assign) NSInteger currentIndex;
/** 每一个item的宽度*/
@property (nonatomic, assign) CGFloat pageWidth;
/** item间隙，类似于collectionview的item间隙 水平方向*/
@property (nonatomic, assign) CGFloat pageSpace;

/** 选中颜色*/
@property (nonatomic, strong) UIColor *selectedItemColor;
/** 正常颜色*/
@property (nonatomic, strong) UIColor *normalItemColor;

+ (instancetype)pageControl;
@end
