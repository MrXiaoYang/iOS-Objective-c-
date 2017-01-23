//
//  SocialTableViewController.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/1.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "SocialTableViewController.h"
#import "FirstTableViewCell.h"
#import "SocialWebViewController.h"

@implementation SocialTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    UITabBarItem *item = self.tabBarController.tabBar.items[1];
    [item setSelectedImage:[UIImage imageNamed:@"tab_shequ_pre"]];
    [self shouldAddPullToRefresh:YES];
    [self shouldAddFooterRefresh:YES];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

/**
 *  base 类方法,在此方法里加载网络请求获取数据
 */
- (void)loadNewData{
    [super loadNewData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self endRefreshing];
    });
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell1";
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstTableViewCell" owner:self options:nil] objectAtIndex:1];
    }
    [cell setImageForCommentCellWithIndexpath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 168;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SocialWebViewController *socialVC = [[SocialWebViewController alloc] init];
    socialVC.websiteId = (int)indexPath.row + 5;
    [self.navigationController pushViewController:socialVC animated:YES];
}
@end
