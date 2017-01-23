//
//  BTSubjectVC.m
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTSubjectVC.h"
#import "BTHomePageManager.h"
#import "BTCommunitySubject.h"
#import "BTSubjectHeaderView.h"
#import "BTSubjectBottomView.h"
#import "BTLoadingView.h"
#import "BTSubjectSectionView.h"
#import "BTListPost.h"
#import "BTSubjectListPostCell.h"
#import "BTSubjectAuthor.h"
#import "BTUserManager.h"
#import "BTListPostDynamic.h"
#import "BTSubjectRankListVC.h"
#import "BTSubjectDynamic.h"
#import "BTBaseRequestParmas.h"
#import "BTSubjectListPostParams.h"
#import "BTListPostInfoVC.h"
#import "BTProduct.h"
#import "BTNavigationController.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "BTWebViewVC.h"
#import "BTPageLoadFooterView.h"

@interface BTSubjectVC () <UITableViewDataSource,
                           UITableViewDelegate,
                           BTSubjectSectionViewDelegate,
                           BTSubjectListPostCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) BTLoadingView *loadingView;

@property (nonatomic, strong) BTSubjectHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) BTSubjectBottomView *bottomView;

@property (nonatomic, copy) NSString *lastId;

@property (nonatomic, strong) BTCommunitySubject *subject;

@property (nonatomic, copy) NSString *selectedTypeId;

@property (nonatomic, strong) NSMutableArray *frameArray;

@property (nonatomic, strong) BTPageLoadFooterView *footerView;

@property (nonatomic, assign) BOOL finishedLoadedData;

@end

@implementation BTSubjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadHeaderData];
    
    [self loadDataFromStart:YES typeId:@"0" shouldScrollToTop:NO];
    
    [self setupNavItem];
    
    [self setupSubViews];
    
    [self addNotification];
}

- (void)setupNavItem
{
    self.view.backgroundColor = kUIColorFromRGB(0xf8f8f8);
    
    self.title = @"本期话题";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *shareItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"share_item_icon"
                                                                hltImg:@"share_item_icon"
                                                                target:self
                                                                action:@selector(shareItemDidClick)];
    self.navigationItem.rightBarButtonItem = shareItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage rx_captureImageWithImageName:@"nav_backgroud"]
                                                  forBarMetrics:UIBarMetricsDefault];
}

- (void)shareItemDidClick
{
    
}

- (void)loadHeaderData
{
    // 加载tableViewHeader的数据
    [BTHomePageManager getSubjectWithID:self.extendId successHandler:^(BTCommunitySubject *subject) {
        [self.loadingView hideAnimation];
        self.headerView.subject = subject;
        [self.tableView setHidden:NO];
        self.subject = subject;
    } failureHandler:^(NSError *error) {
        [self.loadingView hideAnimation];
    }];
}

- (void)setupSubViews
{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.loadingView];
    [self.view addSubview:self.bottomView];
    [self.tableView setHidden:YES];
    
    // 设置footerRefresh
    __weak typeof(self) weakSelf = self;
   
    // 设置headerRefresh
    [self.tableView addPullToRefreshWithPullText:@"C'est La Vie"
                                   pullTextColor:kUIColorFromRGB(0xcb6e76)
                                    pullTextFont:DefaultTextFont
                                  refreshingText:@"La Vie est belle"
                             refreshingTextColor:[UIColor blueColor]
                              refreshingTextFont:DefaultTextFont action:^{
                                  [weakSelf loadDataFromStart:YES
                                                       typeId:weakSelf.selectedTypeId
                                            shouldScrollToTop:NO];
                              }];

}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tableViewReloadData:)
                                                 name:NOTI_UPDATE_SUBJECT_VC_DATA
                                               object:nil];
}

