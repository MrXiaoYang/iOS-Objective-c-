//
//  FindViewController.m
//  BiliBili
//
//  Created by apple-jd44 on 15/10/31.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "FindViewController.h"
#import "SearchViewController.h"
#import "SectionViewController.h"
#import "SectionItemViewController.h"

#import "TakeHeadTableView.h"
#import "HotSearchButton.h"
#import "HotSearchTableViewCell.h"

#import "FindViewModel.h"

#import "UIImage+Tools.h"

#define EDGE 12

@interface FindViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) FindViewModel* vm;

@property (strong, nonatomic) TakeHeadTableView *tableView;
@property (strong, nonatomic) UIButton *allSectionRangeButton;
@property (strong, nonatomic) UIButton *originateRangeButton;

@property (strong, nonatomic) HotSearchButton *hotSearchLeftButton;
@property (strong, nonatomic) HotSearchButton *hotSearchRightButton;
@property (strong, nonatomic) UILabel *allViewLabel;

@property (nonatomic, strong) UIImage* upImg;
@property (nonatomic, strong) UIImage* downImg;
@property (nonatomic, strong) UIImage* keepImg;
@end

@implementation FindViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tableView.mj_header endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //为了调用懒加载而已
    self.allSectionRangeButton.hidden = NO;
    self.allViewLabel.text = @"大家都在搜";
    self.hotSearchRightButton.hidden = NO;
    
    self.tableView.mj_header = [MyRefreshComplete myRefreshHead:^{
        [self.vm refreshDataCompleteHandle:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
            
            [self.hotSearchLeftButton setBackgroundImageForState:UIControlStateNormal withURL:[self.vm rankCoverForNum:0]];
            [self.hotSearchRightButton setBackgroundImageForState:UIControlStateNormal withURL:[self.vm rankCoverForNum:1]];
            [self.hotSearchLeftButton setNeedsDisplay];
            [self.hotSearchRightButton setNeedsDisplay];
            self.hotSearchLeftButton.label.text = [self.vm coverKeyWordForNum:0];
            self.hotSearchRightButton.label.text = [self.vm coverKeyWordForNum:1];
            
            [self.tableView reloadData];
            if (error) [MBProgressHUD showMsg:kerrorMessage WithView:self.view];
        }];
    }];

    [self.tableView.mj_header beginRefreshing];
}



# pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.vm rankArrConut];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotSearchTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"fvcell"];
    if (cell == nil) {
        cell = [[HotSearchTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"fvcell"];
        cell.textLabel.font = [UIFont systemFontOfSize: 14];
        cell.backgroundColor = [UIColor clearColor];
    }
    [cell setWithRank:indexPath keyWord:[self.vm keyWordForRow: indexPath.row] state:[self.vm statusWordForRow:indexPath.row]];
    return cell;
}

# pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[[SearchViewController alloc] initWithkeyWord: [[self.vm keyWordForRow: indexPath.row] stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLHostAllowedCharacterSet]]] animated:YES];
}

# pragma mark - 方法
- (void)colorSetting{
    self.allViewLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
    self.tableView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
    [self.tableView reloadData];
}

/**
 *  点击热搜按钮
 */
- (void)searchButtonDown:(HotSearchButton*)button{
    [self.navigationController pushViewController: [[SearchViewController alloc] initWithkeyWord: [button.label.text stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLHostAllowedCharacterSet]]] animated:YES];
}

/**
 *  点击全区排行按钮
 */
- (void)allSectionRangeButtonDown:(UIButton*)button{
    NSMutableArray* controllerArr = [NSMutableArray array];
    NSArray* tempArr = @[@"全站",@"动画",@"音乐",@"舞蹈",@"游戏",@"科技",@"娱乐",@"鬼畜",@"电影",@"电视剧",@"时尚"];
    [tempArr enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [controllerArr addObject: [[SectionItemViewController alloc] initWithSection: obj style: @"allSection"]];
    }];
    [self.navigationController pushViewController:[[SectionViewController alloc] initWithControllers:controllerArr titles: tempArr style: @"全区排行"] animated:YES];
}

- (void)originateRangeButtonDown:(UIButton*)button{
    NSMutableArray* controllerArr = [NSMutableArray array];
    NSArray* tempArr = @[@"全站",@"番剧"];
    [tempArr enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [controllerArr addObject: [[SectionItemViewController alloc] initWithSection: obj style: @"origin"]];
    }];
    [self.navigationController pushViewController:[[SectionViewController alloc] initWithControllers:controllerArr titles: tempArr style:@"原创排行"] animated:YES];
}

#pragma mark - 懒加载
- (TakeHeadTableView *)tableView {
	if(_tableView == nil) {
		_tableView = [[TakeHeadTableView alloc] initWithHeadHeight:kWindowW * 0.7];
        _tableView.delegate = self;
        _tableView.dataSource = self;
	}
	return _tableView;
}

