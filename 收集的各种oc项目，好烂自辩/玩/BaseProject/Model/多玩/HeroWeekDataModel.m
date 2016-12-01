//
//  HeroWeekDataModel.m
//  BaseProject
//
//  Created by jiyingxin on 15/11/2.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "HeroWeekDataModel.h"

@implementation HeroWeekDataModel

@end
@implementation HeroWeekDataDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"charts" : [HeroWeekDataDataChartsModel class]};
}

+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName{
    return [propertyName underlineFromCamel];
}

@end


@implementation HeroWeekDataDataChartsModel

+ (NSDictionary *)objectClassInArray{
    return @{@"ratio_data" : [HeroWeekDataDataChartsRatioDataModel class]};
}

+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName{
    return [propertyName underlineFromCamel];
}
@end


@implementation HeroWeekDataDataChartsRatioDataModel

@end


