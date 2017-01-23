//
//  NHDiscoverSearchFriendCell.h
//  NeiHan
//
//  Created by Charles on 16/9/2.
//  Copyright © 2016年 Charles. All rights reserved.
//  搜索用户结果cell

#import "NHBaseTableViewCell.h"

@class NHNeiHanUserInfoModel;
@interface NHDiscoverSearchFriendCell : NHBaseTableViewCell
/** 关键词*/
@property (nonatomic, copy) NSString *keyWord;
/** 数据源*/
@property (nonatomic, strong) NSArray <NHNeiHanUserInfoModel *>*models;
/** 更多段友*/
@property (nonatomic, copy) void(^discoverSearchFriendCellMoreFriends)();
/** 个人中心*/
@property (nonatomic, copy) void(^discoverSearchFriendCellGotoPersonalCenter)(NSInteger user_id);
@end
