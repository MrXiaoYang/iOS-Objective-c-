//
//  ShinBanModel.m
//  BiliBili
//
//  Created by apple-jd44 on 15/10/28.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ShinBanModel.h"

@implementation MoreViewShinBanModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list":[MoreViewShinBanDataModel class]};
}
@end

@implementation RecommentShinBanModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list":[RecommentShinBanDataModel class]};
}
@end

@implementation RecommentShinBanDataModel

@end

@implementation MoreViewShinBanDataModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"description":@"desc",@"typeid":@"typeID"};
}
@end