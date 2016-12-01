//
//  BusinessViewModel.h
//  HappyBuy
//
//  Created by tarena on 16/4/1.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPNetManager.h"

@interface BusinessViewModel : NSObject
/** 根据UI来确定属性和方法 */
@property (nonatomic) NSInteger rowNumber;
/** 获取商户详情的链接地址 */
- (NSURL *)businessURLForIndex:(NSInteger)index;
- (NSURL *)iconURLForIndex:(NSInteger)index;
- (NSString *)shopNameForIndex:(NSInteger)index;
- (NSString *)discountForIndex:(NSInteger)index;
- (NSString *)saleNumForIndex:(NSInteger)index;
- (NSString *)orginalPriceForIndex:(NSInteger)index;
- (NSString *)currentPriceForIndex:(NSInteger)index;

/** 根据Model来确定属性和方法 */
@property (nonatomic, strong) NSMutableArray<BusinessBusinessesModel *> *dataList;
@property (nonatomic, assign) NSInteger pageNum;

- (void)getBusinessWithCategory:(NSString *)category requestMode:(RequestMode)requestMode completionHandler:(void(^)(NSError *error))completionHandler;

@end












