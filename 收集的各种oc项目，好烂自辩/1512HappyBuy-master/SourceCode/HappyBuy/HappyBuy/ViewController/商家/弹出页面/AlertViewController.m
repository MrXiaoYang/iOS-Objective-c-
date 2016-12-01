//
//  AlertViewController.m
//  HappyBuy
//
//  Created by jiyingxin on 16/4/10.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()

@end

@implementation AlertViewController

#pragma mark - 代理UIPopoverPresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(nonnull UITraitCollection *)traitCollection{
    return UIModalPresentationNone;
}

#pragma mark - 懒加载
- (CGSize)contentSize{
    if ([self.delegate respondsToSelector:@selector(contentSizeForAlertViewController:)]) {
        _contentSize = [self.delegate contentSizeForAlertViewController:self];
    }
    return _contentSize;
}

- (UIEdgeInsets)edgeInsets{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsForAlertViewController:)]) {
        _edgeInsets = [self.delegate edgeInsetsForAlertViewController:self];
    }
    return _edgeInsets;
}

#pragma mark - 生命周期
- (instancetype)initWithSourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect delegate:(id<AlertViewControllerDelegate>)delegate{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
        self.popoverPresentationController.delegate = self;
        self.popoverPresentationController.sourceRect = sourceRect;
        self.popoverPresentationController.sourceView = sourceView;
        
        self.delegate = delegate;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.preferredContentSize = CGSizeMake(self.contentSize.width + self.edgeInsets.left + self.edgeInsets.right,
                                           self.contentSize.height + self.edgeInsets.top + self.edgeInsets.bottom);
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
