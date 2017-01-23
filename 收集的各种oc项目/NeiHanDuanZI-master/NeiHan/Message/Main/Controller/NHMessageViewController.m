//
//  NHMessageViewController.m
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHMessageViewController.h"
#import "NHCustomCommonEmptyView.h"
#import "NHBlackListViewController.h"
#import "NHFansAndAttentionViewController.h"
#import "NHHomeUserIconView.h"
#import "NHUserInfoManager.h"
#import "NHLoginViewController.h"
#import "NHPersonalCenterViewController.h"
#import "NHSystemMessageViewController.h"
#import "NHMessageCoversationViewController.h"

@interface NHMessageViewController ()
/** 图片数组*/
@property (nonatomic, strong) NSArray *imageArray;
@end
@implementation NHMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpItems];
}

// 设置导航栏
- (void)setUpItems {
    // 头像
    WeakSelf(weakSelf);
    NHHomeUserIconView *iconView = [NHHomeUserIconView iconView];
    iconView.frame = CGRectMake(-10, 0, 35, 35);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:iconView];
    iconView.homeUserIconViewDidClickHandle = ^(NHHomeUserIconView *iconView) {
        [weakSelf leftItemClick];
    };
    if (![NHUserInfoManager sharedManager].isLogin) {
        iconView.image = [UIImage imageNamed:@"defaulthead"];
    } else {
        iconView.iconUrl = [NHUserInfoManager sharedManager].currentUserInfo.avatar_url;
    }
    self.dataArray = @[@"投稿互动",
                       @"系统消息",
                       @"粉丝关注"].mutableCopy;
    
    NHCustomCommonEmptyView *emptyView = [[NHCustomCommonEmptyView alloc] initWithTitle:@"约起来吧" secondTitle:@"去TA的主页就可以发悄悄话了" iconname:@"around"];
    emptyView.frame = CGRectMake(0, 0, kScreenWidth, 170);
    self.tableView.tableFooterView = emptyView;
    
    
    self.navItemTitle = @"消息";
    
    self.navRightItem = [[UIBarButtonItem alloc] initWithTitle:@"黑名单" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];

    
}

// 个人中心
- (void)leftItemClick {
    
    if (![NHUserInfoManager sharedManager].isLogin) {
        NHLoginViewController *loginController = [[NHLoginViewController alloc] init];
        [self pushVc:loginController];
    } else {
        NHPersonalCenterViewController *personalCenter = [[NHPersonalCenterViewController alloc] initWithUserInfoModel:[[NHUserInfoManager sharedManager] currentUserInfo]];
        [self pushVc:personalCenter];
    }
}

// 黑名单
- (void)rightItemClick {
    NHBlackListViewController *blackList = [[NHBlackListViewController alloc] init];
    [self pushVc:blackList];
}

#pragma mark - UITableViewDelegate
- (NHBaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath {
    NHBaseTableViewCell *cell = [NHBaseTableViewCell cellWithTableView:self.tableView];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)nh_numberOfSections {
    return 1;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(NHBaseTableViewCell *)cell {
    
    switch (indexPath.row) { // 投稿互动
        case 0: {
            NHMessageCoversationViewController *coversationViewController = [[NHMessageCoversationViewController alloc] init];
            [self pushVc:coversationViewController];
        } break;
            
        case 1: { // 系统消息
            NHSystemMessageViewController *systemMessageViewController = [[NHSystemMessageViewController alloc] init];
            [self pushVc:systemMessageViewController];
        } break;
        case 2: { // 粉丝和关注
            NHFansAndAttentionViewController *fansAndAttentionViewController  = [[NHFansAndAttentionViewController alloc] initWithUserId:[NHUserInfoManager sharedManager].currentUserInfo.user_id vcType:NHFansAndAttentionViewControllerAttention];
            [self pushVc:fansAndAttentionViewController];
        } break;
            
        default:
            break;
    }
}

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = @[@"interaction", @"messageicon_profile", @"vermicelli"];
    }
    return _imageArray;
}

@end
