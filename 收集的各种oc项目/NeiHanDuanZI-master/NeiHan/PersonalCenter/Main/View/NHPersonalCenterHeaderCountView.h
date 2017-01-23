//
//  NHPersonalCenterCountView.h
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//  个人中心的投稿收藏和评论

#import <UIKit/UIKit.h>
#import "NHPersonalCenterHeaderConstant.h"

@class NHPersonalCenterHeaderCountView;
@protocol NHPersonalCenterHeaderCountViewDelegate <NSObject>
- (void)personalCenterHeaderCountView:(NHPersonalCenterHeaderCountView *)countView buttonType:(NHPersonalCenterHeaderViewItemType)buttonType;
@end

@interface NHPersonalCenterHeaderCountView : UIView

@property (nonatomic, weak) id <NHPersonalCenterHeaderCountViewDelegate> delegate;

// 关注、粉丝、积分
@property (nonatomic, assign) NSInteger follow_count;
@property (nonatomic, assign) NSInteger fans_count;
@property (nonatomic, assign) NSInteger share_count;
@end

