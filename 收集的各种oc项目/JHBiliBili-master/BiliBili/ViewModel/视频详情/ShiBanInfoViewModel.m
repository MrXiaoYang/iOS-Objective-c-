//
//  ShiBanInfoModel.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/24.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ShiBanInfoViewModel.h"

#import "ShinBanModel.h"

#import "VideoNetManager.h"

#import "NSString+Tools.h"

@interface ShiBanInfoViewModel ()
@property (nonatomic, strong) RecommentShinBanDataModel* rm;
@property (nonatomic, strong) NSString* videoAid;
@end

@implementation ShiBanInfoViewModel

- (NSInteger)shinBanInfoEpisodeCount{
    return self.shiBan.episodes.count;
}

- (NSArray*)shinBanInfoEpisode{
    return self.shiBan.episodes;
}

- (NSString*)shinBanInfoIntroduce{
    return self.shiBan.evaluate;
}
- (NSString*)shinBanInfoUpdateTime{
    if (self.shiBan.is_finish) {
        return @"已完结";
    }else if(self.shiBan.weekday && ![self.shiBan.weekday isEqualToString:@"-1"]){
        return [NSString stringWithFormat:@"连载中，每%@更新",@{@"1":@"周一",@"2":@"周二",@"3":@"周三",@"4":@"周四",@"5":@"周五",@"6":@"周六",@"0":@"周日"}[self.shiBan.weekday]];
    }
    return nil;
}
- (NSString*)shinBanInfoPlayNum{
    return [NSString stringWithFormatNum: self.shiBan.play_count.integerValue];
}
- (NSString*)shinBanInfodanMuNum{
    return [NSString stringWithFormatNum:self.shiBan.danmaku_count.integerValue];
}
- (NSURL*)shiBanCover{
    return [NSURL URLWithString:self.rm.cover];
}
- (NSString*)shiBanTitle{
    return self.rm.title;
}

- (BOOL)isShiBan{
    return YES;
}

/**
 *  当前集数下标转aid
 *
 */
- (NSString *)videoAid{
    return self.shiBan.episodes[self.currentEpisode.integerValue].av_id;
}

- (NSString *)indexToTitle{
    return self.shiBan.episodes[self.currentEpisode.integerValue].index;
}

- (void)setAVData:(RecommentShinBanDataModel *)shiBanData{
    self.rm = shiBanData;
}

- (void)refreshDataCompleteHandle:(void (^)(NSError *))complete{
    [AVInfoNetManager GetShiBanInfoWithParameter:self.rm.season_id completionHandler:^(ShinBanInfoModel* responseObj, NSError *error) {
        NSMutableArray* arr = [NSMutableArray array];
        //获取该新番所有分集
        NSMutableArray<episodesModel*>* epArr = [responseObj.result.episodes mutableCopy];
        [epArr enumerateObjectsUsingBlock:^(episodesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arr addObject: [VideoNetManager GetCIDWithParameter:obj.av_id completionHandler:^(id responseObj, NSError *error) {
                //为分集添加cid
                epArr[idx].av_cid = [CIDModel mj_objectWithKeyValues:[NSJSONSerialization json2DicWithData: responseObj]].list.firstObject.CID;
            }]];
        }];
        
        NSArray* operations = [AFURLConnectionOperation batchOfRequestOperations:arr progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
            
        } completionBlock:^(NSArray *operations) {
            //所有请求完成后 更新分集参数
            responseObj.result.episodes = epArr;
            self.shiBan = responseObj.result;
            self.currentEpisode = self.shiBan.episodes==nil?nil:@(0);
            [super refreshDataCompleteHandle:complete];
        }];
        [[NSOperationQueue mainQueue] addOperations:@[operations.lastObject] waitUntilFinished:NO];
    }];
}

@end
