//
//  BusinessModel.h
//  HappyBuy
//
//  Created by jiyingxin on 16/3/29.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BusinessBusinessesModel;
@interface BusinessModel : NSObject

@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) NSArray<BusinessBusinessesModel *> *businesses;
//total_count -> totalCount
@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, assign) NSInteger count;

@end


@interface BusinessBusinessesModel : NSObject
//branch_name -> branchName
@property (nonatomic, copy) NSString *branchName;
//rating_s_img_url -> ratingSImgURL
@property (nonatomic, copy) NSString *ratingSImgURL;
//deal_count -> dealCount
@property (nonatomic, assign) NSInteger dealCount;

@property (nonatomic, copy) NSString *telephone;

@property (nonatomic, copy) NSString *address;
//coupon_url -> couponURL
@property (nonatomic, copy) NSString *couponURL;
//product_score -> productScore
@property (nonatomic, assign) NSInteger productScore;
//has_deal -> hasDeal
@property (nonatomic, assign) NSInteger hasDeal;
//online_reservation_url -> onlineReservationURL
@property (nonatomic, copy) NSString *onlineReservationURL;
//review_list_url -> reviewListURL
@property (nonatomic, copy) NSString *reviewListURL;
//business_url -> businessURL
@property (nonatomic, copy) NSString *businessURL;
//product_grade -> productGrade
@property (nonatomic, assign) NSInteger productGrade;
//coupon_description -> couponDescription
@property (nonatomic, copy) NSString *couponDescription;

@property (nonatomic, assign) NSInteger distance;
//rating_img_url -> ratingImgURL
@property (nonatomic, copy) NSString *ratingImgURL;
//avg_rating -> avgRating
@property (nonatomic, assign) NSInteger avgRating;

@property (nonatomic, copy) NSString *name;
//photo_list_url -> photoListURL
@property (nonatomic, copy) NSString *photoListURL;

@property (nonatomic, assign) CGFloat longitude;
//has_online_reservation -> hasOnlineReservation
@property (nonatomic, assign) NSInteger hasOnlineReservation;

@property (nonatomic, copy) NSString *city;
//service_score -> serviceScore
@property (nonatomic, assign) CGFloat serviceScore;
//has_coupon -> hasCoupon
@property (nonatomic, assign) NSInteger hasCoupon;
//business_id -> businessId
@property (nonatomic, assign) NSInteger businessId;
//couponId -> couponId
@property (nonatomic, assign) NSInteger couponId;

@property (nonatomic, strong) NSArray *deals;

@property (nonatomic, strong) NSArray<NSString *> *categories;
//decoration_grade -> decorationGrade
@property (nonatomic, assign) NSInteger decorationGrade;
//service_grade -> serviceGrade
@property (nonatomic, assign) NSInteger serviceGrade;
//photo_url -> photoURL
@property (nonatomic, copy) NSString *photoURL;

@property (nonatomic, strong) NSArray<NSString *> *regions;
//avg_price -> avgPrice
@property (nonatomic, assign) NSInteger avgPrice;
//review_count -> reviewCount
@property (nonatomic, assign) NSInteger reviewCount;
//s_photo_url -> sPhotoURL
@property (nonatomic, copy) NSString *sPhotoURL;
//photo_count -> photoCount
@property (nonatomic, assign) NSInteger photoCount;
//decoration_score -> decorationScore
@property (nonatomic, assign) CGFloat decorationScore;

@property (nonatomic, assign) CGFloat latitude;

@end

