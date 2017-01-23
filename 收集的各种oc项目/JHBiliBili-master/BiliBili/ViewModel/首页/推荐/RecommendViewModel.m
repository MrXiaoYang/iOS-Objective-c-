//
//  RecommendViewModel.m
//  BiliBili
//
//  Created by apple-jd44 on 15/10/21.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "AVModel.h"
#import "IndexModel.h"

#import "RecommendViewModel.h"

#import "RecommendNetManager.h"

#import "NSString+Tools.h"

@interface RecommendViewModel ()

@end

@implementation RecommendViewModel
#pragma mark - 缩略图
- (NSURL *)picForRow:(NSInteger)row section:(NSString*)section{
    return [NSURL URLWithString:self.list[section][row].pic];
}
- (NSString*)titleForRow:(NSInteger)row section:(NSString*)section{
    return self.list[section][row].title;
}
- (NSString *)playForRow:(NSInteger)row section:(NSString*)section{
    return [NSString stringWithFormatNum:self.list[section][row].play];
}
- (NSString *)danMuCountForRow:(NSInteger)row section:(NSString*)section{
    return [NSString stringWithFormatNum:self.list[section][row].video_review];
}

#pragma mark - 详情
- (NSString*)authorForRow:(NSInteger)row section:(NSString*)section{
    return self.list[section][row].author;
}

- (NSString*)publicTimeForRow:(NSInteger)row section:(NSString*)section{
    return self.list[section][row].create;
}

- (NSString*)descForRow:(NSInteger)row section:(NSString*)section{
    return self.list[section][row].desc;
}

#pragma mark - 顶部视图
- (NSInteger)numberOfHeadImg{
    return self.headObject.count;
}


- (NSURL*)headImgURL:(NSInteger)index{
    return self.headObject[index].img;
}

- (NSURL*)headImgLink:(NSInteger)index{
    return self.headObject[index].link;
}

- (NSInteger)sectionCount{
    return self.list.count;
}

#pragma mark - 获取视频子项详情
- (AVDataModel*)AVDataModelForRow:(NSInteger)row section:(NSString*)section{
    return self.list[section][row];
}

#pragma mark - 刷新
- (void)refreshDataCompleteHandle:(void(^)(NSError *error))complete{    NSMutableArray<AFHTTPRequestOperation*>* arr = [NSMutableArray array];
    [arr addObject: [RecommendNetManager getHeadImgCompletionHandler:^(IndexModel* responseObj, NSError *error) {
        self.headObject = [responseObj.list mutableCopy];
    }]];
    [self.dicMap enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString* key = [obj allValues].firstObject;
        [arr addObject: [RecommendNetManager getSection:key completionHandler:^(AVModel* responseObj1, NSError *error) {
            self.list[key] = [responseObj1.list mutableCopy];
        }]];
    }];
    
    NSArray* operations = [AFURLConnectionOperation batchOfRequestOperations:arr progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
    } completionBlock:^(NSArray *operations) {
        [ArchiverObj archiveWithObj:self.list key:@"recommendViewModel"];
        [ArchiverObj archiveWithObj: self.headObject key: @"recommendHeadModel"];
        complete(nil);
    }];
    [[NSOperationQueue mainQueue] addOperations:@[operations.lastObject] waitUntilFinished:NO];
    
}

#pragma mark - 懒加载
- (NSMutableDictionary *)list{
    if (_list == nil) {
        NSDictionary* dic = [ArchiverObj UnArchiveWithKey:@"recommendViewModel"];
        if (dic == nil) _list = [NSMutableDictionary new];
        else _list = [dic mutableCopy];
    }
    return _list;
}

- (NSArray *)headObject{
    if (_headObject == nil) {
        NSArray* headArr = [ArchiverObj UnArchiveWithKey:@"recommendHeadModel"];
        if (headArr == nil) _headObject = [NSArray new];
        else _headObject = [headArr mutableCopy];
    }
    return _headObject;
}

- (NSArray<NSDictionary *> *)dicMap{
    if (_dicMap == nil){
        _dicMap =  @[@{@"动画":@"1-3day.json"},@{@"番剧":@"13-3day.json"},@{@"音乐":@"3-3day.json"},@{@"舞蹈":@"129-3day.json"},@{@"游戏":@"4-3day.json"},@{@"科技":@"36-3day.json"},@{@"娱乐":@"5-3day.json"},@{@"鬼畜":@"119-3day.json"},@{@"电影":@"23-3day.json"},@{@"电视剧":@"11-3day.json"},@{@"时尚":@"155-3day.json"}];
    }
    return _dicMap;
}

@end
