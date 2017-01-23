//
//  NHDynamicDetailReportViewController.m
//  NeiHan
//
//  Created by Charles on 16/9/3.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDynamicDetailReportViewController.h"
#import "NHDynamicDetailReportRequest.h"
#import "NHCustomPlaceHolderTextView.h"
#import "UIButton+Addition.h"

@interface NHDynamicDetailReportViewController ()
@property (nonatomic, strong) NSArray *reportCategoryArray;
@property (nonatomic, weak) UIButton *selectButton;
@end

@implementation NHDynamicDetailReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpItems];
    
    // 设置子视图
    [self setUpViews];
}

// 设置导航栏
- (void)setUpItems {
    self.navigationItem.title = @"举报";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
}

// 设置子视图
- (void)setUpViews {
     
    self.view.backgroundColor = kWhiteColor;
    
    CGFloat btnW = kScreenWidth / 2.0;
    CGFloat btnX = 15;
    CGFloat btnH = 35;
    CGFloat btnY = 0;
    CGFloat margin = 10;
    for (int i = 0 ; i < self.reportCategoryArray.count; i++) {
        UIColor *btnColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
        UIButton *btn = [UIButton buttonWithTitle:self.reportCategoryArray[i] normalColor:btnColor selectedColor:btnColor fontSize:16.0 target:self action:@selector(btnClick:)];
        [btn setImage:[UIImage imageNamed:@"selectround_detail_report"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"selectround_detail_report_press"] forState:UIControlStateSelected];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        [self.view addSubview:btn];
        btnY = i * btnH + (i + 1) * margin;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    NHCustomPlaceHolderTextView *textView = [[NHCustomPlaceHolderTextView alloc] init];
    [self.view addSubview:textView];
    textView.frame = CGRectMake(15, margin * (self.reportCategoryArray.count + 1) + btnH * self.reportCategoryArray.count, kScreenWidth - 15 * 2, 130);
    textView.placehoder = @"写下你的举报...";
    textView.backgroundColor = kSeperatorColor;
    
    WeakSelf(weakSelf);
    UIButton *commitBtn = [UIButton buttonWithTitle:@"提交" normalColor:kWhiteColor selectedColor:kWhiteColor fontSize:16 touchBlock:^{
        [weakSelf commitBtnClick];
    }];
    [self.view addSubview:commitBtn];
    commitBtn.backgroundColor = kRedColor;
    commitBtn.frame = CGRectMake(15, textView.bottom + 30, kScreenWidth - 30, 40);
    
    
}

// 返回
- (void)leftItemClick {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

// 举报
- (void)commitBtnClick {
    NHDynamicDetailReportRequest *request = [NHDynamicDetailReportRequest nh_request];
    request.nh_url = kNHHomeReportDynamicAPI;
    request.nh_isPost = YES;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            [self leftItemClick];
        }
    }];
}

- (void)btnClick:(UIButton *)btn {
    if (self.selectButton == btn) {
        return ;
    }
    self.selectButton.selected = NO;
    btn.selected = !btn.selected;
    self.selectButton = btn;
}

- (NSArray *)reportCategoryArray {
    if (!_reportCategoryArray) {
        _reportCategoryArray = @[@"垃圾广告", @"淫秽色情", @"煽情骗顶", @"以前看过", @"抄袭我的内容", @"其他"];
    }
    return _reportCategoryArray;
}
@end
