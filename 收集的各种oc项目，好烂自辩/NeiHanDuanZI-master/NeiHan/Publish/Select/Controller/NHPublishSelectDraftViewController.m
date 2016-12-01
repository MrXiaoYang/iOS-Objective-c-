//
//  NHPublishSelectDraftViewController.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHPublishSelectDraftViewController.h"
#import "NHPublishSelectDraftTableViewCell.h"
#import "NHPublishSelectDraftModel.h"
#import "NHPublishSelectDraftRequest.h"

@implementation NHPublishSelectDraftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpItems];
    
    // 请求数据
    [self loadData];
}

// 设置导航栏
- (void)setUpItems {
    // 设置标题
    self.navItemTitle = @"投稿选吧";
}

// 请求数据
- (void)loadData {
    NHPublishSelectDraftRequest *request = [NHPublishSelectDraftRequest nh_request];
    request.nh_url = kNHUserPublishSelectDraftListAPI;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            self.dataArray = [NHPublishSelectDraftModel modelArrayWithDictArray:response];
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
    NHPublishSelectDraftTableViewCell *cell = [NHPublishSelectDraftTableViewCell cellWithTableView:self.tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (UIEdgeInsets)nh_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(NHBaseTableViewCell *)cell {
    
    // 1. 返回
    [self pop];
    
    // 2. 回调
    if (self.publishSelectDraftSelectNameHandle) {
        NHPublishSelectDraftModel *model = self.dataArray[indexPath.row];
        self.publishSelectDraftSelectNameHandle(self, model.name, model.ID);
    }
}

@end
