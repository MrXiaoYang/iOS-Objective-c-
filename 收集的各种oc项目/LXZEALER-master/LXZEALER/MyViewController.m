//
//  MyViewController.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/1.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "MyViewController.h"
#import "MyCollectionViewCell.h"
#import "AboutZealerViewController.h"
#import "UserInfoDetailViewController.h"
#import <UIImageView+WebCache.h>
#import "AccountTool.h"
#import <MBProgressHUD.h>
#import <SDWebImageOperation.h>
#define CELL_WIDTH self.view.bounds.size.width / 3
#define SCREEN_WIDTH self.view.bounds.size.width

@implementation MyViewController{
    
    User *user;

}

- (UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.minimumLineSpacing = 1;
        flowLayout.itemSize = CGSizeMake(CELL_WIDTH -1 , CELL_WIDTH -1);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, headBackgroundImage.frame.size.height , SCREEN_WIDTH, SCREEN_WIDTH) collectionViewLayout:flowLayout];
        [_collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
        _collectionView.scrollEnabled = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setImageForCellWithIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (user) {
        
        if (indexPath.row == 5) {
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            [[SDImageCache sharedImageCache] cleanDisk];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            });
        }else {
            
            AboutZealerViewController *aboutZealerVC = [[AboutZealerViewController alloc] init];
            [self.navigationController pushViewController:aboutZealerVC animated:YES];
        }
    }else {
        
        [self performSegueWithIdentifier:@"isLogin" sender:self];
    }
}

#pragma mark - life circle
- (void)viewDidLoad{
    [super viewDidLoad];
    UITabBarItem *item = self.tabBarController.tabBar.items[2];
    [item setSelectedImage:[UIImage imageNamed:@"tab_me_pre"]];
    [self.view addSubview:self.collectionView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserinfo:) name:@"WBAuthorSuccessfulNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserinfo:) name:@"WXAuthorSuccessfulNotification" object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBarHidden = YES;
    
    user = [AccountTool getUserInformation];
    
    if (user.name) {
        
        self.userNameLabel.text = user.name;
        
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:user.avatar_large]];
    }else {
        
        self.userNameLabel.text = @"未登录";
        
        self.headImageView.image = [UIImage imageNamed:@"bg_headinmage"];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - 更新授权后的个人信息
- (void)updateUserinfo:(NSNotification*)notification{
    //修改登录状态
    isLogin = YES;
    
    if ([notification.name isEqualToString:@"WXAuthorSuccessfulNotification"]) {
        
        User *user1 = [[User alloc] init];
        
        user1.id = [notification.userInfo[@"unionid"] integerValue];
        
        user1.name = notification.userInfo[@"nickname"];
        
        user1.gender = notification.userInfo[@"sex"];
        
        user1.avatar_large = notification.userInfo[@"headimgurl"];
        
        user1.userDescription = @"暂无个人介绍";
        
        [AccountTool saveUserInformation:user1];
        
        self.userNameLabel.text = user1.name;
        
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:user1.avatar_large]];
        
    }else {
        
        //保存登录信息
        User *user1 = [[User alloc] init];
        
        user1.id = [notification.userInfo[@"id"] integerValue];
        
        user1.name = notification.userInfo[@"name"];
        
        user1.userDescription = notification.userInfo[@"description"];
        
        user1.gender = notification.userInfo[@"gender"];
        
        user1.avatar_large = notification.userInfo[@"avatar_large"];
        
        [AccountTool saveUserInformation:user1];
        
        self.userNameLabel.text = user1.name;
        
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:user1.avatar_large]];
    }
}

#pragma mark - 点击个人头像后相应的操作
- (IBAction)loginButtonAction:(id)sender {
    
    if (user) {
        //登录状态下查看个人信息
        UserInfoDetailViewController *userInfoDetailVC = [[UserInfoDetailViewController alloc] init];
        
        [self.navigationController pushViewController:userInfoDetailVC animated:YES];
    }else {
        
        //未登录状态下进入登录页面
        [self performSegueWithIdentifier:@"isLogin" sender:self];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WBAuthorSuccessfulNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXAuthorSuccessfulNotification" object:nil];
}

@end
