//
//  BTTopicListVC.m
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTTopicListVC.h"
#import "BTLoadingView.h"
#import "BTHomeTopicCell.h"
#import "BTHomePageManager.h"
#import <MJRefresh.h>
#import "UIScrollView+PullToRefreshCoreText.h"
#import "BTProductListVC.h"
#import "BTHomeTopic.h"

@interface BTTopicListVC ()  <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) BTLoadingView *loadingView;

@end

@implementation BTTopicListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSubViews];
    
    [self loadDataFromStart:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.navigationController.navigationBar setBackgroundImage:[UIImage rx_captureImageWithImageName:@"nav_backgroud"]
												  forBarMetrics:UIBarMetricsDefault];
}

- (void)setupSubViews
{
    self.view.backgroundColor = [UIColor whiteColor];
	self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.loadingView];
    __weak typeof(self) weakSelf = self;
	
    [self.tableView addPullToRefreshWithPullText:@"C'est La Vie"
                                   pullTextColor:kUIColorFromRGB(0xcb6e76)
                                    pullTextFont:DefaultTextFont
                                  refreshingText:@"La Vie est belle"
                             refreshingTextColor:[UIColor purpleColor]
                              refreshingTextFont:DefaultTextFont action:^{
                                  [weakSelf loadDataFromStart:YES];
                              }];
}


- (void)loadDataFromStart:(BOOL)boolean
{
    if (boolean) self.page = 0;
	
	__weak typeof(self)weakSelf = self;
	
    [BTHomePageManager getTopicListWithPage:self.page extend:self.extend successHandler:^(NSArray *topicList) {
        [weakSelf.tableView finishLoading];
        if (boolean) {
            [weakSelf.tableView setHidden:NO];
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.loadingView hideAnimation];
        }
        [weakSelf.dataArray addObjectsFromArray:topicList];
        [weakSelf.tableView reloadData];
        weakSelf.page++;
		[weakSelf.tableView.tableFooterView setHidden:NO];
    } failureHandler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTHomeTopicCell *cell = [BTHomeTopicCell cellWithTableView:tableView];
    cell.topic = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTHomeTopicCell *cell = [tableView cellForRowAtIndexPath:indexPath];

	BTHomeTopic *topic = self.dataArray[indexPath.row];
	BTProductListVC *productListVC = [[BTProductListVC alloc] init];
	CGFloat cellY = cell.frame.origin.y;
	productListVC.startHeight = cellY - self.tableView.contentOffset.y;
	productListVC.extendID = [NSString stringWithFormat:@"%zd",topic.tid];
	productListVC.image = cell.iconView.image;
	[self.navigationController pushViewController:productListVC animated:NO];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64)
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.rowHeight = 264;
		
		UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bottom_logo"]];
		imageView.contentMode = UIViewContentModeCenter;
		imageView.frame = CGRectMake(0, 0, 181, 32);
		_tableView.tableFooterView = imageView;
		[_tableView.tableFooterView setHidden:YES];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (BTLoadingView *)loadingView
{
    if (!_loadingView)
    {
        _loadingView = [BTLoadingView loadingViewToView:self.view];
        [_loadingView startAnimation];
    }
    return _loadingView;
}


@end
