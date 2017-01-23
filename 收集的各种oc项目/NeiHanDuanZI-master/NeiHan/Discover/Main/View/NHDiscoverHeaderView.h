//
//  NHDiscoverHeaderView.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//  轮播图

#import <UIKit/UIKit.h>

@class NHDiscoverHeaderViewViewCell, NHDiscoverRotate_bannerElementBanner_url_URL, NHDiscoverRotate_bannerElement;
@interface NHDiscoverHeaderView : UIView
/** 数据源*/
@property (nonatomic, strong) NSArray <NHDiscoverRotate_bannerElement *>*modelArray;
/** 点击回调*/
@property (nonatomic, copy) void(^discoverHeaderViewGoToPageHandle)(NHDiscoverHeaderViewViewCell *cell, NHDiscoverRotate_bannerElement *bannerUrlModel);
@end
