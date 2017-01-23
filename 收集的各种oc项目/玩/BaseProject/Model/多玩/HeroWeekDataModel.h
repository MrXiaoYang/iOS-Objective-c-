//
//  HeroWeekDataModel.h
//  BaseProject
//
//  Created by jiyingxin on 15/11/2.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class HeroWeekDataDataModel,HeroWeekDataDataChartsModel,HeroWeekDataDataChartsRatioDataModel;
@interface HeroWeekDataModel : BaseModel

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) HeroWeekDataDataModel *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface HeroWeekDataDataModel : BaseModel

@property (nonatomic, strong) NSArray<HeroWeekDataDataChartsModel *> *charts;

@property (nonatomic, assign) double averageWinRatio;
@property (nonatomic, assign) double averageKNum;
@property (nonatomic, assign) double championId;
@property (nonatomic, assign) double averageDNum;
@property (nonatomic, assign) double averageANum;
@property (nonatomic, assign) double rank;

@end

@interface HeroWeekDataDataChartsModel : BaseModel

@property (nonatomic, copy) NSString *color;

@property (nonatomic, strong) NSArray<HeroWeekDataDataChartsRatioDataModel *> *ratioData;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *yAxisTitle;

@end

@interface HeroWeekDataDataChartsRatioDataModel : BaseModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger value;

@end

