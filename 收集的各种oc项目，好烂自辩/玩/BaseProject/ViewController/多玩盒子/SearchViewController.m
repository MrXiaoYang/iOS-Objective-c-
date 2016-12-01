//
//  SearchViewController.m
//  BaseProject
//
//  Created by jiyingxin on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchDetailViewController.h"

@interface SearchViewController ()<UIWebViewDelegate>
@property(nonatomic,strong) UIWebView *webView;
@end
@implementation SearchViewController
- (id)init{
    if (self=[super init]) {
        self.title=@"召唤师查询";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Factory addMenuItemToVC:self];
    self.view.backgroundColor=[UIColor whiteColor];
    NSString *path=@"http://lolbox.duowan.com/phone/playerSearchNew.php?lolboxAction=toInternalWebView";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
}
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [UIWebView new];
        [self.view addSubview:_webView];
        _webView.delegate = self;
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _webView;
}

#pragma mark - UIWebViewDelegate
//如果返回NO，则不会加载请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//点击web中任意一项，跳转到下一页
//如果当前webview加载的请求 不是当前页面的
    NSString *path=@"http://lolbox.duowan.com/phone/playerSearchNew.php?lolboxAction=toInternalWebView";
    if (![request.URL.absoluteString isEqualToString:path]) {
        SearchDetailViewController *vc=[[SearchDetailViewController alloc] initWithRequest:request];
        [self.navigationController pushViewController:vc animated:YES];
        return NO;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self showProgress];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self hideProgress];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [self hideProgress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
