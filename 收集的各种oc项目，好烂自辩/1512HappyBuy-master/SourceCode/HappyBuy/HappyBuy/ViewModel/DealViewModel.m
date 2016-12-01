//
//  DealViewModel.m
//  HappyBuy
//
//  Created by jiyingxin on 16/4/4.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "DealViewModel.h"

@implementation DealViewModel

- (NSInteger)rowNumber{
    return self.dataList.count;
}

- (NSURL *)dealURLForIndex:(NSInteger)index{
    return self.dataList[index].dealH5URL.yx_URL;
}
- (NSURL *)iconURLForIndex:(NSInteger)index;{
    return self.dataList[index].imageURL.yx_URL;
}
- (NSString *)shopNameForIndex:(NSInteger)index;{
    return self.dataList[index].title;
}
- (NSString *)discountForIndex:(NSInteger)index;{
    return @(self.dataList[index].currentPrice).stringValue;
}
- (NSString *)saleNumForIndex:(NSInteger)index;{
    return @(self.dataList[index].purchaseCount).stringValue;
}
- (NSString *)orginalPriceForIndex:(NSInteger)index;{
    return @(self.dataList[index].currentPrice).stringValue;
}
- (NSString *)currentPriceForIndex:(NSInteger)index;{
    return @(self.dataList[index].currentPrice).stringValue;
}

- (NSMutableArray<DealDealsModel *> *)dataList{
    if (!_dataList) {
        _dataList = @[].mutableCopy;
    }
    return _dataList;
}

- (void)getDealWithCategory:(NSString *)category sort:(NSInteger)sort region:(NSString *)region requestMode:(RequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{
    NSInteger tmpPage = 1;
    if (requestMode ==  RequestModeMore) {
        tmpPage = ++_pageNum; //++必须在前
    }
    [DPNetManager getDealsWithSort:sort region:region category:category page:tmpPage completionHandler:^(DealModel *model, NSError *error) {
        if (!error) {
            if (requestMode == RequestModeRefresh) {
                [self.dataList removeAllObjects];
            }
            _pageNum = tmpPage;
            [self.dataList addObjectsFromArray:model.deals];
        }
        !completionHandler ?: completionHandler(error);
    }];
}















@end
