//
//  BTSubjectRankListVC.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/28.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTSubjectRankListVC.h"
#import "BTSubjectRankCell.h"
#import "BTSubjectAuthor.h"
#import "BTSubjectRankAuthor.h"
#import "BTUserManager.h"
@interface BTSubjectRankListVC () <BTSubjectRankCellDelegate>

@end

@implementation BTSubjectRankListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"排行榜";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 75;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 5, 0);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rankList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTSubjectRankCell *cell = [BTSubjectRankCell cellWithTableView:tableView];
    BTSubjectRankAuthor *author = self.rankList[indexPath.row];
    cell.rankAuthor = author;
    cell.delegate = self;
    return cell;
}

- (void)subjectRankCell:(BTSubjectRankCell *)rankCell
didClickAttentionButtonWithAuthor:(BTSubjectRankAuthor *)author
{
    if (author.attentionType == 0) { // 未关注状态,需要调用关注接口
        [BTUserManager followUserWithFriendId:author.userId success:^{
            //关注成功,更新按钮的图片
            author.attentionType = 1;
            [rankCell setAttention:YES];
        } failure:nil];
    }else if (author.attentionType == 1){ // 关注状态,需要调用取消关注接口
        [BTUserManager unfollowUserWithFriendId:author.userId success:^(BOOL success) {
            if (success) { // 取消关注成功
                author.attentionType = 0;
            [rankCell setAttention:NO];;
            }
        } failure:nil];
    }
}

@end
