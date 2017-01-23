//
//  PlistDataManager.h
//  HappyBuy
//
//  Created by jiyingxin on 16/3/30.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoriesModel.h"
#import "CitiesModel.h"
#import "CityModel.h"
#import "CityDataModel.h"
#import "CityDictModel.h"
#import "CityGroupsModel.h"
#import "MenuDataModel.h"
#import "MineInformationDataModel.h"
#import "PortalSettingsModel.h"
#import "SortsModel.h"

@interface PlistDataManager : NSObject

+ (void)getCategories:(void(^)(NSArray<CategoriesModel *> *categories, NSError *error))completionHandler;

+ (void)getCities:(void(^)(NSArray<CitiesModel *> *cities, NSError *error))completionHandler;

+ (void)getCity:(void(^)(NSArray<CityModel *> *cityList, NSError *error))completionHandler;

+ (void)getCityData:(void(^)(NSArray<CityDataModel *> *cityData, NSError *error))completionHandler;

+ (void)getCityDict:(void(^)(CityDictModel *cityDict, NSError *error))completionHandler;

+ (void)getCityGroups:(void(^)(NSArray<CityGroupsModel *> *cityGroups, NSError *error))completionHandler;

+ (void)getMenuData:(void(^)(NSArray<MenuDataModel *> *menuData, NSError *error))completionHandler;

+ (void)getMineInfomationData:(void(^)(NSArray <MineInformationDataModel *> *mineInformationData, NSError *error))completionHandler;

+ (void)getPortalSettings:(void(^)(PortalSettingsModel *portalSettings, NSError *error))completionHandler;

+ (void)getSorts:(void(^)(NSArray<SortsModel *> *sorts, NSError *error))completionHandler;

@end























