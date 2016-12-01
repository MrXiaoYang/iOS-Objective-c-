//
//  NHHomeUserIconView.h
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//   封装起来，以便以后加红点之类的子控件 / 导航栏左侧用户头像

#import <UIKit/UIKit.h>

@interface NHHomeUserIconView : UIView

+ (instancetype)iconView;

/** 头像链接*/
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, strong) UIImage *image;

/** 点击头像回调*/
@property (nonatomic, copy) void(^homeUserIconViewDidClickHandle)(NHHomeUserIconView *iconView);
@end
