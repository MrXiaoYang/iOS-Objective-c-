//
//  NHDiscoverHotViewController.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDiscoverHotViewController.h"
#import "NHDiscoverTableViewCell.h"
#import "NHDiscoverRequest.h"
#import "NHDiscoverModel.h"
#import "NHDiscoverHeaderView.h"
#import "NHDiscoverTopicViewController.h"

@interface NHDiscoverHotViewController ()
/** 轮播图数据数组*/
@property (nonatomic, strong) NSMutableArray *bannerImgArray;
/** 头部视图*/
@property (nonatomic, strong) NHDiscoverHeaderView *headerView;
@end

@implementation NHDiscoverHotViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
    // 设置子视图
    [self setUpViews];
    
    // 请求数据
    [self loadData];
}

// 设置子视图
- (void)setUpViews {
    self.sepLineColor = kSeperatorColor;
    
    self.refreshType = NHBaseTableVcRefreshTypeRefreshAndLoadMore;
}

// 请求数据
- (void)loadData {
    [super loadData];
    NHDiscoverRequest *request = [NHDiscoverRequest nh_request];
    request.nh_url = kNHDiscoverHotListAPI;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            NHDiscoverModel *discoverModel = [NHDiscoverModel modelWithDictionary:response];
            
            self.bannerImgArray = discoverModel.rotate_banner.banners;
            
            if (self.bannerImgArray.count) {
                
                self.headerView.modelArray = self.bannerImgArray;
                WeakSelf(weakSelf);
                self.headerView.discoverHeaderViewGoToPageHandle = ^(NHDiscoverHeaderViewViewCell *cell, NHDiscoverRotate_bannerElement *elementModel) {
                    
                    NSMutableString *schema_url = elementModel.schema_url.mutableCopy;
                    if (schema_url.length > 4) {
                        [schema_url deleteCharactersInRange:NSMakeRange(0, 4)];
                    }
                    NSInteger categoryId = schema_url.integerValue;
                    NHDiscoverTopicViewController *topic = [[NHDiscoverTopicViewController alloc] initWithCatogoryId:categoryId];
                    topic.navigationItem.title = elementModel.banner_url.title;
                    [weakSelf pushVc:topic];
                };
            }
            self.dataArray = discoverModel.categories.category_list;
            [self.tableView reloadData];
        }
    }];
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)nh_numberOfSections {
    return 1;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NHBaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath {
    NHDiscoverTableViewCell *cell = [NHDiscoverTableViewCell cellWithTableView:self.tableView];
    
    cell.elementModel = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(NHBaseTableViewCell *)cell {
    NHDiscoverCategoryElement *elementModel = self.dataArray[indexPath.row];
    NHDiscoverTopicViewController *topic = [[NHDiscoverTopicViewController alloc] initWithCategoryElement:elementModel];
    //    [[NHDiscoverTopicViewController alloc] initWithCatogoryId:elementModel.ID];
    [self pushVc:topic];
}

- (NSMutableArray *)bannerImgArray {
    if (!_bannerImgArray) {
        _bannerImgArray = [NSMutableArray new];
    }
    return _bannerImgArray;
}

- (NHDiscoverHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[NHDiscoverHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
        self.tableView.tableHeaderView = _headerView;
    }
    return _headerView;
}

@end
