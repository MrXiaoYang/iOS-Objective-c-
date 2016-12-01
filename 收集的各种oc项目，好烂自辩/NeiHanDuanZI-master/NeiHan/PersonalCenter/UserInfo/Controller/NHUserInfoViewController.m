//
//  NHUserInfoViewController.m
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHUserInfoViewController.h"
#import "NHNeiHanUserInfoModel.h"
#import "NHUserInfoManager.h"
#import "NHCustomAlertView.h"

@interface NHUserInfoViewController () <UIAlertViewDelegate>
@property (nonatomic, weak) UIImageView *iconImg;
@property (nonatomic, weak) UILabel *nameL;
@property (nonatomic, weak) UILabel *sexL;
@property (nonatomic, weak) UILabel *descL;
@property (nonatomic, weak) UIButton *logoutBtn;
@end

@implementation NHUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 简单展示用户信息
    NHNeiHanUserInfoModel *userInfoModel = [[NHUserInfoManager sharedManager] currentUserInfo];
    UIImageView *img = [[UIImageView alloc] init];
    [self.view addSubview:img];
    _iconImg = img;
    [img sd_setImageWithURL:[NSURL URLWithString:userInfoModel.avatar_url]];
    WeakSelf(weakSelf);
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.mas_offset(20);
        make.centerX.equalTo(weakSelf.view);
    }];
    
    UILabel *nameL = [[UILabel alloc] init];
    [self.view addSubview:nameL];
    _nameL = nameL;
    
    nameL.text = [NSString stringWithFormat:@"用户名字 ： %@", userInfoModel.screen_name];
    nameL.font = kFont(16);
    nameL.textColor = kCommonBlackColor;
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.iconImg.mas_bottom).mas_offset(15);
        make.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *sexL = [[UILabel alloc] init];
    [self.view addSubview:sexL];
    _sexL = sexL;
    
    NSString *sex = @"男";
    if (userInfoModel.gender == 1) {
        sex = @"男";
    } else if (userInfoModel.gender == 2) {
        sex = @"女";
    } else if (userInfoModel.gender == 0) {
        sex = @"不明";
    }
    sexL.text = [NSString stringWithFormat:@"性别 ： %@", sex];
    sexL.font = kFont(16);
    sexL.textColor = kCommonBlackColor;
    [sexL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameL.mas_bottom).mas_offset(15);
        make.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *desL = [[UILabel alloc] init];
    [self.view addSubview:desL];
    _descL = desL;
    
    desL.numberOfLines = 0;
    desL.text = [NSString stringWithFormat:@"签名 ： %@", userInfoModel.desc];
    desL.font = kFont(16);
    desL.textColor = kCommonBlackColor;
    [desL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.sexL.mas_bottom).mas_offset(15);
        make.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *logout = [[UIButton alloc] init];
    [self.view addSubview:logout];
    _logoutBtn = logout;
    [logout setTitle:@"退出登录" forState:UIControlStateNormal];
    logout.titleLabel.font = kFont(16);
    [logout setTitleColor:kRedColor forState:UIControlStateNormal];
    [logout mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(weakSelf.descL.mas_bottom).mas_offset(15);
        make.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(30);
    }];
    
    [logout addTarget:self action:@selector(logoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)logoutBtnClick:(UIButton *)btn {
    WeakSelf(weakSelf);
    NHCustomAlertView *alert = [[NHCustomAlertView alloc] initWithTitle:@"退出当前账号，将不能同步收藏，发布评论和云端分享等" cancel:@"取消" sure:@"确定"];
    [alert showInView:self.view.window];
    [alert setupSureBlock:^BOOL{
        
        [[NHUserInfoManager sharedManager] didLoginOut];
        [weakSelf popToRootVc];
        return YES;
    }];
}


@end
