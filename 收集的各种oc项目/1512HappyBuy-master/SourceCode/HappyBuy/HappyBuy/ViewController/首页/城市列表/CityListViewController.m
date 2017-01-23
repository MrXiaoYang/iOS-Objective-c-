//
//  CityListViewController.m
//  HappyBuy
//
//  Created by tarena on 16/3/31.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "CityListViewController.h"
#import "CityListViewModel.h"

@interface CityListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CityListViewModel *cityListVM;
@end
@implementation CityListViewController
#pragma mark - 方法
- (IBAction)dissmissVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //这一步:只是在内存中存储了当前城市
    //NSLog(@"%@", NSHomeDirectory());
    [[NSUserDefaults standardUserDefaults] setObject:[self.cityListVM titleForRowAtIndexPath:indexPath] forKey:kCurrentCityName];
    //命令立刻把内存中的plist存入沙盒
    [[NSUserDefaults standardUserDefaults] synchronize];
    //发送全局通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCurrentCityChangedNotification object:nil];
    [tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cityListVM.sectionNumber;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cityListVM rowNumberForSection:section];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.cityListVM titleForSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.cityListVM titleForRowAtIndexPath:indexPath];
    NSString *currentCity = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentCityName];
    cell.accessoryType = [currentCity isEqualToString:cell.textLabel.text] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}
//右侧索引值
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.cityListVM.indexList;
}

#pragma mark - 懒加载
- (CityListViewModel *)cityListVM{
    if (!_cityListVM) {
        _cityListVM = [CityListViewModel new];
    }
    return _cityListVM;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cityListVM getcityGroupsCompletionHandler:^(NSError *error) {
        [_tableView reloadData];
    }];
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

@end
