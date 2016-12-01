//
//  NHHomeAttentionListViewController.m
//  NeiHan
//
//  Created by Charles on 16/8/31.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHHomeAttentionListViewController.h"
#import "NHHomeAttentionListSectionHeaderView.h"
#import "NHHomeAttentionListModel.h"
#import "NHHomeAttentionListRequest.h"
#import "NHHomeAttentionListTableViewCell.h"
#import "NHBaseRequest.h"
#import "NHPersonalCenterViewController.h"

@interface NHHomeAttentionListViewController () <NHHomeAttentionListTableViewCellDelegate>
@property (nonatomic, strong) NHBaseRequest *request;
@end

@implementation NHHomeAttentionListViewController {
    NSInteger _currentOffset;
}

- (instancetype)initWithRequest:(NHBaseRequest *)request {
    self = [super init];
    if (self) {
        self.request = request;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpItems];
    
    // 请求数据
    [self loadData];
}

// 设置导航栏
- (void)setUpItems {
    self.navItemTitle = @"推荐关注";
    
    self.refreshType = NHBaseTableVcRefreshTypeOnlyCanLoadMore; 
}

- (void)nh_loadMore {
    [super nh_loadMore];
    if ([self.request isKindOfClass:[NHHomeAttentionListRequest class]]) {
        NHHomeAttentionListRequest *request = (NHHomeAttentionListRequest *)self.request;
        request.offset = (_currentOffset += 20);
        request.nh_url = self.request.nh_url;
        [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
            [self nh_endLoadMore];
            if (success) {
                NSDictionary *dict = (NSDictionary *)response;
                if ([dict.allKeys containsObject:@"users"]) {
                    [self.dataArray  addObjectsFromArray:[NHHomeAttentionListModel modelArrayWithDictArray:dict[@"users"]]];
                }
                if (self.dataArray.count == 0) {
                    if ([dict.allKeys containsObject:@"recommend_users"]) {
                        [self.dataArray addObjectsFromArray:[NHHomeAttentionListModel modelArrayWithDictArray:dict[@"recommend_users"]]];
                    }
                }
                [self nh_reloadData];
            }
        }];
    }
}

// 请求数据
- (void)loadData {
    if (self.request) {
        [self.request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
            if (success) {
                NSDictionary *dict = (NSDictionary *)response;
                if ([dict.allKeys containsObject:@"users"]) {
                    self.dataArray = [NHHomeAttentionListModel modelArrayWithDictArray:dict[@"users"]];
                }
                if (self.dataArray.count == 0) {
                    if ([dict.allKeys containsObject:@"recommend_users"]) {
                        self.dataArray = [NHHomeAttentionListModel modelArrayWithDictArray:dict[@"recommend_users"]];
                    }
                }
                [self nh_reloadData];
            }
        }];
    } 
}

#pragma mark - UITableViewDelegate
- (NSInteger)nh_numberOfSections {
    return 1;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UIView *)nh_headerAtSection:(NSInteger)section {
    NHHomeAttentionListSectionHeaderView *sectionHeader = [NHHomeAttentionListSectionHeaderView headerFooterViewWithTableView:self.tableView];
    sectionHeader.tipText = @"如此逼格高的段友怎能不关注？！";
    return sectionHeader;
}

- (CGFloat)nh_sectionHeaderHeightAtSection:(NSInteger)section {
    return 44;
}

- (NHBaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath {
    NHHomeAttentionListTableViewCell *cell = [NHHomeAttentionListTableViewCell cellWithTableView:self.tableView];
    cell.model = self.dataArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

#pragma mark - NHHomeAttentionListTableViewCellDelegate
- (void)homeAttentionListTableViewCell:(NHHomeAttentionListTableViewCell *)cell didGotoPersonalCenterWithUserId:(NSInteger)userId {
    NHPersonalCenterViewController *personalCenter = [[NHPersonalCenterViewController alloc] initWithUserId:userId];
    [self pushVc:personalCenter];
}

- (void)homeAttentionListTableViewCellDidClickAttention:(NHHomeAttentionListTableViewCell *)cell {
    // 数据
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NHHomeAttentionListModel *model = self.dataArray[indexPath.row];
    model.is_followed = !model.is_followed;
    
    // 模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 更新
        [cell attSuccessWithAttFlag:model.is_followed];
    });
}

@end
