//
//  ShinBanInfoModel.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/7.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ShinBanInfoModel.h"

@implementation ShinBanInfoModel
+ (NSDictionary*)mj_objectClassInArray{
    return @{@"result":[ShinBanInfoDataModel class]};
}
@end

@implementation ShinBanInfoDataModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"episodes":[episodesModel class],@"tag2s":[TagModel class]};
}

@end

@implementation episodesModel

@end