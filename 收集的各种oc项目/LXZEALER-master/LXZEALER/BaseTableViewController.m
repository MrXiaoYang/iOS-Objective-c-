//
//  BaseTableViewController.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/2.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "BaseTableViewController.h"
#import <MJRefresh.h>

@interface BaseTableViewController ()
{
    NSMutableArray *_refreshAnimationImages;
}

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _refreshAnimationImages = [NSMutableArray array];
    
    for ( int i = 1; i < 64 ;i ++) {
        NSString *imageName = [NSString stringWithFormat:@"refresh-%d",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [_refreshAnimationImages addObject:image];
    }
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.910 green:0.918 blue:0.937 alpha:1.000];
    [self shouldAddPullToRefresh:_shouldInitPullToRefresh];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.tintColor = [UIColor grayColor];
}

- (void)shouldAddPullToRefresh:(BOOL)isAdd
{
    if (isAdd) {
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        // 设置普通状态的动画图片
        [header setImages:_refreshAnimationImages duration:0.8 forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [header setImages:_refreshAnimationImages duration:0.8 forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        [header setImages:_refreshAnimationImages duration:0.8 forState:MJRefreshStateRefreshing];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        // 设置header
        self.tableView.header = header;
    }else{
        self.tableView.header = nil;
    }
}

- (void)shouldAddFooterRefresh:(BOOL)isAdd{
    if (isAdd) {
        MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
            NSLog(@"下拉刷新");
            [NSThread sleepForTimeInterval:1.0];
            [self.tableView.footer endRefreshing];
        }];
        [footer setTitle:@"上拉可以加载更多数据" forState:MJRefreshStateIdle];
        [footer setTitle:@"松开立即加载更多数据" forState:MJRefreshStatePulling];
        [footer setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
        self.tableView.footer = footer;
    }else{
        self.tableView.footer = nil;
    }
}

- (void)loadNewData
{
    NSLog(@"刷新数据");
}

- (void)endRefreshing{
    [self.tableView.header endRefreshing];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
