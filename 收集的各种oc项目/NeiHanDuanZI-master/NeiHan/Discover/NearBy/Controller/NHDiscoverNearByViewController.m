//
//  NHDiscoverNearByViewController.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDiscoverNearByViewController.h"
#import "NHDiscoverNearByTableViewCell.h"
#import "NHDiscoverNearByFilterView.h"
#import "NHDiscoverNearByClearLocationRequest.h"
#import "NHDiscoverNearByRequest.h"
#import "NHDiscoverNearByUserModel.h"
#import "NHLocationManager.h"
#import "UIViewController+Loading.h"

@interface NHDiscoverNearByViewController () <NHDiscoverNearByFilterViewDelegate>
@property (nonatomic, assign) NSInteger gender;
@end

@implementation NHDiscoverNearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navItemTitle = @"附近段友";
    
    // 默认筛选全部
    self.gender = -1;
    
    [self loadData];
}

- (void)loadData {
    
    if ([NHLocationManager sharedManager].hasLocation) {
       NSString *lati = [[NSUserDefaults standardUserDefaults] objectForKey:kNHUserCurrentLatitude];
        NSString *longi = [[NSUserDefaults standardUserDefaults] objectForKey:kNHUserCurrentLongitude];
        [self loadDataWithLatitude:lati longitude:longi];
    } else {
        [[NHLocationManager sharedManager] startSerialLocation];
        [[NHLocationManager sharedManager] setUpLocationManagerUpdateLocationHandle:^(CLLocation *newLocation, NSString *newLatitude, NSString *newLongitude) {
            [self loadDataWithLatitude:newLatitude longitude:newLongitude];
        }];
        // 默认加载这个经纬度附近的人
        [self loadDataWithLatitude:@"40.07233784961181" longitude:@"116.3415643071043"];
    }
}

- (void)loadDataWithLatitude:(NSString *)lati longitude:(NSString *)longitude {
    
    [self showLoadingView];
    NHDiscoverNearByRequest *request = [NHDiscoverNearByRequest nh_request];
    request.nh_url = kNHDiscoverNearByUserListAPI;
    request.gender = self.gender;
    request.latitude = lati;
    request.longitude = longitude;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        [self hideLoadingView];
        if (success) {
            [self.dataArray removeAllObjects];
            self.dataArray = [NHDiscoverNearByUserModel modelArrayWithDictArray:response[@"user_list"]];
            
            if (self.dataArray.count) {
                WeakSelf(weakSelf);
                [self nh_setUpNavRightItemTitle:@"筛选" handle:^(NSString *rightItemTitle) {
                    NHDiscoverNearByFilterView *filterView = [NHDiscoverNearByFilterView filterViewWithGender:self.gender];
                    filterView.delegate = weakSelf;
                    [filterView show];
                }];
                
            } else {
                [self nh_setUpNavRightItemTitle:@"" handle:nil];
            }
            [self nh_reloadData];
            
        }
    }];
}

#pragma mark - NHDiscoverNearByFilterViewDelegate
- (void)discoverNearByFilterView:(NHDiscoverNearByFilterView *)filterView didFilterWithType:(NHDiscoverNearByFilterType)filterType {
    if (filterType == NHDiscoverNearByFilterTypeClearLoc) {
        return ;
    }

    if (filterType == NHDiscoverNearByFilterTypeAll) {
        self.gender = -1;
    } else if (filterType == NHDiscoverNearByFilterTypeMale) {
        self.gender = 1;
    } else if (filterType == NHDiscoverNearByFilterTypeFemale) {
        self.gender = 2;
    } else if (filterType == NHDiscoverNearByFilterTypeUnknown) {
        self.gender = 0;
    }
    [self loadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)nh_numberOfSections {
    return 1;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NHBaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath {
    NHDiscoverNearByTableViewCell *cell = [NHDiscoverNearByTableViewCell cellWithTableView:self.tableView];
    cell.userModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(NHBaseTableViewCell *)cell {
    
}

@end
