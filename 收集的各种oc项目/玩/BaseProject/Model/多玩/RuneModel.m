//
//  RuneModel.m
//  BaseProject
//  符文
//  Created by jiyingxin on 15/11/2.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "RuneModel.h"

@implementation RuneModel

//首字母大写
+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName{
    return [propertyName firstCharUpper];
}

+ (NSDictionary *)objectClassInArray{
    return @{@"purple" : [RunePurpleModel class], @"yellow" : [RunePurpleModel class], @"blue" : [RunePurpleModel class], @"red" : [RunePurpleModel class]};
}
@end
@implementation RunePurpleModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"img": @"Img", @"name": @"Name", @"recom": @"Recom", @"units": @"Units", @"type": @"Type", @"standby": @"Standby", @"alias": @"Alias", @"prop": @"Prop"};
}

@end



