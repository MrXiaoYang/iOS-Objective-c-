//
//  NHLoginViewController.m
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHLoginViewController.h"
#import "NHNeiHanUserInfoModel.h"
#import "NHUserInfoManager.h"
#import "NHCustomAlertView.h"
#import "UIView+Layer.h"

@interface NHLoginViewController ()
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, weak) UILabel *alertL;

@end

@implementation NHLoginViewController

- (NSArray *)array {
    if (!_array) {
        _array = @[@"自我介绍", @"名字： CharlesYaoxin(姚鑫)", @"微信： theseaineye", @"简书： CharlesJF", @"github：Charlesyaoxin"];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"点击👉右边登录";
    
    for (int i = 0; i < self.array.count; i++) {
        UILabel *label = [UILabel new];
        [self.view addSubview:label];
        label.font = kFont(17);
        label.text = self.array[i];
        label.frame = CGRectMake(30, i * 30 + 20, kScreenWidth / 2.0, 30);
        label.adjustsFontSizeToFitWidth = YES;
        
        if (i != 0) {
            
            UIButton *btn = [UIButton new];
            [self.view addSubview:btn];
            [btn setTitle:@"点击复制" forState:UIControlStateNormal];
            btn.layerBorderColor = kRedColor;
            btn.layerBorderWidth = 1.0;
            btn.frame = CGRectMake(label.right + 10, label.y + 3, 80, label.height - 6);
            [btn setTitleColor:kRedColor forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i + 1;
        }
    }
    
    UILabel *alert = [UILabel new];
    [self.view addSubview:alert];
    _alertL = alert;
    alert.font = kFont(18);
    alert.textColor = kRedColor;
    alert.textAlignment = NSTextAlignmentCenter;
    alert.frame = CGRectMake(50, 300, kScreenWidth - 100, 100);
    alert.hidden = YES;
    alert.numberOfLines = 0;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
}

- (void)btnClick:(UIButton *)btn { 
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = @"Charlesyaoxin";
    self.alertL.hidden = NO;
    self.alertL.text = @"已复制到粘贴板";
}
// 用户信息写死的
- (void)rightItemClick {
    NHCustomAlertView *alert = [[NHCustomAlertView alloc] initWithTitle:@"点击登录按钮，您将登录内涵段子，账号信息是写死在本地的。" cancel:@"取消" sure:@"确认登录"];
    [alert showInView:self.view.window];
    
    [alert setupSureBlock:^BOOL{
    
        // 写死的用户信息
        NSDictionary *userInfoDict = @{
                                       @"is_blocking": @(0),
                                       @"session_key": @"b391787a2cd16be0f914259f0cf829a4",
                                       @"media_id": @(0),
                                       @"description": @"\u8fd9\u4e2a\u4eba\u5f88\u61d2\uff0c\u4ec0\u4e48\u4e5f\u6ca1\u6709\u7559\u4e0b",
                                       @"name": @"Charles姚鑫",
                                       @"point": @(100),
                                       @"mobile": @"",
                                       @"gender": @(1),
                                       @"visit_count_zrecent": @(0),
                                       @"verified_agency": @"",
                                       @"bg_img_url": @"http://p3.pstatp.com/origin/bc2000955fc8046e109",
                                       @"verified_content": @"",
                                       @"avatar_url": @"http://p1.pstatp.com/thumb/e580000d5c689f3bd23",
                                       @"followings_count": @(123),
                                       @"followers_count": @(45),
                                       @"user_id": @(50697375933),
                                       @"is_blocked": @(0),
                                       @"user_verified": @(0),
                                       @"screen_name": @"Charles姚鑫"
                                       };
        
        // 登陆
        [[NHUserInfoManager sharedManager] didLoginInWithUserInfo:userInfoDict];
        
        [self pop];
        
        return YES;
    }];
 
#if 0
    
    
    is_following": false,
    "city": "\u5317\u4eac",
    "subscribe_count": 1,
    "user_id": 50697375933,
    "description": "",
    "point": 1,
    "gender": 1,
    "followings": 3,
    "repin_count": 1,
    "user_verified": false,
    "comment_count": 2,
    "name": "Charles129212708",
    "ugc_count": 1,
    "avatar_url": "http://p3.pstatp.com/thumb/3791/5070639578",
    "create_time": 1473218823,
    "notification_count": 0,
    "large_avatar_url": "http://p3.pstatp.com/large/3791/5070639578",
    "followers": 0,
    "new_followers": 0,
    "id": 50697375933,
    "screen_name": "Charles129212708"
#endif
}
@end
