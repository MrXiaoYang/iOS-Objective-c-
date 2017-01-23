//
//  UIViewController+Loading.h
//  NeiHan
//
//  Created by Charles on 16/5/15.
//  Copyright © 2016年 Com.Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Loading)

- (UIView *)loadingView;

- (void)showLoadingViewWithFrame:(CGRect)frame;

- (void)showLoadingView;

- (void)hideLoadingView;

@end
