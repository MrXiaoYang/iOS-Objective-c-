//
//  ZBCategoryViewController.m
//  BaseProject
//
//  Created by jiyingxin on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ZBCategoryViewController.h"
#import "ZBCategoryViewModel.h"
#import "ZBItemViewController.h"

@interface ZBCategoryViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ZBCategoryViewModel *categoryVM;
@end

@implementation ZBCategoryViewController

- (id)init{
    if (self = [super init]) {
        self.title = @"装备分类";
        [Factory addBackItemToVC:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView.header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (ZBCategoryViewModel *)categoryVM {
	if(_categoryVM == nil) {
		_categoryVM = [[ZBCategoryViewModel alloc] init];
	}
	return _categoryVM;
}

- (UITableView *)tableView {
	if(_tableView == nil) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
           [self.categoryVM getDataFromNetCompleteHandle:^(NSError *error) {
               if (error) {
                   [self showErrorMsg:error.localizedDescription];
               }else{
                   [_tableView reloadData];
               }
               [_tableView.header endRefreshing];
           }];
        }];
	}
	return _tableView;
}

#pragma mark - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categoryVM.rowNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.categoryVM titleForRow:indexPath.row];
    cell.accessoryType= 1;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZBItemViewController *vc = [[ZBItemViewController alloc] initWithTag:[self.categoryVM tagForRow:indexPath.row] name:[self.categoryVM titleForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
