//
//  ShiBanPlayTableViewModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/26.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseViewModel.h"
@class ShiBanPlayTableDateModel;
@interface ShiBanPlayTableViewModel : BaseViewModel
/**
 *  分区行标题
 *
 */
- (NSString*)titleForRow:(NSInteger)row section:(NSInteger)section;
/**
 *  分区行最新集
 *
 */

- (NSString*)newEpisodeForRow:(NSInteger)row section:(NSInteger)section;
/**
 *  每个分区行数
 *
 */
- (NSInteger)episodeCountForSection:(NSInteger)section;
/**
 *  总分区数
 *
 */
- (NSInteger)sectionCount;
/**
 *  分区头
 *
 */
- (NSString*)sectionTitleForSection:(NSInteger)section;
/**
 *  分区行对应模型
 *
 */
- (ShiBanPlayTableDateModel*)modelForRow:(NSInteger)row section:(NSInteger)secton;

- (void)refreshDataCompleteHandle:(void(^)(NSError *error))complete;
@end
