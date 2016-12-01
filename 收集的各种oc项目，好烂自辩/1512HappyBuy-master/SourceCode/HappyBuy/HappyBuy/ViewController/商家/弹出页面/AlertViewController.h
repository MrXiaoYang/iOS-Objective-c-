//
//  AlertViewController.h
//  HappyBuy
//
//  Created by jiyingxin on 16/4/10.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class AlertViewController;

@protocol AlertViewControllerDelegate <NSObject>
@optional
- (CGSize)contentSizeForAlertViewController:(AlertViewController *)alertViewController;
- (UIEdgeInsets)edgeInsetsForAlertViewController:(AlertViewController *)alertViewController;

@end



@interface AlertViewController : UIViewController<UIPopoverPresentationControllerDelegate>

- (instancetype)initWithSourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect delegate:(nullable id<AlertViewControllerDelegate>)delegate;

@property (nonatomic) CGSize contentSize;

@property (nonatomic) UIEdgeInsets edgeInsets;

@property (nonatomic, weak, nullable) id<AlertViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END