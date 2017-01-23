//
//  SpecialViewController.m
//  BiliBili
//
//  Created by apple-jd24 on 15/12/15.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SpecialViewController.h"
#import "TakeHeadTableView.h"
#import "SpecialViewModel.h"
#import "SpecialTableViewCell.h"
#import "SpecialModel.h"
#import "AVInfoViewController.h"
#import "AVModel.h"

@interface SpecialViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)TakeHeadTableView* tableView;
@property (nonatomic, strong)UIImageView* coverImgView;
@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UILabel* browseLabel;
@property (nonatomic, strong)UILabel* favoriteLabel;
@property (nonatomic, strong)UILabel* detailLabel;
@property (nonatomic, strong)SpecialViewModel* vm;
@end

@implementation SpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.mj_header = [MyRefreshComplete myRefreshHead:^{
       [self.vm refreshDataCompleteHandle:^(NSError *error) {
           [self.tableView.mj_header endRefreshing];
           [self.tableView reloadData];
       }];
    }];
    [self setUpProperty];
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  初始化属性
 */
- (void)setUpProperty{
    [self.coverImgView setImageWithURL: [self.vm specialCover]];
    self.titleLabel.text = [self.vm specialTitle];
    self.browseLabel.text = [self.vm specialBrowse];
    self.favoriteLabel.text = [self.vm specialFaverite];
    self.detailLabel.text = [self.vm specialDetail];
}

- (instancetype)initWithModel:(SearchSpecialModel*)model{
    if (self = [super init]) {
        self.vm = [[SpecialViewModel alloc] initWithModel: model];
    }
    return self;
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.vm specialcount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SpecialTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"SpecialTableViewCell"];
    if (cell == nil) {
        cell = [[SpecialTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"SpecialTableViewCell"];
    }
    [cell setWithDic: @{
                        @"coverImageView": [self.vm episodeCoverWithIndex: indexPath.row],
                        @"titleLabel.text": [self.vm episodeTitleWithIndex: indexPath.row],
                        @"detailLabel.text": [self.vm episodeDetailWithIndex: indexPath.row]
                        }];

    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated: YES];
    AVDataModel* avModel = [[AVDataModel alloc] init];
    SpecialDateModel* spModel = [self.vm episodeWithIndex: indexPath.row];
    avModel.title = spModel.title;
    avModel.pic = spModel.cover;
    avModel.play = [spModel.click intValue];
    avModel.cid = spModel.cid;
    avModel.aid = spModel.aid;
    avModel.video_review = -1;
    AVInfoViewController* vc =[[AVInfoViewController alloc] init];
    [vc setWithModel:avModel section: nil];
    [self.navigationController pushViewController: vc animated:YES];
}


#pragma mark - 懒加载
- (TakeHeadTableView *)tableView {
	if(_tableView == nil) {
		_tableView = [[TakeHeadTableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 200;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [self.view addSubview: _tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
	}
	return _tableView;
}

- (UIImageView *)coverImgView {
	if(_coverImgView == nil) {
		_coverImgView = [[UIImageView alloc] init];
        [self.tableView.tableHeaderView addSubview: _coverImgView];
        [_coverImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(80);
            make.top.left.mas_offset(10);
        }];
	}
	return _coverImgView;
}

- (UILabel *) titleLabel {
	if(_titleLabel == nil) {
		_titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize: 15];
        _titleLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        [self.tableView.tableHeaderView addSubview: _titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.coverImgView.mas_right).mas_offset(10);
            make.top.equalTo(self.coverImgView);
            make.right.mas_offset(-10);
        }];
	}
	return _titleLabel;
}

- (UILabel *) browseLabel {
	if(_browseLabel == nil) {
		_browseLabel = [[UILabel alloc] init];
        _browseLabel.font = [UIFont systemFontOfSize: 13];
        _browseLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"assistantTextColor"];
        [self.tableView.tableHeaderView addSubview: _browseLabel];
        [_browseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(5);
            make.left.equalTo(self.titleLabel);
        }];
	}
	return _browseLabel;
}

- (UILabel *) favoriteLabel {
	if(_favoriteLabel == nil) {
		_favoriteLabel = [[UILabel alloc] init];
        _favoriteLabel.font = [UIFont systemFontOfSize: 13];
        _favoriteLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"assistantTextColor"];
        [self.tableView.tableHeaderView addSubview: _favoriteLabel];
        [_favoriteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.browseLabel.mas_bottom).mas_offset(5);
            make.left.equalTo(self.titleLabel);
        }];
	}
	return _favoriteLabel;
}

- (UILabel *) detailLabel {
	if(_detailLabel == nil) {
		_detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize: 13];
        _detailLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"assistantTextColor"];
        _detailLabel.numberOfLines = 3;
        [self.tableView.tableHeaderView addSubview: _detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.top.mas_equalTo(self.coverImgView.mas_bottom).mas_offset(10);
        }];
	}
	return _detailLabel;
}

@end
