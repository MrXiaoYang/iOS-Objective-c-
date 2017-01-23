//
//  SearchModel.m
//  BiliBili
//
//  Created by apple-jd24 on 15/12/13.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SearchModel.h"
#import "SpecialModel.h"
#import "AVModel.h"

#import "SearchViewModel.h"

#import "SearchNetManager.h"

#import "NSString+Tools.h"

@interface SearchViewModel()
@property (nonatomic, strong)NSMutableDictionary* dic;
@end

@implementation SearchViewModel
#pragma mark - 番剧部分
/**
 *  番剧标题
 */
- (NSString*)shiBanTitleWithIndex:(NSInteger)index{
    return [self shiBanWithIndex:index].title;
}
/**
 *  seasonId
 *
 */
- (NSString*)shiBanSeasonIdWithIndex:(NSInteger)index{
    return [self shiBanWithIndex:index].season_id;
}
/**
 *  番剧点击量
 */
- (NSString*)shiBanClickNumWithIndex:(NSInteger)index{
    return [@"点击：" stringByAppendingString:[NSString stringWithFormatNum: [self shiBanWithIndex:index].play_count]];
}
/**
 *  番剧订阅量
 */
- (NSString*)shiBanFavoriteNumWithIndex:(NSInteger)index{
    return [@"订阅：" stringByAppendingString:[NSString stringWithFormatNum: [self shiBanWithIndex:index].favorites]];
}
/**
 *  番剧封面
 */
- (NSURL *)shiBanCoverWithIndex:(NSInteger)index{
    return [NSURL URLWithString: [self shiBanWithIndex:index].cover];
}
/**
 *  番剧最新分集
 */
- (NSString*)shiBanNewEpisodeWithIndex:(NSInteger)index{
    //完结返回全集，否则返回最新集数
    return [[self shiBanWithIndex:index].is_finish isEqualToString:@"1"]?@"全集":[NSString stringWithFormat: @"更新到：%@",[self shiBanWithIndex:index].newest_ep_index];
}
/**
 *  番剧部分总数
 *
 */
- (NSInteger)shiBanCount{
    return [self shiBans].count;
}

/**
 *  拿到番剧部分所有模型
 *
 */
- (NSArray*)shiBans{
    return self.dic[@"bangumi"];
}

/**
 *  拿到番剧对应下标部分的模型
 */
- (SearchShibanModel *)shiBanWithIndex:(NSInteger)index{
    return [self shiBans][index];
}

#pragma mark - 专题部分
/**
 *  专题标题
 */
- (NSString*)specialTitleWithIndex:(NSInteger)index{
    return [self specialWithIndex: index].title;
}
/**
 *  专题描述
 */
- (NSString*)specialDescWithIndex:(NSInteger)index{
    return [self specialWithIndex:index].desc;
}
/**
 *  专题封面
 */
- (NSURL*)specialCoverWithIndex:(NSInteger)index{
    return [NSURL URLWithString: [self specialWithIndex:index].pic];
}
/**
 *  专题spid
 *
 */
- (NSString*)specialSpidWithIndex:(NSInteger)index{
    return [self specialWithIndex: index].spid;
}

- (NSInteger)specialCount{
    return [self specials].count;
}
/**
 *  拿到专题部分所有模型
 *
 */
- (NSArray*)specials{
    return self.dic[@"special"];
}

/**
 *  拿到专题对应下标部分的模型
 */
- (SearchSpecialModel *)specialWithIndex:(NSInteger)index{
    return [self specials][index];
}


#pragma mark - 相关视频部分
/**
 *  封面
 */
- (NSURL*)videoCoverWithIndex:(NSInteger)index{
    return [NSURL  URLWithString:[self videoWithIndex: index].pic];
}
/**
 *  标题
 */
- (NSString*)videoTitleWithIndex:(NSInteger)index{
    return [self videoWithIndex: index].title;
}
/**
 *  up
 */
- (NSString*)videoUpWithIndex:(NSInteger)index{
    return [self videoWithIndex: index].author;
}
/**
 *  播放数
 */
- (NSString*)videoPlayNumWithIndex:(NSInteger)index{
    return [NSString stringWithFormatNum: [self videoWithIndex: index].play];
}
/**
 *  弹幕数
 */
- (NSString*)videoDanMuNumWithIndex:(NSInteger)index{
    return [NSString stringWithFormatNum: [self videoWithIndex: index].video_review];
}
/**
 *  视频部分对应下标的模型
 */
- (AVDataModel*)videoWithIndex:(NSInteger)index{
    return [self videos][index];
}
/**
 *  视频部分所有的模型
 */
- (NSArray*)videos{
    return self.dic[@"video"];
}
/**
 *  视频总数
 */
- (NSInteger)videosCount{
    return [self videos].count;
}


#pragma mark - 其他方法
- (void)refreshDataCompleteHandle:(void(^)(NSError *error))complete{
    [SearchNetManager getSeachParameters:@{@"keyword":self.keyWord} CompletionHandler:^(SearchModel* responseObj, NSError *error) {
        //只有分区不为零的情况下 才进行赋值
        if (responseObj.bangumi.count) {
            self.dic[@"bangumi"] = responseObj.bangumi;
        }
        if (responseObj.special.count) {
            self.dic[@"special"] = responseObj.special;
        }
        if (responseObj.video.count) {
            self.dic[@"video"] = responseObj.video;
        }
        complete(error);
    }];
}

- (instancetype)initWithKeyWord:(NSString*)keyWord{
    if (self = [super init]) {
        self.keyWord = keyWord;
    }
    return self;
}
- (NSMutableDictionary *) dic {
	if(_dic == nil) {
		_dic = [[NSMutableDictionary alloc] init];
	}
	return _dic;
}

@end
