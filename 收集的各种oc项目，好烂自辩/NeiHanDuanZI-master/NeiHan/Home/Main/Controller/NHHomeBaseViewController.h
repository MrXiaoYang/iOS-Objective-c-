//
//  NHHomeBaseViewController.h
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//  内涵动态，公共列表

#import "NHBaseTableViewController.h"

@class NHBaseRequest;
@interface NHHomeBaseViewController : NHBaseTableViewController
/** 初始化*/
- (instancetype)initWithUrl:(NSString *)url;
/** 初始化*/
- (instancetype)initWithRequest:(NHBaseRequest *)request;
/** 请求数据成功回调*/
@property (nonatomic, copy) void(^homeBaseViewControllerFinishRequestDataHandle)(NSInteger dataCount);
@end
