//
//  DPNetManager.m
//  HappyBuy
//
//  Created by tarena on 16/4/1.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "DPNetManager.h"

@implementation DPNetManager
+ (void)getBusinessesWithCategory:(NSString *)category page:(NSInteger)page completionHandler:(void (^)(BusinessModel *, NSError *))completionHandler{
    //使用点评网提供的方法获取完整的连接地址
    //@{字典} @[数组] @YES @1 @(数字变量)->NSNumber类型
    NSDictionary *pa = @{@"city": kCurrentCity,
                         @"platform": @2,
                         @"page": @(page),
                         @"category": category};
    NSString *path = [DPRequest serializeURL:@"http://api.dianping.com/v1/business/find_businesses" params:pa];
    [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([BusinessModel parseJSON:responseObj], error);
    }];
}

+ (id)getBusinessesWithCategory:(NSString *)category region:(MKCoordinateRegion)region completionHandler:(void (^)(BusinessModel *model, NSError *))completionHandler{
    NSDictionary *pa = @{@"latitude": @(region.center.latitude),
                         @"platform": @2,
                         @"longitude": @(region.center.longitude),
                         @"category": category,
                         @"radius": @(5000)};
    NSString *path = [DPRequest serializeURL:@"http://api.dianping.com/v1/business/find_businesses" params:pa];
    return [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([BusinessModel parseJSON:responseObj], error);
    }];
}

+ (id)getDealsWithSort:(NSInteger)sort region:(NSString *)region category:(NSString *)category page:(NSInteger)page completionHandler:(void (^)(DealModel *, NSError *))completionHandler{
    NSMutableDictionary *pa = @{@"sort": @(sort),
                                @"platform": @2,
                                @"category": category,
                                @"page": @(page),
                                @"city": kCurrentCity ?: @"北京",
                                @"region": region}.mutableCopy;
    if ([region isEqualToString:@"全部"]) {
        [pa removeObjectForKey:@"region"];
    }
    NSString *path = [DPRequest serializeURL:@"http://api.dianping.com/v1/deal/find_deals" params:pa];
    return [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandler([DealModel parseJSON:responseObj], error);
    }];
}




@end
