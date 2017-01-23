//
//  BTWebViewVC.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/29.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTWebViewVC.h"
@interface BTWebViewVC ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation BTWebViewVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.webView];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.navigationController.navigationBar setBackgroundImage:[UIImage rx_captureImageWithImageName:@"nav_backgroud"]
												  forBarMetrics:UIBarMetricsDefault];
}


- (void)setIsModalStyle:(BOOL)isModalStyle
{
    _isModalStyle = isModalStyle;
    
    if (self.isModalStyle) {
        UIBarButtonItem *cancelItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"Login_close_btn"
                                                                     hltImg:@"Login_close_btn"
                                                                     target:self
                                                                     action:@selector(backButtonDidClick)];
        self.navigationItem.rightBarButtonItem = cancelItem;
        
        self.navigationItem.leftBarButtonItem = nil;
    }else{
        UIBarButtonItem *shareItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"share_item_icon"
                                                                    hltImg:@"share_item_icon"
                                                                    target:self
                                                                    action:@selector(shareItemDidClick)];
        self.navigationItem.rightBarButtonItem = shareItem;
    }
}

- (void)shareItemDidClick
{
    
}

- (void)backButtonDidClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;
        _webView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64);
    }
    return _webView;
}
- (void)setUrl:(NSString *)url
{
    _url = url;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [self.webView loadRequest:request];
}
@end
