//
//  NHFansAndAttentionViewController.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHFansAndAttentionViewController.h"
#import "NHCustomSlideViewController.h"
#import "NHHomeAttentionListViewController.h"
#import "NHFansAttentionHeaderOptionalView.h"
#import "NHHomeAttentionListRequest.h"

@interface NHFansAndAttentionViewController () <NHCustomSlideViewControllerDataSource, NHCustomSlideViewControllerDelegate>
@property (nonatomic, weak) NHCustomSlideViewController *slideViewController;
/** 关注和粉丝*/
@property (nonatomic, weak) NHFansAttentionHeaderOptionalView *optionalView;
/** 用户ID*/
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NHFansAndAttentionVcType vcType;
@end

@implementation NHFansAndAttentionViewController

- (instancetype)initWithUserId:(NSInteger)userId vcType:(NHFansAndAttentionVcType)vcType {
    if (self = [super init]) {
        self.userId = userId;
        self.vcType = vcType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpItems];
    
    // 设置子视图
    [self setUpViews];
}

// 设置导航栏
- (void)setUpItems {
    self.navigationItem.title = @"粉丝与关注";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"推荐" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
}

// 设置子视图
- (void)setUpViews {
    [self.slideViewController reloadData];
    [self.optionalView clickDefaultWithIndex:self.vcType];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.slideViewController.view.frame = CGRectMake(0, 49, kScreenWidth, kScreenHeight - 49 - 64);
}

// 推荐
- (void)rightItemClick {
    NHHomeAttentionListRequest *request = [NHHomeAttentionListRequest nh_request];
    request.nh_url = kNHDiscoverRecommendUserListAPI;
    request.offset = 0;
    NHHomeAttentionListViewController *list = [[NHHomeAttentionListViewController alloc] initWithRequest:request];
    [self pushVc:list];
}

#pragma mark - NHCustomSlideViewControllerDelegate
- (UIViewController *)slideViewController:(NHCustomSlideViewController *)slideViewController viewControllerAtIndex:(NSInteger)index {
    NHHomeAttentionListRequest *request = [NHHomeAttentionListRequest nh_request];
    request.offset = 0;
    request.homepage_user_id = self.userId;
    if (index == 0) {
        // 关注
        request.nh_url = kNHUserFansListAPI;
    } else {
        // 粉丝
        request.nh_url = kNHUserAttentionListAPI;
    }
    NHHomeAttentionListViewController *controller = [[NHHomeAttentionListViewController alloc] initWithRequest:request];
    return controller;
}

- (NSInteger)numberOfChildViewControllersInSlideViewController:(NHCustomSlideViewController *)slideViewController {
    return 2;
}

- (void)customSlideViewController:(NHCustomSlideViewController *)slideViewController slideIndex:(NSInteger)slideIndex {
    self.optionalView.selectIndex = slideIndex;
}

- (NHCustomSlideViewController *)slideViewController {
    if (!_slideViewController) {
        NHCustomSlideViewController *slide = [[NHCustomSlideViewController alloc] init];
        [self addChildVc:slide];
        _slideViewController = slide;
        slide.delgate = self;
        slide.dataSource = self;
    }
    return _slideViewController;
}

- (NHFansAttentionHeaderOptionalView *)optionalView {
    if (!_optionalView) {
        NHFansAttentionHeaderOptionalView *optionalView = [NHFansAttentionHeaderOptionalView optionalView];
        [self.view addSubview:optionalView];
        _optionalView = optionalView;
        WeakSelf(weakSelf);
        optionalView.fansAttentionHeaderOptionalViewBtnClickHandle = ^(NHFansAttentionHeaderOptionalView *view, UIButton *btn, NSInteger currentIndex) {
            [weakSelf.slideViewController setSeletedIndex:currentIndex];
        };
        optionalView.frame = CGRectMake(0, 0, kScreenWidth, 49);
    }
    return _optionalView;
}
@end
