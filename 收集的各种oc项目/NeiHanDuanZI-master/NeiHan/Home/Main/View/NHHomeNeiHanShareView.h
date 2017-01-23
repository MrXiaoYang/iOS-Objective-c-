//
//  NHHomeNeiHanShareView.h
//  NeiHan
//
//  Created by Charles on 16/9/6.
//  Copyright © 2016年 Charles. All rights reserved.
//   分享视图

#import <UIKit/UIKit.h>
#import "NHNeiHanShareManager.h"

typedef NS_ENUM(NSUInteger, NHHomeNeiHanShareViewType) {
    /** 显示复制和收藏*/
    NHHomeNeiHanShareViewTypeShowCopyAndCollect,
    /** 不显示复制和收藏*/
    NHHomeNeiHanShareViewTypeDontShowCopyAndCollect,
};

@class NHHomeNeiHanShareView;
typedef void(^NHHomeHeiHanShareViewItemClickHandle)(NHHomeNeiHanShareView *shareView, NSString *title, NSInteger index, NHNeiHanShareType shareType);

typedef void(^NHHomeHeiHanShareViewBottomItemClickHandle)(NHHomeNeiHanShareView *shareView, NSString *title, NSInteger index);

@interface NHHomeNeiHanShareView : UIView

+ (instancetype)shareViewWithType:(NHHomeNeiHanShareViewType)type;
+ (instancetype)shareViewWithType:(NHHomeNeiHanShareViewType)type hasRepinFlag:(BOOL)hasRepinFlag;
/** 展现*/
- (void)showInView:(UIView *)view;

/** 移除*/
- (void)dismiss;
- (void)dismissWithBlock:(void(^)())block;

/** 点击分享回调事件*/
- (void)setUpItemClickHandle:(NHHomeHeiHanShareViewItemClickHandle)itemClickHandle;
/** 点击收藏，复制，举报回调事件*/
- (void)setUpBottomItemClickHandle:(NHHomeHeiHanShareViewBottomItemClickHandle)bottomItemClickHandle;
@end
