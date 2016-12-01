//
//  BTCommentVC.m
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTCommentVC.h"
#import <Masonry.h>
#import "BTProductManager.h"

@interface BTCommentVC ()

@property (nonatomic, weak) UITextView *textView;

@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation BTCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavItem];
    
    [self setupSubViews];
}

- (void)setupNavItem
{
    self.title = @"发表评论";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tapGestureHanlder)];
    [self.view addGestureRecognizer:tap];
    
    self.view.backgroundColor = kUIColorFromRGB(0xeeeeee);
    
    UIBarButtonItem *leftItem = [UIBarButtonItem rx_barBtnItemWithTitle:@"取消"
                                                          titleColor:[UIColor whiteColor]
                                                           titleFont:BTFont(14)
                                                              target:self
                                                              action:@selector(cancelButtonDidClick)];
    
    UIBarButtonItem *rightItem = [UIBarButtonItem rx_barBtnItemWithTitle:@"发表"
                                                          titleColor:[UIColor whiteColor]
                                                           titleFont:BTFont(14)
                                                              target:self
                                                              action:@selector(commentButtonDidClick)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setupSubViews
{
    UITextView *textView = [[UITextView alloc] init];
    textView.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myTextViewDidChange:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:textView];
    [self.view addSubview:textView];
    self.textView = textView;
    [self.textView becomeFirstResponder];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(200);
    }];
    
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.textColor = kUIColorFromRGB(0xc9c9c9);;
    placeholderLabel.font = BTFont(11);
    placeholderLabel.text = @"  写评论...";
    CGFloat width = [placeholderLabel.text
                     titleSizeWithfontSize:11
                      maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    [self.textView addSubview:placeholderLabel];
    [placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textView.mas_left);
        make.top.mas_equalTo(self.textView.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(width, 15));
    }];
    self.placeholderLabel = placeholderLabel;
    
    UIButton *addProductBtn = [[UIButton alloc] init];
    [addProductBtn setImage:[UIImage imageNamed:@"community_add_product"] forState:UIControlStateNormal];
    [addProductBtn addTarget:self action:@selector(addProductBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addProductBtn];
    [addProductBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(124, 30));
        make.top.mas_equalTo(textView.mas_bottom).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
    }];
}

- (void)cancelButtonDidClick
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)commentButtonDidClick
{
    [self.view endEditing:YES];
    NSLog(@"评论内容: %@",self.textView.text);
    
    void (^successHandler)(BOOL) = ^(BOOL result)
    {
        if (result) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    };
    
    [BTProductManager publishCommentWithObjectID:self.objectID
                                         content:self.textView.text
                                         success:successHandler
                                         failure:nil];
}

- (void)addProductBtnDidClick
{
    [self.view endEditing:YES];
    
    NSLog(@"点击了添加商品按钮");
}

- (void)tapGestureHanlder
{
    [self.view endEditing:YES];
}

- (void)myTextViewDidChange:(NSNotification *)noti
{
    [self.placeholderLabel setHidden:self.textView.text.length > 0];
}

@end
