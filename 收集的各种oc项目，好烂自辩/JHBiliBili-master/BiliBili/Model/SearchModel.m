//
//  SearchModel.m
//  BiliBili
//
//  Created by apple-jd24 on 15/12/12.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SearchModel.h"
#import "AVModel.h"

@implementation SearchModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bangumi":[SearchShibanModel class], @"special":[SearchSpecialModel class],@"video":[AVDataModel class]};
}
@end

@implementation SearchShibanModel

@end

@implementation SearchSpecialModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"desc":@"description"};
}
@end