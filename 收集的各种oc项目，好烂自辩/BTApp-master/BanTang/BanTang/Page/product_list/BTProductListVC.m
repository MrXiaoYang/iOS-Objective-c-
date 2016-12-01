//
//  BTProductListVC.m
//  BanTang
//
//  Created by Ryan on 15/12/2.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTProductListVC.h"
#import "BTLoadingView.h"
#import "BTHomePageManager.h"
#import "BTTopicNewInfo.h"
#import "BTProduct.h"
#import "BTProductListHeaderView.h"
#import "UINavigationBar+Awesome.h"
#import "BTSubjectSectionView.h"
#import "BTProductListCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "BTListPostLikeListVC.h"
#import "BTWebViewVC.h"
#import "BTNavigationController.h"
#import "BTUserManager.h"

#define NAVBAR_CHANGE_POINT 100
#define imageH 200

@interface BTProductListVC () <UITableViewDataSource,UITableViewDelegate,BTSubjectSectionViewDelegate,BTProductListCellDelegate>

@property (nonatomic, strong) BTTopicNewInfo *info;

/** 上面的tableView */
@property (nonatomic, strong) UITableView *topTableView;
/** 下面的tableView */
@property (nonatomic, strong) UITableView *bottomTableView;

@property (nonatomic, strong) BTLoadingView *loadingView;

@property (nonatomic, strong) BTProductListHeaderView *headerView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *topImageView;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) BTSubjectSectionView *sectionView;

/** navigationBar的alpha值 */
@property (nonatomic, assign) CGFloat navigationBarAlpha;

@end

@implementation BTProductListVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self addSubViews];
    
    [self loadData];
}

- (void)addSubViews
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"购物清单";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = BTFont(18);
    CGFloat width = [titleLabel.text titleSizeWithfontSize:18
                                                   maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    titleLabel.frame = CGRectMake(0, 0, width, 20);
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.titleView.alpha = 0.0;
    [self.navigationItem.titleView setHidden:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
	
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.topImageView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor *color = BTGobalRedColor;
    CGFloat offsetY = scrollView.contentOffset.y;
	CGFloat alpha = 0.0f;
	
    if (offsetY < 0) {
        CGFloat factor = ABS(offsetY) + 200;
        CGFloat w = kScreen_Width * factor/200;
        CGFloat x = - (w-kScreen_Width) * 0.5;
        CGFloat y = - ABS(offsetY);
        CGFloat h = factor;
        CGRect frame = CGRectMake(x,y,w,h);
        self.headerView.imageView.frame = frame;
    }

	if (offsetY > NAVBAR_CHANGE_POINT) {
		alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
	}

	[self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
	[self.navigationItem.titleView setHidden:NO];
	[self.navigationItem.titleView setAlpha:alpha];
	self.navigationBarAlpha = alpha;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[BTGobalRedColor
                                                                    colorWithAlphaComponent:self.navigationBarAlpha]];

    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
	
	[self.navigationItem.titleView setHidden:self.navigationBarAlpha == 0];
	[self.navigationItem.titleView setAlpha:self.navigationBarAlpha];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    UIImage *navBackground = [UIImage rx_captureImageWithImageName:@"nav_backgroud"];
    
    [self.navigationController.navigationBar setBackgroundImage:navBackground
                                                  forBarMetrics:UIBarMetricsDefault];
}

- (void)setupNavItem
{
    UIBarButtonItem *shareItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"btn_product_detail_share"
                                                                hltImg:@"btn_product_detail_share"
                                                                target:self
                                                                action:@selector(shareButtonDidClick)];
    
    UIBarButtonItem *collectItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"topic_collect_icon"
                                                                  hltImg:@"topic_collect_icon"
                                                                  target:self
                                                                  action:@selector(collectButtonDidClick)];
    
    self.navigationItem.rightBarButtonItems = @[shareItem,collectItem];
}

- (void)shareButtonDidClick
{
    
}

