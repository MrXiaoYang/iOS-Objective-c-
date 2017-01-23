//
//  BaseTableViewController.h
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/2.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController

@property (nonatomic, assign) BOOL shouldInitPullToRefresh;

- (void)shouldAddPullToRefresh:(BOOL)isAdd;

- (void)shouldAddFooterRefresh:(BOOL)isAdd;

- (void)loadNewData;

- (void)endRefreshing;
@end
