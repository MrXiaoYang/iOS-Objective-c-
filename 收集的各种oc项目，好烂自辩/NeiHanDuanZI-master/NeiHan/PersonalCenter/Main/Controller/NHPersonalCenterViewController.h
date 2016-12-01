//
//  NHPersonalCenterViewController.h
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseTableViewController.h"

@class NHNeiHanUserInfoModel;
@interface NHPersonalCenterViewController : NHBaseTableViewController
/** 初始化*/
- (instancetype)initWithUserInfoModel:(NHNeiHanUserInfoModel *)userInfoModel;
/** 初始化*/
- (instancetype)initWithUserId:(NSInteger)userId;

@end
