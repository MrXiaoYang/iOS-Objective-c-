//
//  NSObject+ViewModel.m
//  TRProject
//
//  Created by tarena on 16/2/18.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "NSObject+ViewModel.h"
//通过运行时,解决Category不能定义属性的弱点
#import <objc/runtime.h>
//dataTaskKey变量 存的是 它自己的地址, 因为是静态的,所以地址不会有重复
static const void *dataTaskKey = &dataTaskKey;
@implementation NSObject (ViewModel)
//通过运行时, 动态绑定实现属性的setter方法
- (void)setDataTask:(NSURLSessionDataTask *)dataTask{
    //参数4:属性的内存管理方式
    objc_setAssociatedObject(self, dataTaskKey, dataTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSURLSessionDataTask *)dataTask{
    return objc_getAssociatedObject(self, dataTaskKey);
}

- (void)getDataWithRequestMode:(RequestMode)requestMode completionHanle:(void (^)(NSError *))completionHandle{}

- (void)resumeTask{
    [self.dataTask resume];
}
- (void)cancelTask{
    [self.dataTask cancel];
}
- (void)suspendTask{
    [self.dataTask suspend];
}
@end
