//
//  BTLoginVC.m
//  BanTang
//
//  Created by 沈文涛 on 15/12/6.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTLoginVC.h"

@interface BTLoginVC ()

- (IBAction)loginBtnClick:(id)sender;
- (IBAction)cancelBtnClick:(id)sender;
- (IBAction)wechatLogin:(id)sender;
- (IBAction)weiboLogin:(id)sender;
- (IBAction)qqLogin:(id)sender;

@end

@implementation BTLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)loginBtnClick:(id)sender {
    
}

- (IBAction)cancelBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)wechatLogin:(id)sender {
    
}

- (IBAction)weiboLogin:(id)sender {
    
}

- (IBAction)qqLogin:(id)sender {
    
}
@end
