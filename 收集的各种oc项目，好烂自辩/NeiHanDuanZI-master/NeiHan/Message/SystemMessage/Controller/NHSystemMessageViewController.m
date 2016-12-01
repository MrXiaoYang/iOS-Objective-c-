//
//  NHSystemMessageViewController.m
//  NeiHan
//
//  Created by Charles on 16/9/11.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHSystemMessageViewController.h"
#import "NHCustomCommonEmptyView.h"

@interface NHSystemMessageViewController ()
@property (nonatomic, weak) NHCustomCommonEmptyView *emptyView;
@end

@implementation NHSystemMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpItems];
    
         // 请求数据
    [self loadData];
}

// 请求数据
- (void)loadData {
    [super loadData];
    
    [self showLoadingAnimation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideLoadingAnimation];
        
        [self.emptyView showInView:self.view];
    });
}

// 设置导航栏
- (void)setUpItems {
    self.navItemTitle = @"系统消息";
}

- (NHCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        NHCustomCommonEmptyView *empty = [[NHCustomCommonEmptyView alloc] initWithTitle:@"" secondTitle:@"" iconname:@"nocontent"];
        [self.view addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}

@end
