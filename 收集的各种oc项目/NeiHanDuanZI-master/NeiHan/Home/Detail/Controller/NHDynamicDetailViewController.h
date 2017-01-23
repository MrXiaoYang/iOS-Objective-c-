//
//  NHDynamicDetailViewController.h
//  NeiHan
//
//  Created by Charles on 16/9/3.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseTableViewController.h"

@class NHHomeTableViewCellFrame, NHDiscoverSearchCommonCellFrame;
@interface NHDynamicDetailViewController : NHBaseTableViewController
/** 初始化*/
- (instancetype)initWithCellFrame:(NHHomeTableViewCellFrame *)cellFrame;
/** 初始化*/
- (instancetype)initWithSearchCellFrame:(NHDiscoverSearchCommonCellFrame *)searchCellFrame;

@end
