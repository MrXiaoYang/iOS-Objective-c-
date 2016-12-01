//
//  DealModel.h
//  HappyBuy
//
//  Created by jiyingxin on 16/3/29.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DealDealsModel,DealDealsBusinessesModel;
@interface DealModel : NSObject

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSArray<DealDealsModel *> *deals;
//total_count -> totalCount
@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, assign) NSInteger count;


@end
@interface DealDealsModel : NSObject
//description -> desc
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, strong) NSArray<NSString *> *categories;
//deal_url -> dealURL
@property (nonatomic, copy) NSString *dealURL;
//publish_date -> publishDate
@property (nonatomic, copy) NSString *publishDate;
//purchase_count -> purchaseCount
@property (nonatomic, assign) NSInteger purchaseCount;
//image_url -> imageURL
@property (nonatomic, copy) NSString *imageURL;
//deal_id -> dealId
@property (nonatomic, copy) NSString *dealId;

@property (nonatomic, copy) NSString *title;
//purchase_deadline -> purchaseDeadline
@property (nonatomic, copy) NSString *purchaseDeadline;
//s_mage_url -> sImageURL
@property (nonatomic, copy) NSString *sImageURL;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, strong) NSArray<NSString *> *regions;
//current_price -> currentPrice
@property (nonatomic, assign) NSInteger currentPrice;

@property (nonatomic, strong) NSArray<DealDealsBusinessesModel *> *businesses;

@property (nonatomic, assign) NSInteger distance;
//deal_h5_url -> dealH5URL
@property (nonatomic, copy) NSString *dealH5URL;
//commission_ratio -> commissionRatio
@property (nonatomic, assign) NSInteger commissionRatio;
//list_price -> listPrice
@property (nonatomic, assign) NSInteger listPrice;

@end

@interface DealDealsBusinessesModel : NSObject
//h5_url -> h5URL
@property (nonatomic, copy) NSString *h5URL;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) CGFloat longitude;
//id -> ID
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) CGFloat latitude;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *url;

@end

