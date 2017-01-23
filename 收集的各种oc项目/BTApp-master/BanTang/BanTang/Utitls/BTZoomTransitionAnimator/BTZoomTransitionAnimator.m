//
//  BTZoomTransitionAnimator.m
//  BanTang
//
//  Created by Ryan on 16/1/5.
//  Copyright © 2016年 Ryan. All rights reserved.
//

#import "BTZoomTransitionAnimator.h"
#import "BTHomeVC.h"

@implementation BTZoomTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Setup for animation transition
    BTHomeVC *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView    = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    UIView *alphaView = [[UIView alloc] initWithFrame:[transitionContext finalFrameForViewController:toVC]];
    alphaView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:alphaView];
    
    UIImageView *imageView = fromVC.cellImageView;
    [containerView addSubview:imageView];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        imageView.frame = CGRectMake(0, 0, 375, 200);
        imageView.transform = CGAffineTransformMakeScale(1.02, 1.02);
        alphaView.alpha = 0.9;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            alphaView.alpha = 0;
            imageView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            imageView.alpha = 0;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }];
}

@end
