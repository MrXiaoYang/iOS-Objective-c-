//
//  UIButton+Addition.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Com.Charles. All rights reserved.
//

#import "UIButton+Addition.h"
#import <objc/runtime.h>

typedef void(^ActionBlock)();

@implementation UIButton (Addition) 

static char buttonBlockKey;

+ (instancetype)buttonWithImagename:(NSString *)imagename
                     hightImagename:(NSString *)hightImagename
                        bgImagename:(NSString *)bgImagename
                             target:(id)target
                             action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    if (target && action) {
        
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (imagename) {
        
        [button setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    }
    if (hightImagename) {
        
        [button setImage:[UIImage imageNamed:hightImagename] forState:UIControlStateNormal];
    }
    
    
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentMode = UIViewContentModeCenter;
    return button;

}

+ (instancetype)buttonWithImagename:(NSString *)imagename
                     hightImagename:(NSString *)hightImagename
                        bgImagename:(NSString *)bgImagename
                         touchBlock:(void (^)())block {
    
    
    UIButton *button = [self buttonWithImagename:imagename hightImagename:hightImagename bgImagename:bgImagename target:self action:@selector(btnTouch:)];
    button.block = block;
    return button;
}

+ (void)btnTouch:(UIButton *)button {
    if (button.block) {
        button.block();
    }
}

+ (instancetype)buttonWithTitle:(NSString *)title
                    normalColor:(UIColor *)normalColor
                  selectedColor:(UIColor *)selectedColor
                       fontSize:(CGFloat)fontSize
                     touchBlock:(void (^)())block {
    
    UIButton *button = [self buttonWithTitle:title
                                 normalColor:normalColor
                               selectedColor:selectedColor
                                    fontSize:fontSize
                                      target:self
                                      action:@selector(btnTouch:)];
    button.block = block;
    return button;
}

+ (instancetype)buttonWithTitle:(NSString *)title normalColor:(UIColor *)normalColor diableColor:(UIColor *)diableColor fontSize:(CGFloat)fontSize target:(id)target action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] init];
    if (target && action) {
        
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (normalColor && title) {
        [button setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (diableColor && title) {
        [button setTitleColor:diableColor forState:UIControlStateDisabled];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentMode = UIViewContentModeCenter;
    
    return button;
}

+ (instancetype)buttonWithTitle:(NSString *)title
                    normalColor:(UIColor *)normalColor
                  selectedColor:(UIColor *)selectedColor
                       fontSize:(CGFloat)fontSize
                         target:(id)target
                         action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] init];
    if (target && action) {
        
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (normalColor && title) {
        [button setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (selectedColor && title) {
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentMode = UIViewContentModeCenter;
    
    return button;
}

- (void)setBlock:(ActionBlock)block {
    objc_setAssociatedObject(self, &buttonBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ActionBlock)block {
    return objc_getAssociatedObject(self, &buttonBlockKey);
}

@end
