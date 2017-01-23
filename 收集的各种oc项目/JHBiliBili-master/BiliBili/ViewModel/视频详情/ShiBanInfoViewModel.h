//
//  ShiBanInfoModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/24.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "AVInfoViewModel.h"
@class RecommentShinBanDataModel;
@interface ShiBanInfoViewModel : AVInfoViewModel
//新番详情数组
@property (nonatomic, strong) ShinBanInfoDataModel* shiBan;
/**
 *  当前集
 */
@property (nonatomic, strong) NSNumber* currentEpisode;
//番剧详情
/**
 *  分集
 */
- (NSArray*)shinBanInfoEpisode;

- (NSInteger)shinBanInfoEpisodeCount;

/**
 *  简介
 */
- (NSString*)shinBanInfoIntroduce;
/**
 *  更新时间
 */
- (NSString*)shinBanInfoUpdateTime;
/**
 *  播放数
 */
- (NSString*)shinBanInfoPlayNum;
/**
 *  弹幕数
 */
- (NSString*)shinBanInfodanMuNum;
/**
 *  封面
 *
 */
- (NSURL*)shiBanCover;
/**
 *  标题
 *
 */
- (NSString*)shiBanTitle;

/**
 *  当前集数
 */
- (NSString *)indexToTitle;

- (void)setAVData:(RecommentShinBanDataModel *)shiBanData;
@end
