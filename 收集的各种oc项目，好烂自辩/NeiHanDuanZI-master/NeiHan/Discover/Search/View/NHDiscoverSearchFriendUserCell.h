//
//  NHDiscoverSearchFriendUserCell.h
//  NeiHan
//
//  Created by Charles on 16/9/11.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseTableViewCell.h"

@class NHNeiHanUserInfoModel;
@interface NHDiscoverSearchFriendUserCell : NHBaseTableViewCell
/** 用户信息*/
@property (nonatomic, strong) NHNeiHanUserInfoModel *userInfoModel;
@end
