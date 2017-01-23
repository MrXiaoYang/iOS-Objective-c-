//
//  BusinessModel.m
//  HappyBuy
//
//  Created by jiyingxin on 16/3/29.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "BusinessModel.h"

@implementation BusinessModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"businesses":  [BusinessBusinessesModel class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"totalCount": @"total_count"};
}

@end
@implementation BusinessBusinessesModel

/** 判断两个类型是否相等, 被containsObject:方法触发. 变对比指针为对比元素 */
- (BOOL)isEqual:(id)object {
    return [self modelIsEqual:object];
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"branchName": @"branch_name",
             @"ratingSImgURL": @"rating_s_img_url",
             @"dealCount": @"deal_count",
             @"couponURL": @"coupon_url",
             @"productScore": @"product_score",
             @"hasDeal": @"has_deal",
             @"onlineReservationURL": @"online_reservation_url",
             @"reviewListURL": @"review_list_url",
             @"businessURL": @"business_url",
             @"productGrade": @"product_grade",
             @"couponDescription": @"coupon_description",
             @"ratingImgURL": @"rating_img_url",
             @"avgRating": @"avg_rating",
             @"photoListURL": @"photo_list_url",
             @"hasOnlineReservation": @"has_online_reservation",
             @"serviceScore": @"service_score",
             @"hasCoupon": @"has_coupon",
             @"businessId": @"business_id",
             @"couponId": @"coupon_id",
             @"decorationGrade": @"decoration_grade",
             @"serviceGrade": @"service_grade",
             @"photoURL": @"photo_url",
             @"avgPrice": @"avg_price",
             @"reviewCount": @"review_count",
             @"sPhotoURL": @"s_photo_url",
             @"photoCount": @"photo_count",
             @"decorationScore": @"decoration_score"};
}

@end


