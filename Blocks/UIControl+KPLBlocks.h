//
//  UIControl+KPLBlocks.h
//  开发中用到的文件
//
//  Created by apple on 17/1/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (KPLBlocks)

//  添加事件管理者  --  事件
- (void)kpl_addEventsHandler:(void(^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;

- (void)kpl_removeEventsHandlersForControlEvents:(UIControlEvents)controlEvents;

- (BOOL)kpl_hasEventHandlersForControlEvents:(UIControlEvents)controlEvents;

@end


