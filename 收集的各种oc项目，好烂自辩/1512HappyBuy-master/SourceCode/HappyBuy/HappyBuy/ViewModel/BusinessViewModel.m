//
//  BusinessViewModel.m
//  HappyBuy
//
//  Created by tarena on 16/4/1.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "BusinessViewModel.h"

@implementation BusinessViewModel
- (NSInteger)rowNumber{
    return self.dataList.count;
}
- (NSURL *)businessURLForIndex:(NSInteger)index{
    return [NSURL URLWithString:self.dataList[index].businessURL];
}
- (NSURL *)iconURLForIndex:(NSInteger)index{
    return [NSURL URLWithString:self.dataList[index].photoURL];
}
- (NSString *)shopNameForIndex:(NSInteger)index{
    return self.dataList[index].name;
}
- (NSString *)discountForIndex:(NSInteger)index{
    return nil;
}
- (NSString *)saleNumForIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"浏览%ld", self.dataList[index].reviewCount];
}
- (NSString *)orginalPriceForIndex:(NSInteger)index{
    return nil;
}
- (NSString *)currentPriceForIndex:(NSInteger)index{
    return @(self.dataList[index].avgPrice).stringValue;
}
- (NSMutableArray<BusinessBusinessesModel *> *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray new];
    }
    return _dataList;
}
- (void)getBusinessWithCategory:(NSString *)category requestMode:(RequestMode)requestMode completionHandler:(void (^)(NSError *))completionHandler{
    NSInteger tmpPage = 1;
    if (requestMode == RequestModeMore) {
        tmpPage = _pageNum + 1;
    }
    [DPNetManager getBusinessesWithCategory:category page:tmpPage completionHandler:^(BusinessModel *model, NSError *error) {
        if (!error) {
            _pageNum = tmpPage;
            if (requestMode == RequestModeRefresh){
                [self.dataList removeAllObjects];
            }
            [self.dataList addObjectsFromArray:model.businesses];
        }
        completionHandler(error);
    }];
}

@end













