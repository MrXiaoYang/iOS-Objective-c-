//
//  ShinBanInfoModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/7.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseModel.h"
#import "TagModel.h"

/**
 *  番剧详情
 */
@class episodesModel, ShinBanInfoDataModel;

@interface ShinBanInfoModel : BaseModel
@property (nonatomic, strong) ShinBanInfoDataModel* result;
@end

@interface ShinBanInfoDataModel : BaseModel
//名称
@property (nonatomic, strong)NSString* bangumi_title;
//staff
@property (nonatomic, strong)NSString* staff;
//播放数
@property (nonatomic, strong)NSString* play_count;
//弹幕数
@property (nonatomic, strong)NSString* danmaku_count;
//更新日期
@property (nonatomic, strong)NSString* weekday;
//封面
@property (nonatomic, strong)NSString* cover;
//分集
@property (nonatomic, strong)NSArray<episodesModel*>* episodes;

//是否完结 0 1
@property (nonatomic, assign)NSInteger is_finish;
//tag
@property (nonatomic, strong)NSArray<TagModel*>* tag2s;

//其它系列
@property (nonatomic, strong)NSArray* seasons;

//当前季名称
@property (nonatomic, strong)NSString* title;
//番剧简介
@property (nonatomic, strong)NSString* evaluate;

//@property (nonatomic, strong)NSArray* related_seasons;
//别名
//@property (nonatomic, strong)NSString* brief;
//@property (nonatomic, strong)NSString* alias;
//@property (nonatomic, strong)NSString* watchingCount;
//@property (nonatomic, strong)NSNumber* viewRank;
//@property (nonatomic, strong)NSString* coins;
//@property (nonatomic, strong)NSString* season_title;
//@property (nonatomic, strong)NSString* bangumi_id;
//@property (nonatomic, strong)NSArray* tags;
//@property (nonatomic, strong)NSString* newest_ep_index;
//@property (nonatomic, strong)NSString* favorites;
//@property (nonatomic, strong)NSString* allow_download;
//@property (nonatomic, strong)NSString* area;
//@property (nonatomic, strong)NSString* squareCover;
//@property (nonatomic, strong)NSString* total_count;
//@property (nonatomic, strong)NSString* newest_ep_id;
//@property (nonatomic, strong)NSString* pub_time;
//@property (nonatomic, strong)NSDictionary* user_season;
//@property (nonatomic, strong)NSNumber* arealimit;
//@property (nonatomic, strong)NSString* season_id;
//@property (nonatomic, strong)NSString* share_url;
//@property (nonatomic, strong)NSArray* actor;
//@property (nonatomic, strong)NSString* allow_bp;
@end

//分集模型
@interface episodesModel : BaseModel
//分集
@property (nonatomic, strong)NSString* index;
//av号
@property (nonatomic, strong)NSString* av_id;
//cid号
@property (nonatomic, strong)NSString* av_cid;
//标题
@property (nonatomic, strong)NSString* index_title;

//@property (nonatomic, strong)NSDictionary* up;
//@property (nonatomic, strong)NSString* coins;
//@property (nonatomic, strong)NSString* episode_id;
//弹幕号
//@property (nonatomic, strong)NSString* danmaku;
//@property (nonatomic, strong)NSString* cover;
//@property (nonatomic, strong)NSString* is_webplay;
//@property (nonatomic, strong)NSString* page;
//@property (nonatomic, strong)NSString* update_time;
@end

