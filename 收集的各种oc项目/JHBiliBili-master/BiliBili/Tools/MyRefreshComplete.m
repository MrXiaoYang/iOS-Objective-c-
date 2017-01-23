//
//  MyRefreshComplet.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/19.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "MyRefreshComplete.h"

@implementation MyRefreshComplete

+ (id)myRefreshHead:(void(^)())block{
    MJRefreshNormalHeader* head = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    head.lastUpdatedTimeLabel.hidden = YES;
    head.automaticallyChangeAlpha = YES;
    [head setTitle:@"再拉，再拉就刷新给你看" forState:MJRefreshStateIdle];
    [head setTitle:@"够了啦，松开人家嘛" forState:MJRefreshStatePulling];
    [head setTitle:@"刷呀刷，好累啊，喵(＾▽＾)" forState:MJRefreshStateRefreshing];
    return head;
}

+ (id)myRefreshFoot:(void(^)())block{
    MJRefreshAutoNormalFooter * foot = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
    foot.automaticallyChangeAlpha = YES;
    [foot setTitle:@"再拉，再拉就刷新给你看" forState:MJRefreshStateIdle];
    [foot setTitle:@"够了啦，松开人家嘛" forState:MJRefreshStatePulling];
    [foot setTitle:@"刷呀刷，好累啊，喵(＾▽＾)" forState:MJRefreshStateRefreshing];
    return foot;
}

@end
