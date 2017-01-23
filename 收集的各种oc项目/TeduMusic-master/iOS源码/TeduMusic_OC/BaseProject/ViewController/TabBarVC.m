//
//  TabBarVC.m
//  BaseProject
//
//  Created by jiyingxin on 15/12/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TabBarVC.h"
#import "TopBarView.h"

@interface TabBarVC ()<TopBarViewDelegate>
@property(nonatomic,strong) TopBarView *topBarView;
@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.hidden = YES;
    self.topBarView.hidden = NO;
}

- (UIView *)topBarView {
	if(_topBarView == nil) {
        _topBarView = [[TopBarView alloc] initWithDelegate:self];
        [self.view addSubview:_topBarView];
        [_topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(64);
        }];
	}
	return _topBarView;
}

#pragma mark - TopBarViewDelegate
- (void)topBarView:(TopBarView *)topBarView clicksBtnWithType:(TopBarViewBtnType)btnType{
    switch (btnType) {
        case TopBarViewBtnTypeHeader: {
            [self.sideMenuViewController presentLeftMenuViewController];
            break;
        }
        case TopBarViewBtnTypeMy: {
            self.selectedIndex = 0;
            break;
        }
        case TopBarViewBtnTypeDiscover: {
            self.selectedIndex = 1;
            break;
        }
        case TopBarViewBtnTypeMusicHouse: {
            self.selectedIndex = 2;
            break;
        }
        case TopBarViewBtnTypeSearch: {
            
            break;
        }
    }
}

@end



















