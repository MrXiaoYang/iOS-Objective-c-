//
//  NHDiscoverViewController.m
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDiscoverViewController.h"
#import "NHDiscoverHotViewController.h"
#import "NHDiscoverSubScribeViewController.h"
#import "NHCustomSegmentView.h"
#import "NHDiscoverSearchViewController.h"
#import "NHDiscoverNearByViewController.h"
#import "NHHomeNeiHanShareView.h"
#import "NHNeiHanShareManager.h"
#import "NHDiscoverSearchViewController.h"

@interface NHDiscoverViewController ()
@property (nonatomic, strong) NSMutableArray *bannerImgArray;
/** 热吧*/
@property (nonatomic, strong) NHDiscoverHotViewController *hotController;
/** 订阅*/
@property (nonatomic, strong) NHDiscoverSubScribeViewController *subScibeController;
@end

@implementation NHDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpItems];
    
}

// 设置导航栏
- (void)setUpItems {
    
    NHCustomSegmentView *segment = [[NHCustomSegmentView alloc] initWithItemTitles:@[@"热吧", @"订阅"]];
    self.navigationItem.titleView = segment;
    segment.frame = CGRectMake(0, 0, 130, 35);
    WeakSelf(weakSelf);
    segment.NHCustomSegmentViewBtnClickHandle = ^(NHCustomSegmentView *segment, NSString *title, NSInteger currentIndex) {
        [weakSelf changeChildVcWithCurrentIndex:currentIndex];
    };
    [segment clickDefault];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"foundsearch"] style:UIBarButtonItemStylePlain target:self action:@selector(searchItemClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nearbypeople"] style:UIBarButtonItemStylePlain target:self action:@selector(nearByItemClick)];
    
}

// 搜索
- (void)searchItemClick {
    NHDiscoverSearchViewController *searchController = [[NHDiscoverSearchViewController alloc] init];
    [self pushVc:searchController];
}

// 附近
- (void)nearByItemClick {
    NHDiscoverNearByViewController *nearByController = [[NHDiscoverNearByViewController alloc] init];
    [self pushVc:nearByController];
}

- (void)changeChildVcWithCurrentIndex:(NSInteger)currentIndex {
    BOOL isHot = (currentIndex == 0);
    
    if (isHot) { // 热门
        [self addChildVc:self.hotController];
        [self removeChildVc:self.subScibeController];
    } else { // 订阅
        [self addChildVc:self.subScibeController];
        [self removeChildVc:self.hotController];
    }
}

- (NHDiscoverSubScribeViewController *)subScibeController {
    if (!_subScibeController) {
        _subScibeController = [[NHDiscoverSubScribeViewController alloc] init];
        [self addChildVc:_subScibeController];
    }
    return _subScibeController;
}

- (NHDiscoverHotViewController *)hotController {
    if (!_hotController) {
        _hotController = [[NHDiscoverHotViewController alloc] init];
        [self addChildVc:_hotController];
    }
    return _hotController;
}

@end
