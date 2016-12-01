//
//  FindViewModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/4.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseViewModel.h"
#import "FindNetManager.h"
@class AVDataModel;
@interface FindViewModel : BaseViewModel
//关键词
- (NSString*)keyWordForRow:(NSInteger)row;
- (NSString*)statusWordForRow:(NSInteger)row;
- (NSInteger)rankArrConut;
//热搜图片
- (NSURL*)rankCoverForNum:(NSInteger)num;
- (NSString*)coverKeyWordForNum:(NSInteger)num;

//排行
- (NSURL*)sectionRankCoverWithIndex:(NSInteger)index;
- (NSString*)sectionRankTitleWithIndex:(NSInteger)index;
- (NSString*)sectionRankPlayCountWithIndex:(NSInteger)index;
- (NSString*)sectionRankDanMuCountWithIndex:(NSInteger)index;
- (NSString*)sectionRankUpNameWithIndex:(NSInteger)index;
- (AVDataModel*)sectionModelWithIndex:(NSInteger)index;
- (NSInteger)sectionCount;
//其它
- (void)refreshDataCompleteHandle:(void(^)(NSError *error))complete;
- (void)refreshSection:(NSString*)section style:(NSString*)style CompleteHandle:(void(^)(NSError *error))complete;
@end
