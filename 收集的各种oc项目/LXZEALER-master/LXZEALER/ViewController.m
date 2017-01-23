//
//  ViewController.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/1.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "ViewController.h"
#import "FirstTableViewCell.h"
#import <UIImage+GIF.h>
#import "ZealerVideoWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    [cell setImageForCellWithIndexpath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZealerVideoWebViewController *zealerVideo = [[ZealerVideoWebViewController alloc] init];
    zealerVideo.type = ScrollViewTableCellRequest;
    [self.navigationController pushViewController:zealerVideo animated:YES];
}

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *item = self.tabBarController.tabBar.items[0];
    [item setSelectedImage:[UIImage imageNamed:@"tab_home_pre"]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.tabBarController.tabBar.hidden = NO;
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    
}
@end
