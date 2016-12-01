//
//  CityListViewModel.h
//  HappyBuy
//
//  Created by tarena on 16/3/31.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlistDataManager.h"

@interface CityListViewModel : NSObject
/*UI来确定属性方法*/
@property (nonatomic) NSInteger sectionNumber;
- (NSInteger)rowNumberForSection:(NSInteger)section;
- (NSString *)titleForSection:(NSInteger)section;
- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) NSArray<NSString *> *indexList;
/*Model来确定属性方法*/
@property (nonatomic, strong) NSArray<CityGroupsModel *> *cityGroups;
- (void)getcityGroupsCompletionHandler:(void(^)(NSError *error))completionHandler;
@end











