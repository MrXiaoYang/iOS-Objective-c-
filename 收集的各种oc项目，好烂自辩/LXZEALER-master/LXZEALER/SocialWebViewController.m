//
//  SocialWebViewController.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/3.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "SocialWebViewController.h"

@interface SocialWebViewController (){
    NSArray *_urlArray;
}

@end

@implementation SocialWebViewController

- (void)initBackButton{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"icon_player_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(20, 40, 24, 24);
    [self.view addSubview:backButton];
}

- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initStatusbarView{
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    statusBarView.backgroundColor = [UIColor colorWithRed:0.145 green:0.153 blue:0.176 alpha:1.000];
    [self.view addSubview:statusBarView];
}

- (void)loadRequest{
    _urlArray = [NSArray arrayWithObjects:
                 @"http://plus.zealer.com/mobile/post/4381?app=true",
                 @"http://plus.zealer.com/mobile/post/3938?app=true",
                 @"http://plus.zealer.com/mobile/post/4034?app=true",
                 @"http://plus.zealer.com/mobile/post/3943?app=true",
                 @"http://plus.zealer.com/mobile/post/3948?app=true",
                 
                 @"http://plus.zealer.com/mobile/post/4119?app=true",
                 @"http://plus.zealer.com/mobile/post/4140?app=true",
                 @"http://plus.zealer.com/mobile/post/4065?app=true",
                 @"http://plus.zealer.com/mobile/post/4079?app=true",
                 @"http://plus.zealer.com/mobile/post/3902?app=true",
                 @"http://plus.zealer.com/mobile/post/3929?app=true",
                 @"http://plus.zealer.com/mobile/post/3005?app=true",
                 @"http://plus.zealer.com/mobile/post/4078?app=true",
                 @"http://plus.zealer.com/mobile/post/4011?app=true",
                 @"http://plus.zealer.com/mobile/post/3994?app=true",nil];
    for (UIScrollView* view in self.webView.subviews)
    {
        if ([view isKindOfClass:[UIScrollView class]])
        {
            view.backgroundColor = [UIColor colorWithRed:0.145 green:0.153 blue:0.176 alpha:1.000];
        }
    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlArray[self.websiteId]]]];
}

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    [self.view addSubview:self.webView];
    [self loadRequest];
    [self initBackButton];
    [self initStatusbarView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBarHidden = YES;
}

@end
