//
//  DownLoadViewModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/12/5.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseViewModel.h"

@interface DownLoadViewModel : BaseViewModel
- (NSInteger)taskCount;
- (NSString*)taskNameWithIndex:(NSInteger)index;
- (NSString*)taskAidWithIndex:(NSInteger)index;
- (NSString*)taskStatusWithIndex:(NSInteger)index;
- (float)taskProgressWithIndex:(NSInteger)index;

- (void)cancelTaskWithIndex:(NSInteger)index;
- (void)restartTaskWithIndex:(NSInteger)index;

- (BOOL)taskIsDownLoadOverWithIndex:(NSInteger)index;
- (BOOL)taskIsPauseWithIndex:(NSInteger)index;
- (BOOL)taskIsCurrentTaskWithIndex:(NSInteger)index;

- (NSMutableDictionary *)taskWithIndex:(NSInteger)index;
- (NSInteger)taskIndexWithAid:(NSString*)aid;
- (NSURLSessionDownloadTask*)currentDownLoadTask;
@end
