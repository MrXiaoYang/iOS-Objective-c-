//
//  NSObject+ViewModel.h
//  BaseProject
//
//  Created by yingxin on 15/12/14.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ViewModel)

typedef void(^CompletionHandle)(NSError *error);

@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong) NSURLSessionDataTask *dataTask;

//获取更多
- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle;
//刷新
- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle;
//获取数据
- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle;
- (void)cancelTask;  //取消任务
- (void)suspendTask; //暂停任务
- (void)resumeTask;  //继续任务

@end
