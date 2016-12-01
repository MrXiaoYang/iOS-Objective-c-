//
//  BTHomePageHeaderView.h
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BTHomePageHeaderView;

@protocol BTHomePageHeaderViewDelegate <NSObject>

@optional
// 点击了轮播图
- (void)headerView:(BTHomePageHeaderView *)headerView didClickBannerViewWithIndex:(NSInteger)index;
// 点击了entryList
- (void)headerView:(BTHomePageHeaderView *)headerView didClickEntryListWithIndex:(NSInteger)index;
// 点击了左边的按钮
- (void)headerViewDidClickLeftButton:(BTHomePageHeaderView *)headerView;
// 点击了右边的按钮
- (void)headerViewDidClickRightButton:(BTHomePageHeaderView *)headerView;

@end

@interface BTHomePageHeaderView : UIView
/**
 *  初始化banner
 *
 *  @param imagesArray    图片地址的数组
 *  @param entryListArray entry实体数组
 */
- (instancetype)initWithBannerImagesArray:(NSArray *)imagesArray
                           entryListArray:(NSArray *)entryListArray;


@property (nonatomic, strong) NSArray *imagesArray;

@property (nonatomic, strong) NSArray *entryListArray;

@property (nonatomic, weak) id <BTHomePageHeaderViewDelegate> delegate;

@end
