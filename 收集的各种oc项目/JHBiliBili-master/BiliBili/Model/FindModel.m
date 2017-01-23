//
//  FindModel.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/3.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "FindModel.h"

@implementation FindModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list":[FindDataModel class]};
}
@end

@implementation FindDataModel

@end

@implementation FindImgModel
+ (NSDictionary *)objectClassInArray{
    return @{@"recommend":[FindImgDataModel class]};
}
@end

@implementation FindImgDataModel

@end