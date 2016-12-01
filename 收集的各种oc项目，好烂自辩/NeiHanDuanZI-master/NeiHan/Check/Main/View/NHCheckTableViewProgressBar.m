//
//  NHCheckTableViewProgressBar.m
//  NeiHan
//
//  Created by Charles on 16/9/6.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHCheckTableViewProgressBar.h"

@interface NHCheckTableViewProgressBar ()
@property (nonatomic, weak) UILabel *leftL;
@property (nonatomic, weak) UILabel *rightL;
@property (nonatomic, weak) CAShapeLayer *leftLayer;
@property (nonatomic, weak) CAShapeLayer *rightLayer;
@end

@implementation NHCheckTableViewProgressBar {
    NHCheckTableViewProgressBarFinishLoadingHandle _finishLoadingHandle;
}

- (void)setUpCheckTableViewProgressBarFinishLoadingHandle:(NHCheckTableViewProgressBarFinishLoadingHandle)finishLoadingHandle {
    _finishLoadingHandle = finishLoadingHandle;
}

+ (instancetype)bar {
    return [[self alloc] init];
}

- (void)showLeftAndRightLabel {
    [self.leftL.layer removeAllAnimations];
    [self.rightL.layer removeAllAnimations];
    self.leftL.frame = CGRectMake(5, self.height / 2.0 - 15, 30, 10);
    self.rightL.frame = CGRectMake(self.width - 35, self.height / 2.0 - 15, 30, 10);
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(0.5);
    scaleAnimation.toValue = @(1.0);
    scaleAnimation.duration = 0.2f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.leftL.layer addAnimation:scaleAnimation forKey:@""];
    [self.rightL.layer addAnimation:scaleAnimation forKey:@""];
    
    // 执行回调
    [self performSelector:@selector(handle) withObject:nil afterDelay:0.5];
    
}

- (void)handle {
    if (_finishLoadingHandle) {
        _finishLoadingHandle();
    }
}

- (void)setLeftScale:(CGFloat)leftScale {
    
    _leftScale = leftScale;
    NSInteger leftDelta = leftScale * 100;
    self.leftL.text = [NSString stringWithFormat:@"%ld%%", leftDelta];
    
    CGFloat height = 10;
    UIRectCorner corner = UIRectCornerAllCorners;
    if (leftScale == 1.0) {
        corner = UIRectCornerAllCorners;
    } else {
        corner = UIRectCornerTopLeft | UIRectCornerBottomLeft;
    }
    
    UIBezierPath *bezierPath0 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, self.height / 2.0 - height / 2.0, 0, height) byRoundingCorners:corner cornerRadii:CGSizeMake(5.f, 5.f)];
    UIBezierPath *bezierPath1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, self.height / 2.0 - height / 2.0, self.width * self.leftScale, height) byRoundingCorners:corner cornerRadii:CGSizeMake(5.f, 5.f)];
    
    CGFloat duration = 0.8;
    [self performSelector:@selector(showLeftAndRightLabel) withObject:nil afterDelay:duration];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = duration;
    animation.fromValue = (__bridge id _Nullable)(bezierPath0.CGPath);
    animation.toValue = (__bridge id _Nullable)(bezierPath1.CGPath);
    [self.leftLayer addAnimation:animation forKey:@""];
}

- (void)setRightScale:(CGFloat)rightScale { 
    _rightScale = rightScale;
    NSInteger rightDelta = rightScale * 100;
    self.rightL.text = [NSString stringWithFormat:@"%ld%%", rightDelta];
  
    CGFloat height = 10;
    CGFloat duration = 0.8;
    UIRectCorner corner = UIRectCornerAllCorners;
    if (rightScale == 1.0) {
        corner = UIRectCornerAllCorners;
    } else {
        corner = UIRectCornerTopRight | UIRectCornerBottomRight;
    }
    
    UIBezierPath *bezierPath0 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.width, self.height / 2.0 - height / 2.0, 0, height) byRoundingCorners:corner cornerRadii:CGSizeMake(5.f, 5.f)];
    UIBezierPath *bezierPath1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.width * ( 1 - self.rightScale), self.height / 2.0 - height / 2.0, self.width * self.rightScale, height) byRoundingCorners:corner cornerRadii:CGSizeMake(5.f, 5.f)];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = duration;
    animation.fromValue = (__bridge id _Nullable)(bezierPath0.CGPath);
    animation.toValue = (__bridge id _Nullable)(bezierPath1.CGPath);
    [self.rightLayer addAnimation:animation forKey:@""];
}

- (UILabel *)leftL {
    if (!_leftL) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _leftL = label;
        label.font = kFont(11);
        label.textColor = [UIColor colorWithRed:1.00f green:0.50f blue:0.64f alpha:1.00f];
    }
    return _leftL;
}

- (UILabel *)rightL {
    if (!_rightL) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _rightL = label;
        label.font = kFont(11);
        label.textColor = [UIColor colorWithRed:0.48f green:0.82f blue:0.90f alpha:1.00f];
    }
    return _rightL;
}

- (CAShapeLayer *)leftLayer {
    if (!_leftLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        [self.layer addSublayer:layer];
        _leftLayer = layer;
        layer.fillColor = [UIColor colorWithRed:1.00f green:0.50f blue:0.64f alpha:1.00f].CGColor;
    }
    return _leftLayer;
}

- (CAShapeLayer *)rightLayer {
    if (!_rightLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        [self.layer addSublayer:layer];
        _rightLayer = layer;
        layer.fillColor = [UIColor colorWithRed:0.48f green:0.82f blue:0.90f alpha:1.00f].CGColor;
    }
    return _rightLayer;
}

@end