- (void)tableViewReloadData:(NSNotification *)notification
{
    NSNumber *num = notification.object;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[num integerValue] inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)loadDataFromStart:(BOOL)boolean typeId:(NSString *)typeId shouldScrollToTop:(BOOL)scrollBoolean
{
    if (boolean) self.page = 0;
    
    // 加载listPost的数据
    NSString *subjectId = [NSString stringWithFormat:@"%zd",self.extendId];
    BTSubjectListPostParams *params = [BTSubjectListPostParams paramsWithTypeId:typeId
                                                                       sujectId:subjectId
                                                                         lastId:self.lastId
                                                                           page:self.page
                                                                       pagesize:10];
    
    [BTHomePageManager getListPostWithListPostParams:params successHandler:^(NSArray *listPostArray) {
        [self.loadingView hideAnimation];
        [self.footerView endRefreshing];
        [self.tableView finishLoading];
        self.view.userInteractionEnabled = YES;
        
        if (listPostArray.count == 0)  return;
    
        self.finishedLoadedData = listPostArray.count < 10;
        
        if (boolean) [self.dataArray removeAllObjects];
        
        [self.dataArray addObjectsFromArray:listPostArray];
        
        [self.tableView reloadData];
        
        if (scrollBoolean) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                  atScrollPosition:UITableViewScrollPositionTop
                                          animated:YES];
        }
        
        BTListPost *listPost = [self.dataArray lastObject];
        self.lastId = listPost.ID;
        self.page++;
        
    } failureHandler:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        [self.footerView endRefreshing];
        [self.tableView finishLoading];
        [self.loadingView hideAnimation];
    }];
}
#pragma mark - tableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"subjectListPostCell" cacheByIndexPath:indexPath configuration:^(BTSubjectListPostCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

