//
//  CityDataModel.h
//  HappyBuy
//
//  Created by jiyingxin on 16/3/30.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityDataCitylistModel, CityDataCitylistArealistModel;
@interface CityDataModel : NSObject


@property (nonatomic, strong) NSArray<CityDataCitylistModel *> *citylist;
//id -> ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *provinceName;


@end
@interface CityDataCitylistModel : NSObject

@property (nonatomic, strong) NSArray<CityDataCitylistArealistModel *> *arealist;
//id -> ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *cityName;

@end

@interface CityDataCitylistArealistModel : NSObject
//id -> ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *areaName;

@end

