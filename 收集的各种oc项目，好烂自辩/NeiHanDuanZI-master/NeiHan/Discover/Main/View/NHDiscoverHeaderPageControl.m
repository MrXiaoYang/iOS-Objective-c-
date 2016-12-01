//
//  NHDiscoverHeaderPageControl.m
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDiscoverHeaderPageControl.h"

@interface NHDiscoverHeaderPageControl ()

/** 当前索引的layer*/
@property (nonatomic, weak)     CAShapeLayer *selectedLayer;
/** 底部layer*/
@property (nonatomic, strong)   CAShapeLayer *showPageLayer;
/** 用来记录前一个path 用于下次动画*/
@property (nonatomic, strong)  UIBezierPath *prePath;
@end

@implementation NHDiscoverHeaderPageControl

+ (instancetype)pageControl {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _pageWidth = 20;
        _pageSpace = 4;
        _normalItemColor = kOrangeColor;
        _selectedItemColor = kRedColor;
        _numberOfItems = 0;
    }
    return self;
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    [self.layer insertSublayer:self.selectedLayer above:self.showPageLayer];
}

- (CAShapeLayer *)showPageLayer {
    if (!_showPageLayer) {
        CAShapeLayer *showPageLayer = [CAShapeLayer layer];
        [self.layer addSublayer:showPageLayer];
        _showPageLayer = showPageLayer;
        _showPageLayer.strokeColor = self.normalItemColor.CGColor;
        _showPageLayer.lineWidth = 4;
    }
    return _showPageLayer;
}

- (CAShapeLayer *)selectedLayer {
    if (!_selectedLayer) {
        CAShapeLayer *selectedLayer = [CAShapeLayer layer];
        [self.layer addSublayer:selectedLayer];
        _selectedLayer = selectedLayer;
        selectedLayer.strokeColor = self.selectedItemColor.CGColor;
        selectedLayer.lineWidth = 5;
    }
    return _selectedLayer;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 设置选中layer的动画
    
    CGFloat delta = self.width -  self.numberOfItems * self.pageWidth + (self.numberOfItems - 1) * self.pageSpace - 15;
    [path moveToPoint:CGPointMake(currentIndex  * self.pageWidth + currentIndex * self.pageSpace + delta, 5)];
    [path addLineToPoint:CGPointMake((currentIndex + 1) * self.pageWidth + currentIndex * self.pageSpace + delta , 5)];
    
    // path(平移动画)
    CGFloat duration = 1.0;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = duration;
    animation.fromValue = (__bridge id _Nullable)(self.prePath.CGPath);
    animation.toValue = (__bridge id _Nullable)(path.CGPath);
    [self.selectedLayer addAnimation:animation forKey:@""];
    
    self.prePath = path;
}

- (void)setNumberOfItems:(NSInteger)numberOfItems {
    _numberOfItems = numberOfItems;
    if (self.pageWidth * numberOfItems + self.pageSpace * (numberOfItems - 1) > self.frame.size.width) {
        self.pageWidth = (self.frame.size.width - self.pageSpace * (numberOfItems - 1)) / numberOfItems;
    }
    CGFloat originX = 0;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 内容充不满，需要靠右边对齐
    CGFloat delta = self.width -  numberOfItems * self.pageWidth + (numberOfItems - 1) * self.pageSpace - 15;
    for (int i = 0; i < numberOfItems; i++) {
        originX = i * self.pageSpace + self.pageWidth * i + delta;
        [path moveToPoint:CGPointMake(originX, 5)];
        [path addLineToPoint:CGPointMake(originX + self.pageWidth, 5)];
        path.lineWidth = 5;
        if (i == 0) {
            self.prePath = path;
            self.selectedLayer.path = self.prePath.CGPath;
        }
    }
    self.showPageLayer.path = path.CGPath;
}
@end
