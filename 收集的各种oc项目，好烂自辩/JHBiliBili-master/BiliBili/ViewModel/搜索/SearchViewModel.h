//
//  SearchModel.h
//  BiliBili
//
//  Created by apple-jd24 on 15/12/13.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseViewModel.h"
@class SearchShibanModel, AVDataModel, SearchSpecialModel;

@interface SearchViewModel : BaseViewModel
@property (nonatomic, strong)NSString* keyWord;


//番剧部分
/**
 *  番剧标题
 */
- (NSString*)shiBanTitleWithIndex:(NSInteger)index;
/**
 *  番剧点击量
 */
- (NSString*)shiBanClickNumWithIndex:(NSInteger)index;
/**
 *  番剧订阅量
 */
- (NSString*)shiBanFavoriteNumWithIndex:(NSInteger)index;
/**
 *  番剧封面
 */
- (NSURL*)shiBanCoverWithIndex:(NSInteger)index;
/**
 *  番剧最新分集
 */
- (NSString*)shiBanNewEpisodeWithIndex:(NSInteger)index;
/**
 *  番剧SeasonId
 *
 */
- (NSString*)shiBanSeasonIdWithIndex:(NSInteger)index;
/**
 *  番剧数
 */
- (NSInteger)shiBanCount;
/**
 *  番剧模型
 */
- (SearchShibanModel *)shiBanWithIndex:(NSInteger)index;


//专题部分
/**
 *  专题标题
 */
- (NSString*)specialTitleWithIndex:(NSInteger)index;
/**
 *  专题描述
 */
- (NSString*)specialDescWithIndex:(NSInteger)index;
/**
 *  专题封面
 */
- (NSURL*)specialCoverWithIndex:(NSInteger)index;

/**
 *  专题spid
 *
 */
- (NSString*)specialSpidWithIndex:(NSInteger)index;

/**
 *  专题模型
 *
 */

- (SearchSpecialModel *)specialWithIndex:(NSInteger)index;

/**
 *  专题数
 */
- (NSInteger)specialCount;



//相关视频部分
/**
 *  封面
 */
- (NSURL*)videoCoverWithIndex:(NSInteger)index;
/**
 *  标题
 */
- (NSString*)videoTitleWithIndex:(NSInteger)index;
/**
 *  up
 */
- (NSString*)videoUpWithIndex:(NSInteger)index;
/**
 *  播放数
 */
- (NSString*)videoPlayNumWithIndex:(NSInteger)index;
/**
 *  弹幕数
 */
- (NSString*)videoDanMuNumWithIndex:(NSInteger)index;
/**
 *  视频数
 */
- (NSInteger)videosCount;

- (AVDataModel*)videoWithIndex:(NSInteger)index;

//其他方法
- (void)refreshDataCompleteHandle:(void(^)(NSError *error))complete;
- (instancetype)initWithKeyWord:(NSString*)keyWord;
@end
