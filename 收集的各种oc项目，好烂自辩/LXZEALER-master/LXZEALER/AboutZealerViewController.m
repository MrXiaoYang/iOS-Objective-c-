//
//  AboutZealerViewController.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/1.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "AboutZealerViewController.h"
#import "copyRightViewController.h"
#import "LoginViewController.h"
#import "AccountTool.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface AboutZealerViewController ()

@end

@implementation AboutZealerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 650);
    [self initContentView];
   // [self initNavigationBar];
}

#pragma mark - initNavigationBar
- (void)initNavigationBar {
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    navView.backgroundColor = [UIColor darkGrayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, SCREEN_WIDTH, 40)];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.text = @"关于我们";
    
    [navView addSubview:titleLabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    backButton.frame = CGRectMake(10, 10, 44, 44);
    
    [navView addSubview:backButton];
}

#pragma mark - backButtonAction
- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initContentView{
    UIImageView *aboutImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 530)];
    aboutImageView.image = [UIImage imageNamed:@"bg_about"];
    aboutImageView.contentMode = UIViewContentModeScaleToFill;
    [self.scrollView addSubview:aboutImageView];
    
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [copyButton setTitle:@"《免责声明及隐私政策》" forState:UIControlStateNormal];
    [copyButton addTarget:self action:@selector(copyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    copyButton.frame = CGRectMake(0, 530, 200, 44);
    [self.scrollView addSubview:copyButton];
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.frame = CGRectMake(20, 574, SCREEN_WIDTH - 40, 44);
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    logoutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    logoutButton.backgroundColor = [UIColor colorWithRed:0.145 green:0.153 blue:0.176 alpha:1.000];
    [self.scrollView addSubview:logoutButton];
}

- (void)copyButtonAction{
    copyRightViewController *copyVC = [[copyRightViewController alloc] init];
    [self.navigationController pushViewController:copyVC animated:YES];
}

#pragma mark - logoutAction
- (void)logoutAction {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出登录吗?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [AccountTool deleteUserInfomation];
        
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.tabBarController.tabBar.hidden = YES;
}

@end
