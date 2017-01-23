//
//  DealModel.m
//  HappyBuy
//
//  Created by jiyingxin on 16/3/29.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "DealModel.h"

@implementation DealModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"deals":  [DealDealsModel class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"totalCount": @"total_count"};
}

@end

@implementation DealDealsModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"businesses":  [DealDealsBusinessesModel class]};
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc": @"description",
             @"dealURL": @"deal_url",
             @"publishDate": @"publish_date",
             @"purchaseCount": @"purchase_count",
             @"imageURL": @"image_url",
             @"dealId": @"deal_id",
             @"purchaseDeadline": @"purchase_deadline",
             @"sImageURL": @"s_mage_url",
             @"currentPrice": @"current_price",
             @"dealH5URL": @"deal_h5_url",
             @"commissionRatio": @"commission_ratio",
             @"listPrice": @"list_price"};
}



@end


@implementation DealDealsBusinessesModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID": @"id",
             @"h5URL": @"h5_url"};
}

@end


