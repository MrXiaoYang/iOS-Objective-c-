//
//  MapViewModel.m
//  HappyBuy
//
//  Created by jiyingxin on 16/4/3.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "MapViewModel.h"

@implementation MapViewModel

- (NSMutableArray<BusinessBusinessesModel *> *)dataList {
    if(_dataList == nil) {
        _dataList = [[NSMutableArray<BusinessBusinessesModel *> alloc] init];
    }
    return _dataList;
}

- (void)getBusinessWithCategory:(NSString *)category region:(MKCoordinateRegion)region completionHandler:(void (^)(NSError *))completionHandler{
    self.dataTask = [DPNetManager getBusinessesWithCategory:category region:region completionHandler:^(BusinessModel *model, NSError *error) {
        [self.dataList removeAllObjects];
        [self.dataList addObjectsFromArray:model.businesses];
        completionHandler(error);
    }];
}



@end
