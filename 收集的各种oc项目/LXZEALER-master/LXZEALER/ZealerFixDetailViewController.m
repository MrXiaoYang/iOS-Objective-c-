//
//  ZealerFixDetailViewController.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/2.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "ZealerFixDetailViewController.h"
#import "UIView+Hud.h"

@interface ZealerFixDetailViewController (){
    NSArray *_urlArray;
}

@end

@implementation ZealerFixDetailViewController

- (void)loadRequest{
    _urlArray = [NSArray arrayWithObjects:
                 @"http://fix.zealer.com/reMobile/sift?order=1&cartegory=phone&mid=54",
                 @"http://fix.zealer.com/reMobile/sift?order=1&cartegory=phone&mid=49",
                 @"http://fix.zealer.com/reMobile/sift?order=1&cartegory=phone&mid=1",
                 @"http://fix.zealer.com/reMobile/sift?order=1&cartegory=phone&mid=5",
                 @"http://fix.zealer.com/reMobile/sift?order=1&cartegory=phone&mid=11",
                 @"http://fix.zealer.com/reMobile/sift?order=1&cartegory=phone&mid=14",
                 @"http://fix.zealer.com/rephone",
                 @"http://fix.zealer.com/mobile",nil];
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlArray[self.index]]]];
}

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self.view addSubview:self.webView];
    [self loadRequest];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

@end
