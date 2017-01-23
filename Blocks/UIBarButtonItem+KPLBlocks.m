//
//  UIBarButtonItem+KPLBlocks.m
//  开发中用到的文件
//
//  Created by apple on 17/1/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIBarButtonItem+KPLBlocks.h"
#import <objc/runtime.h>

static const void *KPLBarButtonItemBlockKey = &KPLBarButtonItemBlockKey;

@implementation UIBarButtonItem (KPLBlocks)

#pragma mark --
- (instancetype)kpl_initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemStyle handler:(void (^)(id))handler
{
    self = [self initWithBarButtonSystemItem:systemStyle target:self action:@selector(kpl_handlerAction:)];
    
    if (!self) return nil;
    
    objc_setAssociatedObject(self, KPLBarButtonItemBlockKey, handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return self;
}
#pragma mark --
- (instancetype)kpl_initWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style handler:(void (^)(id))handler
{
    self = [self initWithImage:image landscapeImagePhone:landscapeImagePhone style:style target:self action:@selector(kpl_handlerAction:)];
    
    if (!self) return nil;
    
    objc_setAssociatedObject(self, KPLBarButtonItemBlockKey, handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return self;
}
#pragma mark --
- (instancetype)kpl_initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style handler:(void (^)(id))handler
{
    self = [self initWithImage:image style:style target:self action:@selector(kpl_handlerAction:)];
    
    if (!self) return nil;
    
    objc_setAssociatedObject(self, KPLBarButtonItemBlockKey, handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return self;
}
#pragma mark --
- (instancetype)kpl_initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style handler:(void (^)(id))handler
{
    self = [self initWithTitle:title style:style target:self action:@selector(kpl_handlerAction:)];
    
    if (!self) return nil;
    
    objc_setAssociatedObject(self, KPLBarButtonItemBlockKey, handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return self;
}

#pragma mark - action
- (void)kpl_handlerAction:(id)sender
{
    void (^block)(id sender) = objc_getAssociatedObject(self, KPLBarButtonItemBlockKey);
    
    if (block) {
        block(sender);
    }
}

@end
