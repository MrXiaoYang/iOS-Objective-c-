//
//  NHFansAttentionHeaderOptionalView.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//  粉丝关注顶部选择视图

#import <UIKit/UIKit.h>

@interface NHFansAttentionHeaderOptionalView : UIView
/** 设置当前索引*/
@property (nonatomic, assign) NSInteger selectIndex;
/** 点击回调*/
@property (nonatomic, copy) void(^fansAttentionHeaderOptionalViewBtnClickHandle)(NHFansAttentionHeaderOptionalView *view, UIButton *btn, NSInteger currentIndex);

+ (instancetype)optionalView;

/** 默认选择*/
- (void)clickDefaultWithIndex:(NSInteger)index;
@end
