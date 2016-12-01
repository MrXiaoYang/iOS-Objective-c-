//
//  SectionItemViewController.m
//  BiliBili
//
//  Created by apple-jd24 on 15/12/16.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SectionItemViewController.h"
#import "AVInfoViewController.h"

#import "FindViewModel.h"

#import "SectionRankTableViewCell.h"

@interface SectionItemViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView* tableView;
@property (nonatomic, strong)FindViewModel* vm;
/**
 *  判断类型为原创还是全站
 */
@property (nonatomic, strong)NSString* style;
/**
 *  区分控制区的分区
 */
@property (nonatomic, strong)NSString* section;
@end

@implementation SectionItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.mj_header = [MyRefreshComplete myRefreshHead:^{
       [self.vm refreshSection:self.section style:self.style CompleteHandle:^(NSError *error) {
           [self.tableView.mj_header endRefreshing];
           [self.tableView reloadData];
       }];
    }];
    [self.tableView.mj_header beginRefreshing];
}

kRemoveCellSeparator

#pragma mark - tableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.vm sectionCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionRankTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SectionRankTableViewCell"];
    if (cell == nil) {
        cell = [[SectionRankTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"SectionRankTableViewCell"];
    }
    [cell setWithDic: @{
                        @"coverImageView":[self.vm sectionRankCoverWithIndex: indexPath.row],
                        @"titleLabel.text":[self.vm sectionRankTitleWithIndex: indexPath.row],
                        @"UPLabel.text":[self.vm sectionRankUpNameWithIndex: indexPath.row],
                        @"playLabel.text":[self.vm sectionRankPlayCountWithIndex: indexPath.row],
                        @"danMuLabel.text":[self.vm sectionRankDanMuCountWithIndex: indexPath.row]
                        }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath: indexPath animated: YES];
    AVInfoViewController* vc = [[AVInfoViewController alloc] init];
    [vc setWithModel: [self.vm sectionModelWithIndex: indexPath.row] section: NSInvalidArgumentException];
    [self.navigationController pushViewController: vc animated:YES];
}


#pragma mark - 方法
- (instancetype)initWithSection:(NSString*)section style:(NSString*)style{
    if (self = [super init]) {
        self.section = section;
        self.style = style;
    }
    return self;
}

#pragma mark - 懒加载
- (UITableView *) tableView {
	if(_tableView == nil) {
		_tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 200;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorColor = [[ColorManager shareColorManager] colorWithString:@"separatorColor"];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [self.view addSubview: _tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
	}
	return _tableView;
}

- (FindViewModel *) vm {
	if(_vm == nil) {
		_vm = [[FindViewModel alloc] init];
	}
	return _vm;
}

@end
