//
//  sameVideoModel.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/6.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "sameVideoModel.h"

@implementation sameVideoModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list":[sameVideoDataModel class]};
}
@end

@implementation sameVideoDataModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"identity":@"id", @"desc":@"description", @"typeid":@"typeID"};
}
@end
