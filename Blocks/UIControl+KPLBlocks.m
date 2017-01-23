//
//  UIControl+KPLBlocks.m
//  开发中用到的文件
//
//  Created by apple on 17/1/23.
//  Copyright © 2017年 apple. All rights reserved.
//




#import "UIControl+KPLBlocks.h"
@import ObjectiveC.runtime;

static const void *KPLControlHandlerKey = &KPLControlHandlerKey;

@interface KPLControlWrapper : NSObject <NSCopying>

- (instancetype)initWithHandler:(void(^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;

@property (nonatomic) UIControlEvents controlEvents;

@property (nonatomic, strong) void (^handler)(id sender);

@end

@implementation KPLControlWrapper

- (instancetype)initWithHandler:(void (^)(id))handler forControlEvents:(UIControlEvents)controlEvents
{
    self = [super init];
    
    if (!self) return nil;
    
    self.handler = handler;
    self.controlEvents = controlEvents;
    
    return self;
}
- (id)copyWithZone:(NSZone *)zone
{
    return [[KPLControlWrapper alloc] initWithHandler:self.handler forControlEvents:self.controlEvents];
}
- (void)kpl_invoke:(id)sender
{
    self.handler(sender);
}
@end

@implementation UIControl (KPLBlocks)

- (void)kpl_addEventsHandler:(void (^)(id))handler forControlEvents:(UIControlEvents)controlEvents
{
    //  获取所有事件
    NSMutableDictionary *events = objc_getAssociatedObject(self, KPLControlHandlerKey);
    //  如果不存在事件
    if (!events) {
        //  初始化
        events = [NSMutableDictionary dictionary];
        //  进行关联
        objc_setAssociatedObject(self, KPLControlHandlerKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    //  设置键
    NSNumber *key = @(controlEvents);
    //  获取值
    NSMutableSet *handlers = events[key];
    
    if (!handlers) {//  handlers不存在
        //  初始化
        handlers = [NSMutableSet set];
        //  赋值
        events[key] = handlers;
    }
    
    //  创建 target 目标对象
    KPLControlWrapper *target = [[KPLControlWrapper alloc] initWithHandler:handler forControlEvents:controlEvents];
    
    [handlers addObject:target];
    
    [self addTarget:target action:@selector(kpl_invoke:) forControlEvents:controlEvents];
    
}
- (void)kpl_removeEventsHandlersForControlEvents:(UIControlEvents)controlEvents
{
    //  获取所有事件
    NSMutableDictionary *events = objc_getAssociatedObject(self, KPLControlHandlerKey);
    
    if (!events) {
        //  @"事件管理者" : @"事件类型"
        events = [NSMutableDictionary dictionary];
        //  关联
        objc_setAssociatedObject(self, KPLControlHandlerKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSNumber *key = @(controlEvents);
    
    NSSet *handlers = events[key];
    
    if (!handlers) return;
    
    [handlers enumerateObjectsUsingBlock:^(id  _Nonnull sender, BOOL * _Nonnull stop) {
        
        [self removeTarget:sender action:NULL forControlEvents:controlEvents];
    }];
    
    
    [events removeObjectForKey:key];
}
- (BOOL)kpl_hasEventHandlersForControlEvents:(UIControlEvents)controlEvents
{
    NSMutableDictionary *events = objc_getAssociatedObject(self, KPLControlHandlerKey);
    
    if (!events) {
        events = [NSMutableDictionary dictionary];
        
        objc_setAssociatedObject(self, KPLControlHandlerKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSNumber *key = @(controlEvents);
    
    NSSet *handlers = events[key];
    
    if (!handlers) return NO;
    
    return !!handlers.count;
}

@end


