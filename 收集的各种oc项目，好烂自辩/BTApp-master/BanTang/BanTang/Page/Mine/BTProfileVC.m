//
//  BTBTProfileVC.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTProfileVC.h"
#import "BTLoadingView.h"
#import "BTHomePageManager.h"
#import "BTTopicNewInfo.h"
#import "BTProfileHeaderView.h"
#import "BTUserManager.h"
#import "BTUserInfo.h"
#import "BTNoHLbutton.h"
#import <Masonry.h>


@interface BTProfileVC ()
{
    BTProfileHeaderView *_headerView;
    BTNoHLbutton *_addFriendBtn;
    BTNoHLbutton *_settingBtn;
    BTUserInfo *_userInfo;
}
@end

@implementation BTProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self setupNavItem];
}

- (void)setupNavItem
{
    _settingBtn = [[BTNoHLbutton alloc] init];
    [_settingBtn setImage:[UIImage imageNamed:@"center_setting_icon"] forState:UIControlStateNormal];
    [self.view addSubview:_settingBtn];
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-8);
        make.top.mas_equalTo(self.view).offset(15);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    _addFriendBtn = [[BTNoHLbutton alloc] init];
    [_addFriendBtn setImage:[UIImage imageNamed:@"community_add_friend"] forState:UIControlStateNormal];
    [self.view addSubview:_addFriendBtn];
    [_addFriendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(15);
        make.top.mas_equalTo(self.view).offset(25);
        make.size.mas_equalTo(CGSizeMake(20, 22));
    }];

    
}

- (void)loadData
{
    [BTUserManager getUserInfoSuccess:^(BTUserInfo *userInfo) {
        BOOL result = [NSKeyedArchiver archiveRootObject:userInfo toFile:kUserInfoPath];
        if (result) {
            _userInfo = userInfo;
            NSLog(@"归档userInfo信息成功");
            _headerView = [BTProfileHeaderView headerView];
            _headerView.userInfo = userInfo;
            _headerView.frame = CGRectMake(0, 0, kScreen_Width, 260);
            [self.view addSubview:_headerView];
            [self.view insertSubview:_addFriendBtn aboveSubview:_headerView];
            [self.view insertSubview:_settingBtn aboveSubview:_headerView];
        }else{
            NSLog(@"归档userInfo信息失败");
        }
    } failure:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
@end