- (void)collectButtonDidClick
{
    
}

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [BTHomePageManager getTopicNewInfoWithId:self.extendID successHandler:^(BTTopicNewInfo *info) {
        [self setupNavItem];
        weakSelf.info = info;
//        [weakSelf.view addSubview:self.scrollView];
//        CGFloat scrollViewContentSizeH = weakSelf.topTableView.contentSize.height + weakSelf.bottomTableView.contentSize.height;
//        self.scrollView.contentSize = CGSizeMake(kScreen_Width, scrollViewContentSizeH);
        [weakSelf.view addSubview:weakSelf.topTableView];
//        [weakSelf.view addSubview:weakSelf.bottomTableView];
    } failureHandler:^(NSError *error) {}];
}

- (void)loadMoreData
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.50];
//    [self.scrollView setContentOffset:CGPointMake(0, kScreen_Height)];
//    [UIView commitAnimations];
    [self.topTableView.mj_footer endRefreshing];
}

#pragma mark - tableView Datasource && Delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BTSubjectSectionView * sectionView = [BTSubjectSectionView sectionView];
    sectionView.titleArray = @[@"半糖精选",@"用户推荐"];
    sectionView.delegate = self;
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"productListCell" cacheByIndexPath:indexPath configuration:^(BTProductListCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.info.product.count;
}

- (void)configureCell:(BTProductListCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    cell.delegate = self;
    cell.tag = indexPath.row;
    cell.userAvatrHost = self.info.userAvatrHost;
    cell.productPicHost = self.info.productPicHost;
    cell.product = self.info.product[indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTProductListCell *cell = [BTProductListCell cellWithTableView:tableView];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - BTSubjectSectionViewDelegate
- (void)sectionView:(BTSubjectSectionView *)sectionView didClickIndexButton:(NSInteger)index
{
    
}

#pragma mark - BTProductListCellDelegate
// 点击了第几张图片
- (void)productListCell:(BTProductListCell *)listCell didClickPicWithIndex:(NSInteger)index
{
    
}

// 点击了喜欢的人的头像
- (void)productListCell:(BTProductListCell *)listCell didClickLikerUserIcon:(BTProductLiker *)liker
{
    
}

// 点击了评论
- (void)productListCell:(BTProductListCell *)listCell didClickComment:(BTProduct *)product
{
    
}

// 点击了喜欢
- (void)productListCell:(BTProductListCell *)listCell didClickLike:(BTProduct *)product
{
    BOOL boolean = !product.islike;
    [listCell setLike:boolean];
    
    if (!boolean) {  // 已经收藏,需要调用取消收藏
        [BTUserManager unlikeSubjectWithID:[product.ID integerValue] successHandler:^(BOOL result) {
            if (result) {
                NSLog(@"取消收藏成功");
            }
        } failureHandler:nil];
    }else{ // 未收藏,调用收藏接口
        [BTUserManager likeSubjectWithID:[product.ID integerValue] boxID:0 categoryID:product.categoryId successHandler:^(BOOL result) {
            if (result) {
                NSLog(@"收藏成功");
            }
        } failureHandler:nil];
    }
}

// 点击了购买
- (void)productListCell:(BTProductListCell *)listCell didClickBuy:(BTProduct *)product
{
    BTWebViewVC *webViewVC = [[BTWebViewVC alloc] init];
    webViewVC.title = @"宝贝详情";
    webViewVC.url = product.url;
    webViewVC.isModalStyle = YES;
    [self presentViewController:[[BTNavigationController alloc] initWithRootViewController:webViewVC] animated:YES completion:nil];
}

// 点击了箭头
- (void)productListCell:(BTProductListCell *)listCell didClickArrowIcon:(BTProduct *)product
{
    BTListPostLikeListVC *likeListVC = [[BTListPostLikeListVC alloc] init];
    likeListVC.extendID = product.ID;
    [self.navigationController pushViewController:likeListVC animated:YES];
}

#pragma mark - getter Method
- (UITableView *)topTableView
{
    if (!_topTableView) {
        _topTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
        
        [_topTableView registerClass:[BTProductListCell class] forCellReuseIdentifier:@"productListCell"];
        _topTableView.top += kScreen_Height;
        _topTableView.delegate = self;
        _topTableView.dataSource = self;
        _topTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _topTableView.tableHeaderView = self.headerView;
        _topTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                                 refreshingAction:@selector(loadMoreData)];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"" forState:MJRefreshStateRefreshing];
        [footer setRefreshingTitleHidden:YES];
        _topTableView.mj_footer = footer;
        _topTableView.tableFooterView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_topic_collection_footer"]];
        
        [UIView animateWithDuration:0.50 animations:^{
            _topTableView.top -= (kScreen_Height);
        } completion:^(BOOL finished) {
            _topImageView.alpha = 0.0;
            _headerView.imageView.alpha = 1.0f;
        }];
    }
    return _topTableView;
}

