//
//  NHPersonalCenterHeaderView.h
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//  个人中心

#import <UIKit/UIKit.h>
#import "NHPersonalCenterHeaderConstant.h"

@class NHPersonalCenterHeaderView, NHNeiHanUserInfoModel;
@protocol NHPersonalCenterHeaderViewDelegate <NSObject>

- (void)personalCenterHeaderView:(NHPersonalCenterHeaderView *)headerView didClickItemWithType:(NHPersonalCenterHeaderViewItemType)itemType;

@end

@interface NHPersonalCenterHeaderView : UIView
/** 用户信息*/
@property (nonatomic, strong) NHNeiHanUserInfoModel *userInfoModel;

@property (nonatomic, weak) id <NHPersonalCenterHeaderViewDelegate> delegate;
@end
