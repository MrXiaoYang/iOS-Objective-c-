//
//  BTHomeVC.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTHomeVC.h"
#import "BTHomePageManager.h"
#import "BTHomePageHeaderView.h"
#import "BTHomeBanner.h"
#import "BTHomeTopicCell.h"
#import "UIScrollView+PullToRefreshCoreText.h"
#import <MJRefresh.h>
#import "BTLoadingView.h"
#import "BTTopicListVC.h"
#import "BTEntryList.h"
#import "BTSubjectVC.h"
#import "BTWebViewVC.h"
#import "UINavigationBar+Awesome.h"
#import "BTNavigationController.h"
#import "BTSubscribeVC.h"
#import "BTNoHLbutton.h"
#import "BTHomeTopic.h"
#import "BTProductListVC.h"
#import "BTDataBaseManager.h"
#import "BTPageLoadFooterView.h"
#import "BTZoomTransitionAnimator.h"

#define NAVBAR_CHANGE_POINT 50
@interface BTHomeVC() <UITableViewDataSource,UITableViewDelegate,BTHomePageHeaderViewDelegate>
/** headerView */
@property (nonatomic, strong) BTHomePageHeaderView *headerView;
/** homePageData */
@property (nonatomic, strong) BTHomePageData *homePageData;

/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 表格列表数据源 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 加载LoadingView */
@property (nonatomic, strong) BTLoadingView *loadingView;
/** footerView */
@property (nonatomic, strong) BTPageLoadFooterView *footerView;
/** 是否完成加载数据 */
@property (nonatomic, assign) BOOL finishedLoadedData;
/** navigationBar的alpha值 */
@property (nonatomic, assign) CGFloat navigationBarAlpha;

@end

@implementation BTHomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSubViews];
    
    [self loadDataFromStart:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.navigationController.navigationBar setBackgroundImage:[UIImage new]
												  forBarMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];

	[self.navigationController.navigationBar lt_setBackgroundColor:[BTGobalRedColor
																	colorWithAlphaComponent:self.navigationBarAlpha]];
	
	if (self.navigationBarAlpha==0) {
		[self.navigationItem.titleView setHidden:YES];
		[self.navigationItem.leftBarButtonItem.customView setHidden:YES];
		[self.navigationItem.rightBarButtonItem.customView setHidden:YES];
	}
	
	[self.navigationItem.titleView setAlpha:self.navigationBarAlpha];
	[self.navigationItem.leftBarButtonItem.customView setAlpha:self.navigationBarAlpha];
	[self.navigationItem.rightBarButtonItem.customView setAlpha:self.navigationBarAlpha];
}

- (void)setupSubViews
{
	self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nar_logo"]];
	self.navigationItem.leftBarButtonItem =  [UIBarButtonItem rx_barBtnItemWithNmlImg:@"home_search_icon"
																			   hltImg:@"home_search_icon"
																			   target:self
																			   action:@selector(searchBtnClick)];
	
	self.navigationItem.rightBarButtonItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"sign_bar_icon"
																			   hltImg:@"sign_bar_icon"
																			   target:self
																			   action:@selector(signBtnClick)];
	[self.navigationItem.titleView setAlpha:0.0];
	[self.navigationItem.leftBarButtonItem.customView setAlpha:0.0];
	[self.navigationItem.rightBarButtonItem.customView setAlpha:0.0];
	
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.loadingView];
    
    __weak typeof(self) weakSelf = self;
    self.footerView = [BTPageLoadFooterView footerWithRefreshingBlock:^{
        [weakSelf loadDataFromStart:NO];
    }];
    self.footerView.frame = CGRectMake(0, 0, kScreen_Width, 44);
    self.tableView.tableFooterView = self.footerView;
    
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
    
    [BTHomePageManager getHomePageDataWithPage:self.page successHandler:^(BTHomePageData *pageData) {
        [[BTDataBaseManager shareInstance] insertHomePageDataToDB:pageData page:self.page];
        [self hideLoading];
        if (boolean) {
            [self.dataArray removeAllObjects];
            self.homePageData = pageData;
            self.headerView.imagesArray = pageData.banner;
            self.headerView.entryListArray = pageData.entryList;
        }
        
        if (pageData.topic.count == 0)  return;
        
        self.finishedLoadedData = pageData.topic.count < 10;
        [self.dataArray addObjectsFromArray:pageData.topic];
        [self.tableView setHidden:NO];
        [self.tableView reloadData];
        self.page++;
    } failureHandler:^(NSError *error) {
        [self hideLoading];
    }];
}

