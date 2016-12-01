//
//  PlistDataManager.m
//  HappyBuy
//
//  Created by jiyingxin on 16/3/30.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "PlistDataManager.h"



@implementation PlistDataManager
+ (NSArray *)getArrFromPlist:(NSString *)plistName{
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"]];
}

+ (NSDictionary *)getDictFromPlist:(NSString *)plistName{
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"]];
}


+ (void)getCategories:(void (^)(NSArray<CategoriesModel *> *, NSError *))completionHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *tmpArr = [CategoriesModel parseJSON:[self getArrFromPlist:@"categories"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(tmpArr, nil);
        });
    });
}

+ (void)getCities:(void (^)(NSArray<CitiesModel *> *, NSError *))completionHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *tmpArr = [CitiesModel parseJSON:[self getArrFromPlist:@"cities"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(tmpArr, nil);
        });
    });
}

+ (void)getCity:(void (^)(NSArray<CityModel *> *, NSError *))completionHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *tmpArr = [CityModel parseJSON:[self getArrFromPlist:@"city"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(tmpArr, nil);
            
        });
    });
}

+ (void)getCityData:(void (^)(NSArray<CityDataModel *> *, NSError *))completionHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *tmpArr = [CityDataModel parseJSON:[self getArrFromPlist:@"citydata"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(tmpArr, nil);
        });
    });
}

+ (void)getCityDict:(void (^)(CityDictModel *, NSError *))completionHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CityDictModel *cityDictModel = [CityDictModel parseJSON:[self getDictFromPlist:@"citydict"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(cityDictModel, nil);
        });
    });
}

+ (void)getCityGroups:(void (^)(NSArray<CityGroupsModel *> *, NSError *))completionHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *tmpArr = [CityGroupsModel parseJSON:[self getArrFromPlist:@"cityGroups"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(tmpArr, nil);
        });
    });
}

+ (void)getMenuData:(void (^)(NSArray<MenuDataModel *> *, NSError *))completionHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *tmpArr = [MenuDataModel parseJSON:[self getArrFromPlist:@"menuData"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(tmpArr, nil);
        });
    });
}

+ (void)getMineInfomationData:(void (^)(NSArray<MineInformationDataModel *> *, NSError *))completionHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *tmpArr = [MineInformationDataModel parseJSON:[self getArrFromPlist:@"MineInformationData"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(tmpArr, nil);
        });
    });
}

+ (void)getPortalSettings:(void (^)(PortalSettingsModel *, NSError *))completionHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        PortalSettingsModel *model = [PortalSettingsModel parseJSON:[self getDictFromPlist:@"PortalSettings"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(model, nil);
        });
    });
}

+ (void)getSorts:(void (^)(NSArray<SortsModel *> *, NSError *))completionHandler{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *tmpArr = [SortsModel parseJSON:[self getArrFromPlist:@"sorts"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(tmpArr, nil);
        });
    });
}

@end


















