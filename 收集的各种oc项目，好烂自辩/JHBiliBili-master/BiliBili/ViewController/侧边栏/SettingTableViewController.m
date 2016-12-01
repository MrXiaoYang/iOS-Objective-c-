//
//  SettingTableViewController.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/22.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
}

- (instancetype)init{
    if (self = [super init]) {
        self.navigationItem.title = @"设置";
    }
    return self;
}


#pragma mark - TableViewController
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    label.font = [UIFont systemFontOfSize: 15];
    label.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
    UIView* grayView = [[UIView alloc] initWithFrame:CGRectMake(10, label.frame.size.height - 1.5, label.frame.size.width - 20, 1.5)];
    
    grayView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
    [label addSubview: grayView];
    
    if (section == 0) {
        label.text = @"\t播放";
    }else if (section == 1){
        label.text = @"\t高级";
    }else{
        label.text = @"\t其它";
    }
    return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
        cell.textLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"清晰度选择";
        cell.detailTextLabel.text = [[[NSUserDefaults standardUserDefaults] stringForKey:@"HightResolution"] isEqualToString:@"yes"]?@"高清优先":@"流畅优先";
        cell.detailTextLabel.font = [UIFont systemFontOfSize: 12];
        cell.detailTextLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"ProfileTableViewController.detailTextLabel.textColor"];
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"弹幕设置";
    }else{
        cell.textLabel.text = @"清空缓存";
    }
    cell.textLabel.font = [UIFont systemFontOfSize: 14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"clearCache"];
        [MBProgressHUD showMsg:@"清除成功(￣▽￣)" WithView:self.view];
    }else if (indexPath.section == 0){
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"清晰度选择" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"流畅优先",@"高清优先", nil];
        [av show];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

#pragma mark - UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"HightResolution"];
    }else if (buttonIndex == 2){
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"HightResolution"];
    }
    [self.tableView reloadData];
}

@end
