//
//  DPNetManager.h
//  HappyBuy
//
//  Created by tarena on 16/4/1.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPRequest.h"
#import "BusinessModel.h"
#import "DealModel.h"
@import MapKit;

@interface DPNetManager : NSObject
/**
 *  用于请求商家信息
 参数: 页数 从1开始, 类型: 美食,电影...
 */
+ (void)getBusinessesWithCategory:(NSString *)category page:(NSInteger)page completionHandler:(void(^)(BusinessModel *model, NSError *error))completionHandler;


/**
 *  获取一定范围内的商家
 *
 *  @param category          类别
 *  @param region            经纬度+范围
 *  @param completionHandler 
 */
+ (id)getBusinessesWithCategory:(NSString *)category region:(MKCoordinateRegion)region completionHandler:(void (^)(BusinessModel *model, NSError *error))completionHandler;

/**
 *  获取团购列表
 *
 *  @param sort              排序方式
 *  @param region            区域
 *  @param category          分类
 *  @param completionHandler
 *
 *  @return <#return value description#>
 */
+ (id)getDealsWithSort:(NSInteger)sort region:(NSString *)region category:(NSString *)category page:(NSInteger)page completionHandler:(void(^)(DealModel *model, NSError *error))completionHandler;
@end










