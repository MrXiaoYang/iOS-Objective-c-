//
//  UIScrollView+Refresh.m
//  HappyBuy
//
//  Created by tarena on 16/3/28.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)
- (void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock)block{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        !block ?: block();
    }];
}
- (void)beginHeaderRefresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_header beginRefreshing];
    }); 
}
- (void)endHeaderRefresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_header endRefreshing];
    });
}

- (void)addAutoFooterRefresh:(MJRefreshComponentRefreshingBlock)block{
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        !block ?: block();
    }];
}
- (void)addBackFooterRefresh:(MJRefreshComponentRefreshingBlock)block{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        !block ?: block();
    }];
}
- (void)beginFooterRefresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_footer beginRefreshing];
    });
}
- (void)endFooterRefresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_footer endRefreshing];
    });
}

@end










