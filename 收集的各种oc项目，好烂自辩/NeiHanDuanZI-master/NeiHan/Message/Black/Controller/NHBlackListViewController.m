//
//  NHBlackListViewController.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBlackListViewController.h"
#import "NHCustomCommonEmptyView.h"
#import "NHNeiHanBlackRequest.h"
#import "NHNeiHanUserInfoModel.h"
#import "NHNeiHanBlackListTableViewCell.h"

@interface NHBlackListViewController ()
@property (nonatomic, weak) NHCustomCommonEmptyView *emptyView;
@end

@implementation NHBlackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpItems];
    
    // 请求数据
    [self loadData];
}

// 设置导航栏
- (void)setUpItems {
    self.navItemTitle = @"黑名单";
}

// 请求数据
- (void)loadData {
    NHNeiHanBlackRequest *request = [NHNeiHanBlackRequest nh_request];
    request.nh_url = kNHUserBlackUserListAPI;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            self.dataArray = [NHNeiHanUserInfoModel modelArrayWithDictArray:response];
            if (self.dataArray.count == 0) {
                [self.emptyView showInView:self.view];
            } else {
                [self.emptyView removeFromSuperview];
            }
            [self nh_reloadData];
        }
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)nh_numberOfSections {
    return 1;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NHBaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath {
    NHNeiHanBlackListTableViewCell *cell = [NHNeiHanBlackListTableViewCell cellWithTableView:self.tableView];
    cell.userInfo = self.dataArray[indexPath.row];
    cell.neiHanBlackListTableViewCellCancelBlackHandle = ^(NHNeiHanBlackListTableViewCell *cell, NHNeiHanUserInfoModel *userInfoModel) {
        
    };
    return cell;
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (NHCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        NHCustomCommonEmptyView *empty = [[NHCustomCommonEmptyView alloc] initWithTitle:@"好友很靠谱，黑名单暂无" secondTitle:@"这里可以看到被你加入黑名单的用户并解除黑名单" iconname:@""];
        [self.view addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}

@end
