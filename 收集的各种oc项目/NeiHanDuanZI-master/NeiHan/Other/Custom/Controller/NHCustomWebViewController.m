//
//  NHCustomWebViewController.m
//  NeiHan
//
//  Created by Charles on 16/9/2.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHCustomWebViewController.h"
#import <WebKit/WebKit.h>

@interface NHCustomWebViewController () <WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, copy) NSString *url;
@end

@implementation NHCustomWebViewController

- (instancetype)initWithUrl:(NSString *)url {
    if (self = [super init]) {
        self.url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *URL = [NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
        [self.view addSubview:wkWebView];
        _webView = wkWebView;
        wkWebView.UIDelegate = self;
        wkWebView.navigationDelegate = self;
        wkWebView.opaque = NO;
        wkWebView.backgroundColor = self.view.backgroundColor;
    }
    return _webView;
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
 
    // 允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow); 
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
  
    // 允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)pop {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        } else  {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

@end
