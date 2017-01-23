//
//  FindViewModel.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/4.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "FindViewModel.h"

#import "AVModel.h"

#import "NSString+Tools.h"

@interface FindViewModel ()
@property (nonatomic, strong) NSMutableArray<FindDataModel*>* rankArr;
@property (nonatomic, strong) NSMutableArray<FindImgDataModel*>* rankImgArr;
/**
 *  原创排行
 */
@property (nonatomic, strong) NSArray<AVDataModel*>* sectionArr;
/**
 *  字典映射
 */
@property (nonatomic, strong) NSDictionary* dicMap;
@end

@implementation FindViewModel
#pragma mark - 关键词
- (NSInteger)rankArrConut{
    return self.rankArr.count;
}

- (NSString*)keyWordForRow:(NSInteger)row{
    return self.rankArr[row].keyword;
}

- (NSString*)statusWordForRow:(NSInteger)row{
    return self.rankArr[row].status;
}
#pragma mark - 热搜图片
- (NSURL*)rankCoverForNum:(NSInteger)num{
    return [NSURL URLWithString:self.rankImgArr[num].cover];
}
- (NSString*)coverKeyWordForNum:(NSInteger)num{
    return self.rankImgArr[num].keyword;
}

#pragma mark - 排行
/**
 *  封面
 */
- (NSURL*)sectionRankCoverWithIndex:(NSInteger)index{
    return [NSURL URLWithString:[self sectionModelWithIndex: index].pic];
}
/**
 *  标题
 */
- (NSString*)sectionRankTitleWithIndex:(NSInteger)index{
    return [self sectionModelWithIndex: index].title;
}
/**
 *  播放数
 */
- (NSString*)sectionRankPlayCountWithIndex:(NSInteger)index{
    return [NSString stringWithFormatNum: [self sectionModelWithIndex: index].play];
}
/**
 *  弹幕数
 */
- (NSString*)sectionRankDanMuCountWithIndex:(NSInteger)index{
    return [NSString stringWithFormatNum: [self sectionModelWithIndex: index].video_review];
}
/**
 *  Up名
 */
- (NSString*)sectionRankUpNameWithIndex:(NSInteger)index{
    return [self sectionModelWithIndex: index].author;
}
/**
 *  下标对应模型f
 */
- (AVDataModel*)sectionModelWithIndex:(NSInteger)index{
    return self.sectionArr[index];
}
/**
 *  总数
 */
- (NSInteger)sectionCount{
    return self.sectionArr.count;
}

/**
 *  发现刷新
 *
 */
- (void)refreshDataCompleteHandle:(void(^)(NSError *error))complete{
    [FindNetManager GetRankCompletionHandler:^(FindModel* responseObj, NSError *error) {
        [self.rankArr removeAllObjects];
        self.rankArr = [responseObj.list mutableCopy];
        [ArchiverObj archiveWithObj:responseObj];
        [FindNetManager GetRankImgCompletionHandler:^(FindImgModel* responseObj1, NSError *error) {
            [self.rankImgArr removeAllObjects];
            self.rankImgArr = [responseObj1.recommend mutableCopy];
            [ArchiverObj archiveWithObj:responseObj1];
            complete(error);
        }];
    }];
}


/**
 *  分区刷新
 *
 */
- (void)refreshSection:(NSString*)section style:(NSString*)style CompleteHandle:(void(^)(NSError *error))complete{
    [FindNetManager GetSectionRankWithParameters:@{@"section":self.dicMap[section],@"style": style} CompletionHandler:^(AVModel*  responseObj, NSError *error) {
        self.sectionArr = responseObj.list;
        complete(error);
    }];
}

#pragma mark - 懒加载
- (NSMutableArray<FindImgDataModel *> *)rankImgArr{
    if (_rankImgArr == nil) {
        FindImgModel* model = [ArchiverObj UnArchiveWithClass:[FindImgModel class]];
        if (model != nil) {
            _rankImgArr = [model.recommend mutableCopy];
        }
    }
    return _rankImgArr;
}

- (NSMutableArray<FindDataModel *> *)rankArr{
    if (_rankArr == nil) {
        FindModel* model = [ArchiverObj UnArchiveWithClass:[FindModel class]];
        if (model != nil) {
            _rankArr = [model.list mutableCopy];
        }
    }
    return _rankArr;
}

- (NSDictionary *)dicMap{
    if (_dicMap == nil){
        _dicMap =  @{@"全站":@"0",@"动画":@"1",@"番剧":@"33",@"音乐":@"3",@"舞蹈":@"129",@"游戏":@"4",@"科技":@"36",@"娱乐":@"5",@"鬼畜":@"119",@"电影":@"23",@"电视剧":@"11",@"时尚":@"155"};
    }
    return _dicMap;
}

@end
