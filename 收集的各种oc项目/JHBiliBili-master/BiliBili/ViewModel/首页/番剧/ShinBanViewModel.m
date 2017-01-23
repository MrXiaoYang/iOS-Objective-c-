//
//  ShinBanViewModel.m
//  BiliBili
//
//  Created by apple-jd44 on 15/10/28.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ShinBanViewModel.h"
#import "ShinBanModel.h"

#import "ShinBanNetManager.h"

#import "NSString+Tools.h"
@interface ShinBanViewModel ()

@end

@implementation ShinBanViewModel

//推荐番剧
- (NSURL*)commendCoverForRow:(NSInteger)row{
    return [NSURL URLWithString:self.recommentList[row].cover];
}
- (NSString*)commendTitileForRow:(NSInteger)row{
    return self.recommentList[row].title;
}

#define pagesize @21
- (void)refreshDataCompleteHandle:(void(^)(NSError *error))complete{
    [ShinBanNetManager getRecommentParameters:@{@"page":@(1),@"pagesize":pagesize} CompletionHandler:^(RecommentShinBanModel* responseObj, NSError *error) {
        if (responseObj.list.count) {
            self.recommentList = [responseObj.list mutableCopy];
            [ArchiverObj archiveWithObj:responseObj key: @"RecommentShinBanModel"];
        }
        complete(error);
    }];
}

//获取更多推荐番剧
- (void)getMoreDataCompleteHandle:(void(^)(NSError *error))complete{
    [ShinBanNetManager getRecommentParameters:@{@"page":@(self.recommentList.count / pagesize.intValue + 1),@"pagesize":pagesize} CompletionHandler:^(RecommentShinBanModel* responseObj, NSError *error) {
        if (responseObj.list.count) {
            [self.recommentList addObjectsFromArray:responseObj.list];
            [ArchiverObj archiveWithObj: responseObj];
        }
        complete(error);
    }];
}


#pragma mark - 懒加载
- (NSMutableArray *)recommentList{
    if (_recommentList == nil) {
        RecommentShinBanModel* model = [ArchiverObj UnArchiveWithClass:[RecommentShinBanModel class]];
        if (model != nil) _recommentList = [model.list mutableCopy];
        else _recommentList = [NSMutableArray array];
    }
    return _recommentList;
}
@end
