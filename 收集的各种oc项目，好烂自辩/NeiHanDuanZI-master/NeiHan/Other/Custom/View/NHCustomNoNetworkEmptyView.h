//
//  NHCustomNoNetworkEmptyView.h
//  NeiHan
//
//  Created by Charles on 16/9/2.
//  Copyright © 2016年 Charles. All rights reserved.
//  没有网络时候显示的视图

#import <UIKit/UIKit.h>

@interface NHCustomNoNetworkEmptyView : UIView
/** 没有网络，重试*/
@property (nonatomic, copy) void(^customNoNetworkEmptyViewDidClickRetryHandle)(NHCustomNoNetworkEmptyView *view);
@end
