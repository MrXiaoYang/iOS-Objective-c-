//
//  DealViewController.m
//  HappyBuy
//
//  Created by jiyingxin on 16/4/4.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "DealViewController.h"
#import "BusinessCell.h"
#import "DealViewModel.h"
#import "WebViewController.h"
#import "SortViewController.h"
#import "CategoryViewController.h"
#import "RegionViewController.h"

@interface DealViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cityBarItem;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) DealViewModel *dealVM;
@property (nonatomic) SortsModel *currentSortModel;
@property (nonatomic) NSString *currentRegion;
@property (nonatomic) NSString *currentCategory;
@end

@implementation DealViewController

#pragma mark - 方法
- (IBAction)sortBtnClicked:(UIButton *)sender {
    SortViewController *sortVC = [[SortViewController alloc] initWithSourceView:sender sourceRect:sender.bounds delegate:nil];
    sortVC.contentSize = CGSizeMake(100, 200);
    sortVC.edgeInsets = UIEdgeInsetsMake(20, 10, 20, 10);
    sortVC.chooseSortHandler = ^(SortsModel *sortModel){
        [sender setTitle:sortModel.label forState:UIControlStateNormal];
        self.currentSortModel = sortModel;
        [_tableView beginHeaderRefresh];
    };
    [self presentViewController:sortVC animated:YES completion:nil];
}


- (IBAction)regionBtnClicked:(UIButton *)sender {
    RegionViewController *regionVC = [[RegionViewController alloc] initWithSourceView:sender sourceRect:sender.bounds delegate:nil];
    regionVC.contentSize = CGSizeMake(250, 260);
    regionVC.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    regionVC.chooseRegionHandler = ^(NSString *region){
        if ([_currentRegion isEqualToString:region]) {
            return;
        }
        _currentRegion = region;
        [sender setTitle:_currentRegion forState:UIControlStateNormal];
        [_tableView beginHeaderRefresh];
    };
    [self presentViewController:regionVC animated:YES completion:nil];
}

- (IBAction)categoryBtnClicked:(UIButton *)sender {
    CategoryViewController *categoryVC = [[CategoryViewController alloc] initWithSourceView:sender sourceRect:sender.bounds delegate:nil];
    categoryVC.contentSize = CGSizeMake(230, 300);
    categoryVC.edgeInsets = UIEdgeInsetsMake(20, 10, 20, 10);
    categoryVC.chooseCategoryHandler = ^(NSString *category){
        if ([_currentCategory isEqualToString:category]) {
            return ;
        }
        _currentCategory = category;
        [sender setTitle:_currentCategory forState:UIControlStateNormal];
        [self.tableView beginHeaderRefresh];
    };
    [self presentViewController:categoryVC animated:YES completion:nil];
}

- (void)cityChanged:(NSNotification *)noti{
    self.cityBarItem.title = kCurrentCity;
}

#pragma mark - 代理UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dealVM.rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    cell.titleLb.text = [self.dealVM shopNameForIndex:row];
    [cell.iconIV setImageURL:[self.dealVM iconURLForIndex:row]];
    cell.buyNumLb.text = [self.dealVM saleNumForIndex:row];
    cell.price = [self.dealVM currentPriceForIndex:row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WebViewController *vc = [[WebViewController alloc] initWithURL:[self.dealVM dealURLForIndex:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _currentRegion = @"全部";
    _currentCategory = @"美食";
    self.cityBarItem.title = kCurrentCity;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChanged:) name:kCurrentCityChangedNotification object:nil];
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"DealCell"];
    [self.tableView addHeaderRefresh:^{
        [self.dealVM getDealWithCategory:_currentCategory sort:self.currentSortModel.value region:_currentRegion requestMode:RequestModeRefresh completionHandler:^(NSError *error) {
            [self.tableView reloadData];
            [self.tableView endHeaderRefresh];
        }];
    }];
    [self.tableView addBackFooterRefresh:^{
        [self.dealVM getDealWithCategory:_currentCategory sort:self.currentSortModel.value region:_currentRegion requestMode:RequestModeMore completionHandler:^(NSError *error) {
            [self.tableView reloadData];
            [self.tableView endFooterRefresh];
        }];
    }];
    [self.tableView beginHeaderRefresh];
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - 懒加载

- (DealViewModel *)dealVM {
    if(_dealVM == nil) {
        _dealVM = [[DealViewModel alloc] init];
    }
    return _dealVM;
}


- (SortsModel *)currentSortModel {
    if(_currentSortModel == nil) {
        _currentSortModel = [[SortsModel alloc] init];
        _currentSortModel.label = @"默认排序";
        _currentSortModel.value = 1;
    }
    return _currentSortModel;
}

@end
