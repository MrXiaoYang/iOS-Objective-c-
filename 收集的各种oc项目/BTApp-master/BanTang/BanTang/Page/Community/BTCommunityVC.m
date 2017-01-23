//
//  BTCommunityVC.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTCommunityVC.h"
#import "BTCommunityManager.h"
#import "BTCommunityEditorRec.h"
#import "BTListPost.h"
#import "BTAppManager.h"
#import "BTRedSopt.h"
#import "BTUserManager.h"
#import "BTListPostInfoVC.h"
#import "BTSubjectListPostCell.h"
#import "BTCommunityHeaderView.h"
#import "BTCommunityTitleView.h"
#import "UIScrollView+PullToRefreshCoreText.h"
#import "BTPageLoadFooterView.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "BTLoadingView.h"

@interface BTCommunityVC() <BTSubjectListPostCellDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *listPostArray;

@property (nonatomic, strong) NSArray *elementArray;

@property (nonatomic, strong) NSMutableArray *myAttentionListPostArray;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) BTLoadingView *loadingView;

@property (nonatomic, strong) BTCommunityHeaderView *headerView;

@property (nonatomic, strong) BTPageLoadFooterView *footerView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger selectedID;

@end

@implementation BTCommunityVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavItem];

    [self loadNormalData];
    
    [self setupTableView];
}

- (void)setupNavItem
{
    self.selectedID = 100;
    
    __weak typeof(self) weakSelf = self;
	
    BTCommunityTitleView *titleView = [BTCommunityTitleView titleView];
    titleView.didClickBlock = ^(NSInteger tag)
    {
		weakSelf.selectedID = tag;
		
		CATransition *transition = [CATransition animation];
		transition.type = @"fade";
		transition.duration = 0.35f;
		[self.tableView.layer addAnimation:transition forKey:@""];
		
        if (tag == 100) {
            NSLog(@"点击了精选");
			weakSelf.tableView.tableHeaderView = self.headerView;
            [weakSelf selectJingXuan];
        }else if (tag == 101){
            NSLog(@"点击了关注");
            [weakSelf selectAttention];
            weakSelf.tableView.tableHeaderView = nil;
        }
    };
    titleView.frame = CGRectMake(0, 0, 120, 44);
    self.navigationItem.titleView = titleView;
	
	
	self.navigationItem.leftBarButtonItem =  [UIBarButtonItem rx_barBtnItemWithNmlImg:@"home_search_icon"
																			   hltImg:@"home_search_icon"
																			   target:self
																			   action:@selector(searchBtnClick)];
	
	self.navigationItem.rightBarButtonItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"community_add_friend"
																			   hltImg:@"community_add_friend"
																			   target:self
																			   action:@selector(addFriend)];
	
	
	
    self.automaticallyAdjustsScrollViewInsets = NO;
	
    [self.view addSubview:self.tableView];
}

- (void)setupTableView
{
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

- (void)selectJingXuan
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:self.listPostArray];
    [self.tableView reloadData];
}

- (void)selectAttention
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:self.myAttentionListPostArray];
    [self.tableView reloadData];
}

- (void)searchBtnClick
{
	NSLog(@"searchBtnClick");
}

- (void)loadNormalData
{
    __weak typeof(self) weakSelf = self;
    
    [BTCommunityManager getEditorRecWithPage:0 success:^(BTCommunityEditorRec *editorRec) {
        [weakSelf  hideAllLoading];
        weakSelf.elementArray = editorRec.element;
        weakSelf.tableView.tableHeaderView = weakSelf.headerView;
        weakSelf.listPostArray = [editorRec.list mutableCopy];
        [weakSelf.dataArray addObjectsFromArray:editorRec.list];
        [weakSelf.tableView reloadData];
        weakSelf.page++;
    } failure:^(NSError *error) {
        [weakSelf hideAllLoading];
    }];
    
    [BTCommunityManager getMyAttentionPostWithPage:0 success:^(NSArray *listPostArray) {
        [weakSelf hideAllLoading];
        weakSelf.myAttentionListPostArray = [listPostArray mutableCopy];
        [weakSelf.dataArray addObjectsFromArray:listPostArray];
        [weakSelf.tableView reloadData];
        weakSelf.page++;
    } failure:^(NSError *error) {
        [weakSelf hideAllLoading];
    }];
}