- (BTProductListHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[BTProductListHeaderView alloc] init];
        _headerView.info = self.info;
        _headerView.frame = CGRectMake(0, 0, kScreen_Width,_headerView.headerHeight);
    }
    return _headerView;
}

- (BTLoadingView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [BTLoadingView loadingViewToView:self.view];
        [_loadingView startAnimation];
    }
    return _loadingView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.top += kScreen_Height;
        _scrollView.contentSize = CGSizeMake(kScreen_Width, 1000);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.tag = 101;
        [_scrollView addSubview:self.topTableView];
        [_scrollView addSubview:self.bottomTableView];
        [UIView animateWithDuration:0.50 animations:^{
            _scrollView.top -= kScreen_Height;
        } completion:^(BOOL finished) {
            [_headerView show];
            _topImageView.alpha = 0.0;
        }];
    }
    return _scrollView;
}

- (UIImageView *)topImageView
{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.frame = CGRectMake(0, 0, kScreen_Width, imageH);
//        _topImageView = [[UIImageView alloc] initWithImage:self.image];
//        _topImageView.contentMode = UIViewContentModeScaleAspectFill;
//        _topImageView.userInteractionEnabled = NO;
//        _topImageView.frame = CGRectMake(0,self.startHeight, kScreen_Width, imageH);
//        _topImageView.alpha = 0.0;
//        [UIView animateWithDuration:0.05 animations:^{
//            _topImageView.alpha = 1.0f;
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.60 animations:^{
//                _topImageView.frame = CGRectMake(0, 0, kScreen_Width, imageH);
//            }];
//        }];
    }
    return _topImageView;
}

- (UITableView *)bottomTableView
{
    if (!_bottomTableView) {
        _bottomTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                     style:UITableViewStylePlain];
       [_bottomTableView registerClass:[BTProductListCell class] forCellReuseIdentifier:@"productListCell"];
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        _bottomTableView.rowHeight = 44;
        _bottomTableView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height);
        
        //设置UIWebView 有下拉操作
        _bottomTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //下拉执行对应的操作
            self.scrollView.contentOffset = CGPointMake(0, 0);
            //结束加载
            [_bottomTableView.mj_header endRefreshing];
        }];
    }
    return _bottomTableView;
}

- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)dealloc
{
    NSLog(@"dealloc");
}


- (UIImageView *)transitionSourceImageView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.topImageView.image];
    imageView.contentMode = self.topImageView.contentMode;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    imageView.frame = self.topImageView.frame;
    return imageView;
}

- (UIColor *)transitionSourceBackgroundColor
{
    return self.view.backgroundColor;
}

- (CGRect)transitionDestinationImageViewFrame
{
    return self.topImageView.frame;
}

#pragma mark - <RMPZoomTransitionDelegate>

- (void)zoomTransitionAnimator:(RMPZoomTransitionAnimator *)animator
         didCompleteTransition:(BOOL)didComplete
      animatingSourceImageView:(UIImageView *)imageView
{
    self.topImageView.image = imageView.image;
}
@end
