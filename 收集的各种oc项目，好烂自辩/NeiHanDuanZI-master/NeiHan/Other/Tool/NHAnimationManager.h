//
//  NHAnimationManager.h
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NHAnimationManager : NSObject


/**
 *  为某个视图添加
 */
+ (void)addTransformAnimationForView:(UIView *)view;

/**
 *  让某一个视图抖动
 *
 *  @param viewToShake 需要抖动的视图
 */
+ (void)shakeView:(UIView*)viewToShake;
@end
