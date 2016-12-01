//
//  DealViewModel.h
//  HappyBuy
//
//  Created by jiyingxin on 16/4/4.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPNetManager.h"

@interface DealViewModel : NSObject

/** 根据UI来确定属性和方法 */
@property (nonatomic, readonly) NSInteger rowNumber;
/** 获取商户详情的链接地址 */
- (NSURL *)dealURLForIndex:(NSInteger)index;
- (NSURL *)iconURLForIndex:(NSInteger)index;
- (NSString *)shopNameForIndex:(NSInteger)index;
- (NSString *)discountForIndex:(NSInteger)index;
- (NSString *)saleNumForIndex:(NSInteger)index;
- (NSString *)orginalPriceForIndex:(NSInteger)index;
- (NSString *)currentPriceForIndex:(NSInteger)index;

/** 根据Model来确定属性和方法 */
@property (nonatomic, strong) NSMutableArray<DealDealsModel *> *dataList;
@property (nonatomic, assign) NSInteger pageNum;

- (void)getDealWithCategory:(NSString *)category sort:(NSInteger)sort region:(NSString *)region requestMode:(RequestMode)requestMode completionHandler:(void(^)(NSError *error))completionHandler;


@end
