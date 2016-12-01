//
//  NHNeiHanBlackListTableViewCell.h
//  NeiHan
//
//  Created by Charles on 16/9/6.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseTableViewCell.h"

@class NHNeiHanUserInfoModel;

@interface NHNeiHanBlackListTableViewCell : NHBaseTableViewCell
@property (nonatomic, strong) NHNeiHanUserInfoModel *userInfo;

@property (nonatomic, copy) void(^neiHanBlackListTableViewCellCancelBlackHandle)(NHNeiHanBlackListTableViewCell *cell, NHNeiHanUserInfoModel *userInfo);

@end
