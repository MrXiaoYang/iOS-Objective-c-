//
//  NHAnimationManager.m
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHAnimationManager.h"

@implementation NHAnimationManager


+ (void)addTransformAnimationForView:(UIView *)view {
    
    view.transform = CGAffineTransformMakeScale(0.97, 0.97);
    [UIView animateWithDuration:0.12 animations:^{
        view.transform = CGAffineTransformIdentity;
        view.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
    
    //    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //        [view.layer setValue:@(0) forKeyPath:@"transform.scale"];
    //    } completion:^(BOOL finished) {
    //        [UIView animateWithDuration:0.23 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //            [view.layer setValue:@(1.2) forKeyPath:@"transform.scale"];
    //        } completion:^(BOOL finished) {
    //            [UIView animateWithDuration:0.09 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //                [view.layer setValue:@(.9) forKeyPath:@"transform.scale"];
    //            } completion:^(BOOL finished) {
    //                [UIView animateWithDuration:0.05 delay:0.02 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //                    [view.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
    //                } completion:^(BOOL finished) {
    //
    //                }];
    //            }];
    //        }];
    //    }];
    
    //
    //    view.transform = CGAffineTransformMakeScale(0.93f, 0.93f);
    //
    //
    //    [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
    //        view.maskView.alpha = 1.0;
    //        view.alpha = 1.0;
    //        view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    //    } completion:^(BOOL finished) {
    //
    //    }];
    
    //
    
    //    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    //    animation.duration = 0.35;
    //
    //    NSMutableArray *values = [NSMutableArray array];
    ////    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
    ////    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.15, 1.15, 1.0)]];
    ////    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)]];
    //    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    //
    //
    //        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    //        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)]];
    //        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)]];
    //        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    //
    //    animation.values = values;
    //    [view.layer addAnimation:animation forKey:nil];
    
    
}


/**
 *  抖动某一视图的方法
 */
+ (void)shakeView:(UIView*)viewToShake {
    CGFloat t = 4.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    viewToShake.transform = translateLeft;
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}

@end
