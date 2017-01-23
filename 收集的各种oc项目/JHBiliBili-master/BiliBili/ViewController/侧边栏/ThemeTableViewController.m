//
//  ThemeTableViewController.m
//  BiliBili
//
//  Created by JimHuang on 15/11/23.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ThemeTableViewController.h"
#import "ThemeTableViewCell.h"

@interface ThemeTableViewController ()
@property (nonatomic, strong) NSArray* arr;
@end

@implementation ThemeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
}

- (instancetype)init{
    if (self = [super init]) {
        self.navigationItem.title = @"主题选择";
    }
    return self;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ThemeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ThemeTableViewCell alloc] initWithTitle:self.arr[indexPath.row] reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [ColorManager shareColorManager].themeStyle = self.arr[indexPath.row];
    [self colorSetting];
    //将模式写入userdefault
    [[NSUserDefaults standardUserDefaults] setValue:[ColorManager shareColorManager].themeStyle forKey:@"themeStyle"];
}

#pragma mark - 懒加载
- (NSArray *)arr{
    if (_arr == nil) {
        _arr = @[@"夜间模式",@"少女粉",@"姨妈红",@"咸蛋黄",@"早苗绿",@"胖次蓝",@"基佬紫"];
    }
    return _arr;
}

- (void)colorSetting{
    self.tableView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
}
@end
