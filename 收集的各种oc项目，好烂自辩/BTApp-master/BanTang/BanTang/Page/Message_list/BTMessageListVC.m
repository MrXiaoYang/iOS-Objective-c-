//
//  BTMessageListVC.m
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTMessageListVC.h"
#import "BTMessageNotice.h"
#import "BTMessageListCell.h"

@interface BTMessageListVC ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation BTMessageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupTitle];
    
    [self loadData];
}

- (void)setupTableView
{
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 70;
}

- (void)loadData
{
    [BTUserManager getNoticeListWithType:self.messageType SuccessHandler:^(NSArray *noticeList) {
        [self.dataArray addObjectsFromArray:noticeList];
        [self.tableView reloadData];
    } failureHandler:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BTMessageListCell *cell = [BTMessageListCell cellWithTableView:tableView];
    cell.notice = self.dataArray[indexPath.row];
    return cell;
}

- (void)setupTitle
{
    switch (self.messageType) {
        case BTMessageTypeNotification:
            self.title = @"通知";
            break;
        case BTMessageTypeNewFans:
            self.title = @"新的粉丝";
            break;
        case BTMessageTypeNewComment:
            self.title = @"新的评论";
            break;
        case BTMessageTypeNewLike:
            self.title = @"新的喜欢";
            break;
        case BTMessageTypeNewReward:
            self.title = @"奖励";
            break;
        default:
            break;
    }
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
