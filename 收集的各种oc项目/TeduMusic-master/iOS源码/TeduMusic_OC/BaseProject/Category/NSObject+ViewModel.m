//
//  NSObject+ViewModel.m
//  BaseProject
//
//  Created by yingxin on 15/12/14.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "NSObject+ViewModel.h"

@implementation NSObject (ViewModel)

@dynamic dataArr;
@dynamic dataTask;

//获取更多
- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle{
    
}
//刷新
- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle{
    
}
//获取数据
- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    
}

- (void)cancelTask{
    [self.dataTask cancel];
}

- (void)suspendTask{
    [self.dataTask suspend];
}

- (void)resumeTask{
    [self.dataTask resume];
}

@end
