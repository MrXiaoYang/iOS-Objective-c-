//
//  BestGroupViewController.m
//  BaseProject
//
//  Created by jiyingxin on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BestGroupViewController.h"
#import "BestGroupViewModel.h"
#import "BestGroupCell.h"
#import "BestGroupDetailViewController.h"

@interface BestGroupViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) BestGroupViewModel *bestGroupVM;
@end

@implementation BestGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView.mj_header beginRefreshing];
    self.title = @"最佳阵容";
    [Factory addBackItemToVC:self];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bestGroupVM.rowNumber;
}
kRemoveCellSeparator

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 动态计算 高度
    return UITableViewAutomaticDimension;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BestGroupDetailViewController *vc = [[BestGroupDetailViewController alloc] initWithTitle:[self.bestGroupVM titleForRow:indexPath.row] desc:[self.bestGroupVM descForRow:indexPath.row] icons:[self.bestGroupVM iconURLsForRow:indexPath.row] decs:[self.bestGroupVM descsForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BestGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.titleLb.text = [self.bestGroupVM titleForRow:indexPath.row];
    cell.descLb.text =[self.bestGroupVM descForRow:indexPath.row];
    NSArray *arr = @[cell.iconView1, cell.iconView2,cell.iconView3,cell.iconView4,cell.iconView5];
    [arr enumerateObjectsUsingBlock:^(TRImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.imageView setImageWithURL:[self.bestGroupVM iconURLsForRow:indexPath.row][idx] placeholderImage:[UIImage imageNamed:@"cell_bg_noData_1"]];
    }];
    
    return cell;
}

- (BestGroupViewModel *)bestGroupVM {
	if(_bestGroupVM == nil) {
		_bestGroupVM = [[BestGroupViewModel alloc] init];
	}
	return _bestGroupVM;
}

- (UITableView *)tableView {
	if(_tableView == nil) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
           [self.bestGroupVM getDataFromNetCompleteHandle:^(NSError *error) {
               if (error) {
                   [self showErrorMsg:error.localizedDescription];
               }else{
                   [_tableView reloadData];
               }
               [_tableView.mj_header endRefreshing];
           }];
        }];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [_tableView registerClass:[BestGroupCell class] forCellReuseIdentifier:@"Cell"];
	}
	return _tableView;
}

@end
