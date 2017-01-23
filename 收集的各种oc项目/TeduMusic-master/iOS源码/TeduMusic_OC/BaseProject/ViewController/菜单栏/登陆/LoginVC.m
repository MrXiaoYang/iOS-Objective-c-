//
//  LoginVC.m
//  BaseProject
//
//  Created by yingxin on 15/12/30.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "LoginVC.h"
#import "ThirdLoginView.h"
#import "RegisterCell.h"
#import <TPKeyboardAvoidingTableView.h>

@interface LoginVC ()<ThirdLoginViewDelegate, UITableViewDelegate, UITableViewDataSource, RegisterCellDelegate>
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ThirdLoginView *loginView = [ThirdLoginView thirdLoginViewWithDelegate:self];
    [self.view addSubview:loginView];
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kThirdViewHeight);
    }];
    
    [Factory addShowMenuBarItem:self];
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
//    redView.backgroundColor = [UIColor redColor];
    _tableView.tableFooterView =redView;
}

- (void)thirdLoginView:(ThirdLoginView *)thirdLoginView selectLoginType:(LoginType)type{
    DDLogError(@"%s",__func__);
}


- (void)textChangedInRegisterCell:(RegisterCell *)cell{
    NSLog(@"textChangedInRegisterCell %@", cell.tf.text);
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RegisterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
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
