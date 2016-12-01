//
//  ShiBanPlayTableViewController.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/26.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ShiBanPlayTableViewController.h"
#import "ShiBanInfoViewController.h"

#import "ShiBanPlayTableViewModel.h"

@interface ShiBanPlayTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) ShiBanPlayTableViewModel *vm;
@property (nonatomic, strong) NSDictionary* weekList;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ShiBanPlayTableViewController

- (ShiBanPlayTableViewModel *)vm {
    if(_vm == nil) {
        _vm = [[ShiBanPlayTableViewModel alloc] init];
    }
    return _vm;
}

- (UIView *)headViewWithDay:(NSString*)day {
    UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 40)];
    UIImage* im = nil;
    if (![day isEqualToString:@"-1"]) {
        im = [[UIImage imageNamed:@"timeline_background"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }else{
        im = [[UIImage imageNamed:@"timeline_other_background"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    UIImageView* imv = [[UIImageView alloc] initWithImage: im];
    imv.tintColor = [[ColorManager shareColorManager] colorWithString:@"ShiBanPlayTableViewController.UIImageView.tintColor"];
    [headView addSubview: imv];
    [imv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(8);
        make.bottom.mas_offset(-8);
        make.width.mas_equalTo(imv.mas_height).multipliedBy(0.944);
    }];
    
    UILabel* numLabel = [[UILabel alloc] init];
    numLabel.font = [UIFont systemFontOfSize: 15];
    if (![day isEqualToString:@"-1"]) {
        if ([day isEqualToString:@"0"]) {
            numLabel.text = @"7";
        }else{
            numLabel.text = day;
        }
    }
    numLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"ShiBanPlayTableViewController.numLabel.textColor"];
    [headView addSubview: numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(imv);
    }];
    
    UILabel* textLabel = [[UILabel alloc] init];
    textLabel.font = [UIFont systemFontOfSize: 15];
    textLabel.text = self.weekList[day];
    textLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"ShiBanPlayTableViewController.numLabel.textColor"];
    [headView addSubview: textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView);
        make.left.mas_equalTo(imv.mas_right).mas_offset(5);
    }];
    return headView;
}

- (NSDictionary *)weekList{
    if(_weekList == nil) {
        _weekList = @{@"1":@"周一",@"2":@"周二",@"3":@"周三",@"4":@"周四",@"5":@"周五",@"6":@"周六",@"0":@"周日",@"-1":@"其它"};
    }
    return _weekList;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame: self.view.frame style: UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
        _tableView.separatorColor = [[ColorManager shareColorManager] colorWithString:@"separatorColor"];
        _tableView.mj_header = [MyRefreshComplete myRefreshHead:^{
            [self.vm refreshDataCompleteHandle:^(NSError *error) {
                [_tableView.mj_header endRefreshing];
                [_tableView reloadData];
            }];
        }];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.tableView];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.vm sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.vm episodeCountForSection: section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize: 13];
        cell.textLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        cell.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize: 11];
    }
    cell.textLabel.text = [self.vm titleForRow:indexPath.row section:indexPath.section];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"第%@话",[self.vm newEpisodeForRow:indexPath.row section:indexPath.section]];
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self headViewWithDay: [self.vm sectionTitleForSection: section]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShiBanInfoViewController* vc = [[ShiBanInfoViewController alloc] init];
    [vc setWithModel:(RecommentShinBanDataModel*)[self.vm modelForRow:indexPath.row section:indexPath.section]];
    [self.navigationController pushViewController:vc animated:YES];
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


@end
