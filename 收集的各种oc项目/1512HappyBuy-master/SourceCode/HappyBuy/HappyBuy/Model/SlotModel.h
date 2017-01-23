//
//  SlotModel.h
//  HappyBuy
//
//  Created by jiyingxin on 16/3/29.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

//因为banner2 和 playerGuanggao 与 banner 是同样的属性. 所以不需要写了

@class SlotPcBannerModel, SlotListModel;
@interface SlotModel : NSObject

//playerGuanggao -> player-guanggao
@property (nonatomic, strong) NSArray<SlotPcBannerModel *> *playerGuanggao;
//app-ad -> appAd
@property (nonatomic, strong) NSArray *appAd;
//pc-banner -> pcBanner
@property (nonatomic, strong) NSArray<SlotPcBannerModel *> *pcBanner;

@property (nonatomic, strong) NSArray<SlotListModel *> *list;
//pc-banner2 -> pcBanner2
@property (nonatomic, strong) NSArray<SlotPcBannerModel *> *pcBanner2;


@end

@interface SlotPcBannerModel : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *subtitle;
//id -> ID
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *ext;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *fk;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *link;
//create_at -> createAt
@property (nonatomic, copy) NSString *createAt;
//slot_id -> slotId
@property (nonatomic, assign) NSInteger slotId;

@property (nonatomic, assign) NSInteger priority;

@end

@interface SlotListModel : NSObject

@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *name;

@end