- (void)hideLoading
{
    [self.loadingView hideAnimation];
    [self.tableView finishLoading];
    [self.footerView endRefreshing];
}
#pragma mark - event responseder
- (void)searchBtnClick
{
	NSLog(@"searchBtnClick");
}

- (void)signBtnClick
{
	NSLog(@"signBtnClick");
}

#pragma mark - tableView DataSource && tableView Delegate
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
	BTHomeTopic *topic = self.dataArray[indexPath.row];
	BTProductListVC *productListVC = [[BTProductListVC alloc] init];
	productListVC.extendID = [NSString stringWithFormat:@"%zd",topic.tid];
	[self.navigationController pushViewController:productListVC animated:YES];
}
// 用于加载更多
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataArray.count - 1) {
        if (self.finishedLoadedData) return;
        [self.footerView startRefreshing];
    }
}

#pragma mark - BTHomePageHeaderViewDelegate
- (void)headerView:(BTHomePageHeaderView *)headerView didClickBannerViewWithIndex:(NSInteger)index
{
    BTHomeBanner *banner = self.homePageData.banner[index];
    if (![banner.type isEqualToString:@"webview"]) {
        BTTopicListVC *listVC = [[BTTopicListVC alloc] init];
        listVC.extend = banner.extend;
        listVC.title = banner.title;
        [self.navigationController pushViewController:listVC animated:YES];
    }else if ([banner.type isEqualToString:@"webview"])
    {
        BTWebViewVC *webViewVC = [[BTWebViewVC alloc] init];
        webViewVC.url = banner.extend;
        webViewVC.title = banner.title;
        webViewVC.isModalStyle = NO;
        [self.navigationController pushViewController:webViewVC animated:YES];
    }
}

- (void)headerView:(BTHomePageHeaderView *)headerView didClickEntryListWithIndex:(NSInteger)index
{
    BTEntryList *entryList = self.homePageData.entryList[index];
    BTSubjectVC *subjectVC = [[BTSubjectVC alloc] init];
    if (entryList.extend.length) {
        subjectVC.extendId = [entryList.extend integerValue];
        [self.navigationController pushViewController:subjectVC animated:YES];
    }
}

- (void)headerViewDidClickLeftButton:(BTHomePageHeaderView *)headerView
{
    BTSubscribeVC *subscribeVC = [[BTSubscribeVC alloc] init];
    [self.navigationController pushViewController:subscribeVC animated:YES];
}

- (void)headerViewDidClickRightButton:(BTHomePageHeaderView *)headerView
{
    
}
#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 100开始显示
    // 180显示完全
	CGFloat offsetY = scrollView.contentOffset.y;
	CGFloat alpha = 0;
	
	if (offsetY > NAVBAR_CHANGE_POINT) {
		alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
	}
	
	if (alpha>0) {
		[self.navigationItem.titleView setHidden:NO];
		[self.navigationItem.leftBarButtonItem.customView setHidden:NO];
		[self.navigationItem.rightBarButtonItem.customView setHidden:NO];
	}
	
	[self.navigationController.navigationBar lt_setBackgroundColor:[BTGobalRedColor colorWithAlphaComponent:alpha]];
	[self.navigationItem.titleView setAlpha:alpha];
	[self.navigationItem.leftBarButtonItem.customView setAlpha:alpha];
	[self.navigationItem.rightBarButtonItem.customView setAlpha:alpha];
	self.navigationBarAlpha = alpha;
}

#pragma mark - getter Method
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.rowHeight = 264;
        _tableView.height -= 49;
        _tableView.tableHeaderView = self.headerView;
        [_tableView setHidden:YES];
    }
    return _tableView;
}

- (BTHomePageHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[BTHomePageHeaderView alloc] initWithBannerImagesArray:nil
                                                               entryListArray:self.homePageData.entryList];
        _headerView.frame = CGRectMake(0, 0, kScreen_Width, 308);
        _headerView.delegate = self;
        [self.view addSubview:_headerView];
    }
    return _headerView;
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
    if (!_loadingView) {
        _loadingView = [BTLoadingView loadingViewToView:self.view];
        [_loadingView startAnimation];
    }
    return _loadingView;
}
@end
