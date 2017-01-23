//
//  BestGroupDetailViewController.m
//  BaseProject
//
//  Created by jiyingxin on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BestGroupDetailViewController.h"
#import "BestGroupDetailHeroCell.h"
#import "BestGroupDetailIntroCell.h"

@interface BestGroupDetailViewController ()< UITableViewDelegate, UITableViewDataSource >
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation BestGroupDetailViewController

- (id)initWithTitle:(NSString *)title desc:(NSString *)desc icons:(NSArray *)icons decs:(NSArray *)descs{
    if (self = [super init]) {
        self.title0 = title;
        self.desc = desc;
        self.icons = icons;
        self.descs = descs;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"阵容详情";
    [self.tableView reloadData];
    [Factory addBackItemToVC:self];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return _descs.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        BestGroupDetailIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntroCell"];
        cell.titleLb.text = _title0;
        cell.descLb.text = _desc;
        NSArray *arr = @[cell.iconView1, cell.iconView2,cell.iconView3,cell.iconView4,cell.iconView5];
        [arr enumerateObjectsUsingBlock:^(TRImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.imageView setImageWithURL:_icons[idx] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
        }];
        return cell;
    }else{
        BestGroupDetailHeroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeroCell"];
        [cell.iconView.imageView setImageWithURL:_icons[indexPath.row] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
        cell.introLb.text = _descs[indexPath.row];
        return cell;
    }
}
kRemoveCellSeparator
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UITableView *)tableView {
	if(_tableView == nil) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//去掉头部的section和脚步section的显示范围        
        _tableView.contentInset=UIEdgeInsetsMake(-1, 0, -10, 0);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[BestGroupDetailIntroCell class] forCellReuseIdentifier:@"IntroCell"];
        [_tableView registerClass:[BestGroupDetailHeroCell class] forCellReuseIdentifier:@"HeroCell"];
	}
	return _tableView;
}

@end
