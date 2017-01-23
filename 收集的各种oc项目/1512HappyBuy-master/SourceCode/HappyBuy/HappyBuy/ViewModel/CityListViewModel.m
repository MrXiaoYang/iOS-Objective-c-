//
//  CityListViewModel.m
//  HappyBuy
//
//  Created by tarena on 16/3/31.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "CityListViewModel.h"

@implementation CityListViewModel
- (NSInteger)sectionNumber{
    return self.cityGroups.count;
}
- (NSString *)titleForSection:(NSInteger)section{
    return [self.cityGroups[section] title];
}
- (NSArray<NSString *> *)indexList{
    //这个方法可以获取cityGroups数组中每个元素的title属性组成的数组
    return [self.cityGroups valueForKeyPath:@"title"];
}
- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.cityGroups[indexPath.section] cities][indexPath.row];
}
- (NSInteger)rowNumberForSection:(NSInteger)section{
    return [self.cityGroups[section] cities].count;
}

- (void)getcityGroupsCompletionHandler:(void (^)(NSError *))completionHandler{
    [PlistDataManager getCityGroups:^(NSArray<CityGroupsModel *> *cityGroups, NSError *error) {
        self.cityGroups = cityGroups;
        completionHandler(error);
    }];
}

@end











