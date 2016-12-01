//
//  ZealerVideoWebViewController.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/6.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "ZealerVideoWebViewController.h"

@interface ZealerVideoWebViewController ()

@end

@implementation ZealerVideoWebViewController

- (UIWebView*)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.scalesPageToFit = YES;
        [self loadRequest];
    }
    return _webView;
}

- (void)loadRequest{
    
    NSString *urlString = nil;
    
    
    NSArray *array1 = [NSArray arrayWithObjects:
                       @"http://www.zealer.com/post/235?app=true",  //iphone 6 测评
                       @"http://www.zealer.com/post/234?app=true",  //中国式众筹
                       @"http://plus.zealer.com/post/3973?app=trues",   //pro 5 拆解
                       @"http://www.zealer.com/post/231?app=true", nil];    //红衣大炮
    
    NSArray *array2 = [NSArray arrayWithObjects:
                       @"http://www.zealer.com/post/231?app=true",
                       @"http://www.zealer.com/post/229?app=true",
                       @"http://www.zealer.com/post/227?app=true",
                       @"http://www.zealer.com/media", nil];
    
    switch (_type) {
        case ScrollViewFirstRequest:
            urlString = array1[_index];
            break;
            
            case ScrollViewCollectionRequest:
            urlString = array2[_index];
            break;
            
            case ScrollViewTableCellRequest:
            urlString = @"http://plus.zealer.com/post/4235?app=true";
            break;
        default:
            break;
    }
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}
@end