/**
 *  全区排行按钮
 *
 */
- (UIButton *)allSectionRangeButton {
	if(_allSectionRangeButton == nil) {
		_allSectionRangeButton = [[UIButton alloc] init];
        [_allSectionRangeButton setBackgroundImage:[UIImage imageNamed:@"763b819c9a7dc5e09368a96e5c8d75da"] forState:UIControlStateNormal];
        [_allSectionRangeButton addTarget:self action:@selector(allSectionRangeButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView.tableHeaderView addSubview: _allSectionRangeButton];
        [_allSectionRangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(EDGE);
            make.height.mas_equalTo(_allSectionRangeButton.mas_width).multipliedBy(0.46);
            make.size.equalTo(self.originateRangeButton);
        }];
	}
	return _allSectionRangeButton;
}

/**
 *  原创排行按钮
 *
 */
- (UIButton *)originateRangeButton {
	if(_originateRangeButton == nil) {
		_originateRangeButton = [[UIButton alloc] init];
        [_originateRangeButton setBackgroundImage:[UIImage imageNamed:@"83899f035f7a3ec866a77478773b5f48"] forState:UIControlStateNormal];
        [_originateRangeButton addTarget:self action:@selector(originateRangeButtonDown:) forControlEvents: UIControlEventTouchUpInside];
        [self.tableView.tableHeaderView addSubview: _originateRangeButton];
        [_originateRangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.allSectionRangeButton);
            make.left.mas_equalTo(self.allSectionRangeButton.mas_right).mas_offset(EDGE);
            make.right.mas_offset(-EDGE);
        }];
	}
	return _originateRangeButton;
}

- (HotSearchButton *)hotSearchLeftButton {
	if(_hotSearchLeftButton == nil) {
		_hotSearchLeftButton = [[HotSearchButton alloc] initWithKeyWord:[self.vm coverKeyWordForNum:0]];
        [_hotSearchLeftButton setBackgroundImageForState:UIControlStateNormal withURL:[self.vm rankCoverForNum:0]];
        [_hotSearchLeftButton addTarget: self action:@selector(searchButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView.tableHeaderView addSubview: _hotSearchLeftButton];
        [_hotSearchLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.allViewLabel.mas_bottom).mas_offset(EDGE);
            make.left.equalTo(self.allViewLabel);
            make.height.mas_equalTo(_hotSearchLeftButton.mas_width).multipliedBy(0.63);
            make.size.equalTo(self.hotSearchRightButton);
        }];
	}
	return _hotSearchLeftButton;
}

- (HotSearchButton *)hotSearchRightButton {
	if(_hotSearchRightButton == nil) {
		_hotSearchRightButton = [[HotSearchButton alloc] initWithKeyWord:[self.vm coverKeyWordForNum:1]];
         [_hotSearchRightButton setBackgroundImageForState:UIControlStateNormal withURL:[self.vm rankCoverForNum:1]];
        [_hotSearchRightButton addTarget: self action:@selector(searchButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView.tableHeaderView addSubview: _hotSearchRightButton];
        [_hotSearchRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.hotSearchLeftButton.mas_right).mas_offset(EDGE);
            make.top.equalTo(self.hotSearchLeftButton);
            make.right.mas_offset(-EDGE);
        }];
	}
	return _hotSearchRightButton;
}

- (UILabel *)allViewLabel {
	if(_allViewLabel == nil) {
		_allViewLabel = [[UILabel alloc] init];
        _allViewLabel.font = [UIFont systemFontOfSize: 13];
        [self.tableView.tableHeaderView addSubview: _allViewLabel];
        [_allViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.allSectionRangeButton.mas_bottom).mas_offset(EDGE);
            make.left.equalTo(self.allSectionRangeButton);
        }];
	}
	return _allViewLabel;
}

- (FindViewModel *)vm{
    if (_vm == nil) {
        _vm = [[FindViewModel alloc] init];
    }
    return _vm;
}

- (UIImage *)upImg{
    if (_upImg == nil) {
        _upImg = [[UIImage imageNamed:@"search_icon"] clipImageWithRect:CGRectMake(0, 0, 7, 10)];
    }
    return _upImg;
}

- (UIImage *)downImg{
    if (_downImg == nil) {
        _downImg = [[UIImage imageNamed:@"search_icon"] clipImageWithRect:CGRectMake(10, 0, 7, 10)];
    }
    return _downImg;
}

- (UIImage *)keepImg{
    if (_keepImg == nil) {
        _keepImg = [[UIImage imageNamed:@"search_icon"] clipImageWithRect:CGRectMake(20, 0, 7, 10)];
    }
    return _keepImg;
}

@end
