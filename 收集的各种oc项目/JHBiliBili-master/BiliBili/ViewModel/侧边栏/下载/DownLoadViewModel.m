//
//  DownLoadViewModel.m
//  BiliBili
//
//  Created by apple-jd44 on 15/12/5.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseNetManager.h"
#import "AVInfoNetManager.h"

#import "DownLoadViewModel.h"

@interface DownLoadViewModel ()
@end

@implementation DownLoadViewModel
#pragma mark - 公用方法
/**
 *  任务总数
 *
 */
- (NSInteger)taskCount{
    return [[UserDefaultDownLoadManager shareDownLoadManager] downLoadDic].count;
}
/**
 *  任务名
 *
 */
- (NSString*)taskNameWithIndex:(NSInteger)index{
    return [self taskWithIndex:index][@"name"];
}

/**
 *  拿到当前的下载任务
 *
 */
- (NSURLSessionDownloadTask*)currentDownLoadTask{
    return [[BaseNetManager sharedAFURLManager] downloadTasks].firstObject;
}
/**
 *  任务进度
 *
 */
- (float)taskProgressWithIndex:(NSInteger)index{
    return [self taskIsDownLoadOverWithIndex:index]?1:0;
}

- (NSInteger)taskIndexWithAid:(NSString*)aid{
    NSNumber* num = [[UserDefaultDownLoadManager shareDownLoadManager] mutableDownLoadDicWithKey:aid][@"index"];
    return num.integerValue;
}

/**
 *  任务状态
 *
 */

- (NSString*)taskStatusWithIndex:(NSInteger)index{
    return [self taskWithIndex:index][@"status"];
}

/**
 *  任务是否处于暂停状态
 *
 */
- (BOOL)taskIsPauseWithIndex:(NSInteger)index{
    return [[self taskWithIndex:index][@"status"] isEqualToString:@"downsuspand"];
}


/**
 *  任务是否能够下载
 *
 */
- (BOOL)taskIsCurrentTaskWithIndex:(NSInteger)index{
    return [[self taskWithIndex: index][@"aid"] isEqualToString: [self currentDownLoadTaskAid]];
}


/**
 *  任务是否处于完成状态
 *
 */

- (BOOL)taskIsDownLoadOverWithIndex:(NSInteger)index{
    return [[self taskWithIndex:index][@"status"] isEqualToString:@"downloadover"];
}

/**
 *  任务aid
 *
 */
- (NSString*)taskAidWithIndex:(NSInteger)index{
    return [self taskWithIndex:index][@"aid"];
}

/**
 *  任务恢复数据
 *
 */

- (NSData*)taskResumeDataWithIndex:(NSInteger)index{
    return [[self taskWithIndex:index][@"resumeData"] dataUsingEncoding:NSUTF8StringEncoding];
}
/**
 *  取消任务
 *
 */
- (void)cancelTaskWithIndex:(NSInteger)index{
    __weak typeof(self)weakSelf = self;
    [[self currentDownLoadTask] cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        NSMutableDictionary* mutableDic = [weakSelf taskWithIndex:index];
        //写入恢复数据
        mutableDic[@"resumeData"] = [[NSString alloc] initWithData:resumeData encoding:NSUTF8StringEncoding];
        //更新状态
        mutableDic[@"status"] = @"downsuspand";
        [[UserDefaultDownLoadManager shareDownLoadManager] updateDownLoadDicWithKey:mutableDic[@"aid"] Obj:mutableDic];
    }];
}
/**
 *  重启状态
 *
 */
- (void)restartTaskWithIndex:(NSInteger)index{
    
    NSMutableDictionary* MDic = [self taskWithIndex: index];
    //下标不存在
    if (MDic == nil) {
        return;
    }
    
    VideoModel* model = [NSKeyedUnarchiver unarchiveObjectWithFile:[kArchPath stringByAppendingPathComponent:  [self videoModelPathWithIndex: index]]];
    //更新状态
    MDic[@"status"] = @"downloading";
    [[UserDefaultDownLoadManager shareDownLoadManager] updateDownLoadDicWithKey:MDic[@"aid"] Obj:MDic];
    
    [AVInfoNetManager DownVideoWithDic:@{@"aid": MDic[@"aid"], @"vm":model, @"quality":MDic[@"quality"],@"resumeData":MDic[@"resumeData"]?MDic[@"resumeData"]:@""} completionHandler:^(NSDictionary* responseObj, NSError *error) {
    //下载完成 下载信息写入userDefault 自动开启下一个任务的下载
        [ArchiverObj archiveWithObj:responseObj[@"danmuobj"] path: [kDownloadPath stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.arch", MDic[@"cid"]]]];
        MDic[@"status"] = responseObj[@"status"];
        MDic[@"videopath"] = responseObj[@"videopath"];
        [[UserDefaultDownLoadManager shareDownLoadManager] updateDownLoadDicWithKey:MDic[@"aid"] Obj:MDic];
        [self restartTaskWithIndex: index + 1];
    }];

}

/**
 *  从下标拿到任务
 *
 */

- (NSMutableDictionary *)taskWithIndex:(NSInteger)index{
    return [[UserDefaultDownLoadManager shareDownLoadManager] mutableDownLoadDicWithIndex:index];
}


#pragma mark - 私有方法

/**
 *  任务清晰度
 *
 */
- (NSString*)taskQualityWithIndex:(NSInteger)index{
    return [self taskWithIndex:index][@"quality"];
}

/**
 *  当前正在下载任务的aid
 *
 */
- (NSString*)currentDownLoadTaskAid{
    return [self currentDownLoadTask].taskDescription;
}
/**
 *  当前正在下载任务的video模型的路径
 *
 */
- (NSString*)videoModelPathWithIndex:(NSInteger)index{
    return [self taskWithIndex: index][@"vmpath"];
}

@end
