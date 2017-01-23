//
//  recommendModel.m
//  BiliBili
//
//  Created by apple-jd44 on 15/10/21.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "AVModel.h"

@implementation AVModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list": [AVDataModel class]};
}
@end

@implementation AVDataModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"desc": @"description"};
}

@end