- (void)loadDataFromStart:(BOOL)boolean
{
    if (boolean) self.page = 0;
    __weak typeof(self) weakSelf = self;
    
    if (self.selectedID == 100) {
        [BTCommunityManager getEditorRecWithPage:self.page success:^(BTCommunityEditorRec *editorRec) {
            if (boolean) {
                [weakSelf.dataArray removeAllObjects];
            }
            [weakSelf  hideAllLoading];
            weakSelf.elementArray = editorRec.element;
            weakSelf.tableView.tableHeaderView = weakSelf.headerView;
            weakSelf.listPostArray = [editorRec.list mutableCopy];
            [weakSelf.dataArray addObjectsFromArray:editorRec.list];
            [weakSelf.tableView reloadData];
            weakSelf.page++;
        } failure:^(NSError *error) {
            [weakSelf hideAllLoading];
        }];
    }else if (self.selectedID == 101){
        [BTCommunityManager getMyAttentionPostWithPage:self.page success:^(NSArray *listPostArray) {
            if (boolean)  [weakSelf.dataArray removeAllObjects];
            [weakSelf hideAllLoading];
            weakSelf.myAttentionListPostArray = [listPostArray mutableCopy];
            [weakSelf.dataArray addObjectsFromArray:listPostArray];
            [weakSelf.tableView reloadData];
            weakSelf.page++;
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

- (void)hideAllLoading
{
    [self.footerView endRefreshing];
    [self.loadingView hideAnimation];
    [self.tableView finishLoading];
}

- (void)addFriend
{
    
}

#pragma mark - tableView Data Source
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == self.listPostArray.count - 1) {
//        __weak typeof(self) weakSelf = self;
//        BTPageLoadFooterView *footerView = [BTPageLoadFooterView footerWithRefreshingBlock:^{
//            [weakSelf loadDataFromStart:NO];
//        }];
//        self.footerView = footerView;
//        footerView.frame = CGRectMake(0, 0, kScreen_Width, 44);
//        self.tableView.tableFooterView = footerView;
//        [footerView startRefreshing];
//    }
//}

#pragma mark - BTSubjectListPostCellDelegate

/** 点击了头像 */
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickIconButtonWithIndex:(NSInteger)index
{
    
}

/** 点击了关注 */
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickAttentionButtonWithIndex:(NSInteger)index
{
    
}

/** 点击了tag标签 */
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickTag:(BTTag *)tag
{
    
}

/** 点击了购买按钮 */
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickBuyButtonWithIndex:(NSInteger)index
{
    
}

/** 点击了评论按钮 */
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickCommentButtonWithIndex:(NSInteger)index
{
    
}

/** 点击了喜欢按钮 */
- (void)listPostCell:(BTSubjectListPostCell *)listPostCell didClickLikeButtonWithIndex:(NSInteger)index
{
    
}

#pragma mark - getter method
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
        [_tableView registerClass:[BTSubjectListPostCell class]
           forCellReuseIdentifier:@"subjectListPostCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.height -= (64 + 49);
    }
    return _tableView;
}

- (NSMutableArray *)listPostArray
{
    if (!_listPostArray) {
        _listPostArray = [NSMutableArray array];
    }
    return _listPostArray;
}

- (NSMutableArray *)myAttentionListPostArray
{
    if (!_myAttentionListPostArray) {
        _myAttentionListPostArray = [NSMutableArray array];
    }
    return _myAttentionListPostArray;
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

- (BTCommunityHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[BTCommunityHeaderView alloc] initWithElementArray:self.elementArray];
        _headerView.frame = CGRectMake(0, 0, kScreen_Width,kScreen_Width * 0.6);
    }
    return _headerView;
}
@end