- (void)configureCell:(BTSubjectListPostCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    BTListPost *listPost = self.dataArray[indexPath.row];
    cell.tag = indexPath.row;
    cell.listPost = listPost;
    cell.delegate = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTSubjectListPostCell *cell = [BTSubjectListPostCell cellWithTableView:tableView];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BTListPost *listPost = self.dataArray[indexPath.row];
    BTListPostInfoVC *infoVC = [[BTListPostInfoVC alloc] init];
    infoVC.indexPathRow = indexPath.row;
    infoVC.extendId = listPost.ID;
    infoVC.dynamic = listPost.dynamic;
    [self.navigationController pushViewController:infoVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BTSubjectSectionView *sectionView = [BTSubjectSectionView sectionView];
    sectionView.delegate = self;
    sectionView.currentSelctedNum = [self.selectedTypeId integerValue];
    sectionView.frame = CGRectMake(0, 0, kScreen_Width, 44);
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

#pragma mark - BTSubjectSectionViewDelegate
- (void)sectionView:(BTSubjectSectionView *)sectionView didClickIndexButton:(NSInteger)index
{
    self.view.userInteractionEnabled = NO;
    NSLog(@"点击了第%zd个",index);
    [self.dataArray removeAllObjects];
    if (index == 100) {
        self.selectedTypeId = @"0";
    }else{
        self.selectedTypeId = @"1";
    }
    [self loadDataFromStart:YES typeId:self.selectedTypeId shouldScrollToTop:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.dataArray.count - 1) {
        if (self.finishedLoadedData)
        {
            self.tableView.tableFooterView = nil;
            return;
        }
        __weak typeof(self) weakSelf = self;
        BTPageLoadFooterView *footerView = [BTPageLoadFooterView footerWithRefreshingBlock:^{
            [weakSelf loadDataFromStart:NO
                                 typeId:weakSelf.selectedTypeId
                      shouldScrollToTop:NO];
        }];
        self.footerView = footerView;
        footerView.frame = CGRectMake(0, 0, kScreen_Width, 44);
        self.tableView.tableFooterView = footerView;
        [footerView startRefreshing];
    }
}

#pragma mark - BTSubjectListPostCellDelegate
// 点击了关注按钮
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickAttentionButtonWithIndex:(NSInteger)index
{
    BTListPost *listPost = self.dataArray[index];
    if (listPost.author.attentionType == 0) { // 未关注状态,需要调用关注接口
        [BTUserManager followUserWithFriendId:listPost.authorId success:^{
            //关注成功,更新按钮的图片
            [listPostCell setAttention:YES];
            listPost.author.attentionType = 1;
            
        } failure:nil];
    }else if (listPost.author.attentionType == 1){ // 关注状态,需要调用取消关注接口
        [BTUserManager unfollowUserWithFriendId:listPost.authorId success:^(BOOL success) {
            if (success) { // 取消关注成功
                [listPostCell setAttention:NO];
                listPost.author.attentionType = 0;
            }
        } failure:nil];
    }
}
// 点击了评论按钮
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickCommentButtonWithIndex:(NSInteger)index
{
    BTListPost *listPost = self.dataArray[index];
    BTListPostInfoVC *infoVC = [[BTListPostInfoVC alloc] init];
    infoVC.extendId = listPost.ID;
    infoVC.dynamic = listPost.dynamic;
    [self.navigationController pushViewController:infoVC animated:YES];
}
// 点击了头像
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickIconButtonWithIndex:(NSInteger)index
{
    
}
// 点击了收藏喜欢按钮
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickLikeButtonWithIndex:(NSInteger)index
{
    BTListPost *listPost = self.dataArray[index];
    BTListPostDynamic *dynamic = listPost.dynamic;
    BOOL boolean = !dynamic.isCollect;
    [listPostCell setCollect:boolean];
    
    if (!boolean) {  // 已经收藏,需要调用取消收藏
        [BTUserManager unlikeSubjectWithID:[listPost.ID integerValue] successHandler:^(BOOL result) {
            if (result) {
                NSLog(@"取消收藏成功");
            }
        } failureHandler:nil];
    }else{ // 未收藏,调用收藏接口
        [BTUserManager likeSubjectWithID:[listPost.ID integerValue] boxID:0 categoryID:0 successHandler:^(BOOL result) {
            if (result) {
                NSLog(@"收藏成功");
            }
        } failureHandler:nil];
    }
}
// 点击了购买按钮
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickBuyButtonWithIndex:(NSInteger)index
{
    BTListPost *listPost = self.dataArray[index];
    BTWebViewVC *webViewVC = [[BTWebViewVC alloc] init];
    webViewVC.title = @"宝贝详情";
    BTProduct *product = listPost.product[index];
    webViewVC.url = product.url;
    webViewVC.isModalStyle = YES;
    [self presentViewController:[[BTNavigationController alloc] initWithRootViewController:webViewVC] animated:YES completion:nil];
    NSLog(@"点击了购买按钮");
}

// 点击了标签按钮
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickTag:(BTTag *)tag
{
    
}
#pragma mark - getter method
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
        [_tableView registerClass:[BTSubjectListPostCell class] forCellReuseIdentifier:@"subjectListPostCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.height -= (64 + 60);
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (BTLoadingView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [BTLoadingView loadingViewToView:self.view];
        [_loadingView startAnimation];
    }
    return _loadingView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (BTSubjectHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [BTSubjectHeaderView headerView];
        __weak typeof(self) weakSelf = self;
        _headerView.rankListDidClickBlock = ^()
        {
            BTSubjectRankListVC *rankListVC = [[BTSubjectRankListVC alloc] init];
            rankListVC.rankList = weakSelf.subject.dynamic.rankList;
            [weakSelf.navigationController pushViewController:rankListVC animated:YES];
        };
        _headerView.frame = CGRectMake(0, 0, kScreen_Width, 382);
    }
    return _headerView;
}

- (BTSubjectBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [BTSubjectBottomView bottomView];
        CGFloat H = 60;
        _bottomView.frame = CGRectMake(0, kScreen_Height - 60 - 64, kScreen_Width, H);
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.joinButtonDidBlock = ^()
        {
            
        };
    }
    return _bottomView;
}

- (NSMutableArray *)frameArray
{
    if (!_frameArray) {
        _frameArray = [NSMutableArray array];
    }
    return _frameArray;
}

@end
