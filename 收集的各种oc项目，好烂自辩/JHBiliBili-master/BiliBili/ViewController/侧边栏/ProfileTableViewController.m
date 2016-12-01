//
//  ProfileTableViewController.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/19.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "HomePageViewController.h"
#import "SettingTableViewController.h"
#import "ThemeTableViewController.h"
#import "DownLoadTableViewController.h"

#import "ProfileTableViewCell.h"

#import "ProfileHeadView.h"

@interface ProfileTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIButton* modelStyle;
@property (nonatomic, strong) ProfileHeadView* headView;
@end

@implementation ProfileTableViewController
#pragma mark - 方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.tableView];
}

- (void)colorSetting{
    self.view.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"ProfileTableViewController.view.backgroundColor"];
    self.tableView.tableHeaderView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"themeColor"];
    UIButton* button = (UIButton* _Nullable)[self.tableView.tableHeaderView viewWithTag:100];
    [button setImage:[[ColorManager shareColorManager].themeStyle isEqualToString:@"夜间模式"]?[UIImage imageNamed:@"ic_switch_night"]:[UIImage imageNamed:@"ic_switch_daily"] forState:UIControlStateNormal];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileTableViewCell *cell = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = [[ProfileTableViewCell alloc] initWithTitle:@"首页" imgName:@"ic_home_black"];
        }else if(indexPath.row == 1){
            cell = [[ProfileTableViewCell alloc] initWithTitle:@"离线管理" imgName:@"ic_file_download_black"];
        }
    }else{
        if (indexPath.row == 0) {
            cell = [[ProfileTableViewCell alloc] initWithTitle:@"主题选择" imgName:@"ic_color_lens_black"];
        }else if(indexPath.row == 1){
            cell = [[ProfileTableViewCell alloc] initWithTitle:@"设置" imgName:@"ic_settings_black"];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        //点击设置
    if(indexPath.section == 1 ){
        if (indexPath.row == 1) {
            SettingTableViewController* svc = [[SettingTableViewController alloc] init];
            [self.navigationController pushViewController: svc animated:YES];
        }else if (indexPath.row == 0){
            ThemeTableViewController* tvc = [[ThemeTableViewController alloc] init];
            [self.navigationController pushViewController: tvc animated:YES];
        }
    }else if (indexPath.section == 0){
        if (indexPath.row == 1) {
            DownLoadTableViewController* vc = [[DownLoadTableViewController alloc] init];
            [self.navigationController pushViewController: vc animated:YES];
        }
    }
    HomePageViewController*vc =(HomePageViewController*) self.parentViewController;
    [vc profileViewMoveToOriginal];
    
}

#pragma mark - 懒加载
- (UIButton *)modelStyle{
    if (_modelStyle == nil) {
        _modelStyle = [[UIButton alloc] init];
        _modelStyle.tag = 100;
        [_modelStyle setImage:[[ColorManager shareColorManager].themeStyle isEqualToString:@"夜间模式"]?[UIImage imageNamed:@"ic_switch_night"]:[UIImage imageNamed:@"ic_switch_daily"] forState:UIControlStateNormal];
        [_modelStyle addTarget:self action:@selector(modelStyleButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _modelStyle;
}

- (void)modelStyleButtonDown:(UIButton*)button{
    if ([[ColorManager shareColorManager].themeStyle isEqualToString:@"夜间模式"]) {
        [ColorManager shareColorManager].themeStyle = @"少女粉";
    }else{
        [ColorManager shareColorManager].themeStyle = @"夜间模式";
    }
    HomePageViewController*vc =(HomePageViewController*)self.parentViewController;
    [vc profileViewMoveToOriginal];
    //将模式写入userdefault
    [[NSUserDefaults standardUserDefaults] setValue:[ColorManager shareColorManager].themeStyle forKey:@"themeStyle"];
}


- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame: self.view.frame style: UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headView;
        [_tableView.tableHeaderView addSubview: self.modelStyle];
        [self.modelStyle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(20);
            make.right.mas_offset(-20);
        }];
    }
    return _tableView;
}

- (ProfileHeadView *) headView {
	if(_headView == nil) {
        _headView = [[ProfileHeadView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 0.275 *kWindowH)];
        _headView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"themeColor"];
	}
	return _headView;
}

@end
