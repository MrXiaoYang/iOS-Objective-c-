//
//  NHHomeAttentionViewController.m
//  NeiHan
//
//  Created by Charles on 16/8/31.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHHomeAttentionViewController.h"
#import "NHHomeAttentionEmptyView.h"
#import "NHHomeAttentionListViewController.h"
#import "NHHomeAttentionRequest.h"
#import "NHHomeBaseViewController.h"
#import "NHHomeAttentionListRequest.h"

@interface NHHomeAttentionViewController ()
/** 没有关注的时候显示的视图*/
@property (nonatomic, weak) NHHomeAttentionEmptyView *emptyView;
@end

@implementation NHHomeAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.emptyView.hidden = NO;
    //    http://lf.snssdk.com/neihan/dongtai/dongtai_list/v1/?iid=5316804410&os_version=9.3.4&os_api=18&app_name=joke_essay&channel=App%20Store&device_platform=iphone&idfa=832E262C-31D7-488A-8856-69600FAABE36&live_sdk_version=120&vid=4A4CBB9E-ADC3-426B-B562-9FC8173FDA52&openudid=cbb1d9e8770b26c39fac806b79bf263a50da6666&device_type=iPhone%206%20Plus&version_code=5.5.0&ac=WIFI&screen_width=1242&device_id=10752255605&aid=7&app_name=joke_essay&count=50&min_time=1472721356903&mpic=1
    NHHomeAttentionRequest *request = [NHHomeAttentionRequest nh_request];
    request.nh_url = kNHHomeAttentionDynamicListAPI;
    NHHomeBaseViewController *controller = [[NHHomeBaseViewController alloc] initWithRequest:request];
    [self addChildVc:controller];
    WeakSelf(weakSelf);
    controller.homeBaseViewControllerFinishRequestDataHandle = ^(NSInteger dataCount) {
        weakSelf.emptyView.hidden = dataCount > 0;
    };
}

- (NHHomeAttentionEmptyView *)emptyView {
    if (!_emptyView) {
        NHHomeAttentionEmptyView *empty = [[NHHomeAttentionEmptyView alloc] init];
        [self.view addSubview:empty];
        _emptyView = empty;
        // 点我找朋友
        WeakSelf(weakSelf);
        empty.homeAttentionEmptyViewFindFriendHandle = ^() {
            [weakSelf findFriendAction];
        };
        empty.frame = self.view.bounds;
    }
    return _emptyView;
}

// 点我找朋友 / 推荐
- (void)findFriendAction {
    NHHomeAttentionListRequest *request = [NHHomeAttentionListRequest nh_request];
    request.nh_url = kNHDiscoverRecommendUserListAPI;
    request.offset = 0;
    NHHomeAttentionListViewController *listController = [[NHHomeAttentionListViewController alloc] initWithRequest:request];
    [self pushVc:listController];
}
@end
