//
//  TuWanViewModel.m
//  BaseProject
//
//  Created by jiyingxin on 15/11/5.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanViewModel.h"

@implementation TuWanViewModel

- (instancetype)initWithType:(InfoType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}
//预防性编程，防止没有使用initWithType初始化
- (id)init{
    if (self = [super init]) {
//如果使用此方法初始化，那么崩溃提示
        NSAssert1(NO, @"%s 必须使用initWithType初始化", __func__);
    }
    return self;
}

- (void)refreshDataCompletionHandle:(CompletionHandle)completionHandle{
    _start = 0;
    [self getDataFromNetCompleteHandle:completionHandle];
}
- (void)getMoreDataCompletionHandle:(CompletionHandle)completionHandle{
    _start += 11;
    [self getDataFromNetCompleteHandle:completionHandle];
}
- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    self.dataTask = [TuWanNetManager getTuWanInfoWithType:_type start:_start completionHandle:^(TuWanModel *model, NSError *error) {
        if (_start == 0) {
            [self.dataArr removeAllObjects];
            self.indexPicArr = nil;
        }
        [self.dataArr addObjectsFromArray:model.data.list];
        self.indexPicArr = model.data.indexpic;
        completionHandle(error);
    }];
}

-(BOOL)isExistIndexPic{
    return self.indexPicArr != nil && self.indexPicArr.count != 0;
}

- (NSInteger)rowNumber{
    return self.dataArr.count;
}

- (TuWanDataIndexpicModel *)modelForArr:(NSArray *)arr row:(NSInteger)row{
    return arr[row];
}

/** 根据showtype 0是没有图，  1 是有图 */
- (BOOL)containImages:(NSInteger)row{
    return [[self modelForArr:self.dataArr row:row].showtype isEqualToString:@"1"];
}

/** 返回列表中某行数据题目 */
- (NSString *)titleForRowInList:(NSInteger)row{
    return [self modelForArr:self.dataArr row:row].title;
}
/** 返回列表中某行数据的图片 */
- (NSURL *)iconURLForRowInList:(NSInteger)row{
    return [NSURL URLWithString:[self modelForArr:self.dataArr row:row].litpic];
}
/** 返回列表中某行数据的描述 */
- (NSString *)descForRowInList:(NSInteger)row{
    return [self modelForArr:self.dataArr row:row].longtitle;
}
/** 返回列表中某行数据浏览人数 */
- (NSString *)clicksForRowInList:(NSInteger)row{
    return [[self modelForArr:self.dataArr row:row].click stringByAppendingString:@"人浏览"];
}

/** 滚动展示栏的图片 */
- (NSURL *)iconURLForRowInIndexPic:(NSInteger)row{
    return [NSURL URLWithString:[self modelForArr:self.indexPicArr row:row].litpic];
}
/** 滚动展示栏的文字 */
- (NSString *)titleForRowInIndexPic:(NSInteger)row{
    return [self modelForArr:self.indexPicArr row:row].title;
}
/** 滚动展示栏的图片数量 */
- (NSInteger)indexPicNumber{
    return self.indexPicArr.count;
}

/** 获取列表中某行数据对应的html5链接 */
- (NSURL *)detailURLForRowInList:(NSInteger)row{
    return [NSURL URLWithString:[self modelForArr:self.dataArr row:row].html5];
}
/** 获取展示栏中某行数据对应的html5链接 */
- (NSURL *)detailURLForRowInIndexPic:(NSInteger)row{
    return [NSURL URLWithString:[self modelForArr:self.indexPicArr row:row].html5];
}

/** 通过行数 返回此行中对应的图片链接数组 */
- (NSArray *)iconURLSForRowInList:(NSInteger)row{
    NSArray *arr = [self modelForArr:self.dataArr row:row].showitem;
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < arr.count; i ++) {
        TuWanDataIndexpicShowitemModel *model= arr[i];
        [array addObject:[NSURL URLWithString:model.pic]];
    }
    return [array copy];
}

/** 当前数据类型是视频 video*/
- (BOOL)isVideoInListForRow:(NSInteger)row{
    return [[self modelForArr:self.dataArr row:row].type isEqualToString:@"video"];
}
- (BOOL)isVideoInIndexPicForRow:(NSInteger)row{
    return [[self modelForArr:self.indexPicArr row:row].type isEqualToString:@"video"];
}
/** 当前数据类型是图片 pic*/
- (BOOL)isPicInListForRow:(NSInteger)row{
    return [[self modelForArr:self.dataArr row:row].type isEqualToString:@"pic"];
}
- (BOOL)isPicInIndexPicForRow:(NSInteger)row{
    return [[self modelForArr:self.indexPicArr row:row].type isEqualToString:@"pic"];
}
/** 当前数据类型是html all*/
- (BOOL)isHtmlInListForRow:(NSInteger)row{
    return [[self modelForArr:self.dataArr row:row].type isEqualToString:@"all"];
}
- (BOOL)isHtmlInIndexPicForRow:(NSInteger)row{
    return [[self modelForArr:self.indexPicArr row:row].type isEqualToString:@"all"];
}

/** 返回某行数据的Aid */
- (NSString *)aidInListForRow:(NSInteger)row{
    return [self modelForArr:self.dataArr row:row].aid;
}
- (NSString *)aidInIndexPicForRow:(NSInteger)row{
    return [self modelForArr:self.indexPicArr row:row].aid;
}

@end












