//
//  SpecialViewModel.h
//  BiliBili
//
//  Created by apple-jd24 on 15/12/15.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseViewModel.h"
@class SearchSpecialModel, SpecialDateModel;

@interface SpecialViewModel : BaseViewModel
/**
 *  专题封面
 *
 */
- (NSURL*)specialCover;
/**
 *  专题标题
 *
 */
- (NSString*)specialTitle;
/**
 *  专题浏览数
 *
 */
- (NSString*)specialBrowse;
/**
 *  专题订阅
 *
 */
- (NSString*)specialFaverite;
/**
 *  专题描述
 *
 */
- (NSString*)specialDetail;

/**
 *  专题总集数
 *
 */
- (NSInteger)specialcount;

#pragma mark - 专题剧集部分
/**
 *  封面
 *
 */
- (NSURL*)episodeCoverWithIndex:(NSInteger)index;
/**
 *  标题
 *
 */
- (NSString*)episodeTitleWithIndex:(NSInteger)index;
/**
 *  描述
 *
 */
- (NSString*)episodeDetailWithIndex:(NSInteger)index;
/**
 *  模型
 */
- (SpecialDateModel*)episodeWithIndex:(NSInteger)index;

//其他方法
- (void)refreshDataCompleteHandle:(void(^)(NSError *error))complete;
- (instancetype)initWithModel:(SearchSpecialModel*)model;
@end
