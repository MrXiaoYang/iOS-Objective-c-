//
//  BaseModel.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

MJCodingImplementation

//替换  一些key值  以便字典转模型的 
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"typeName": @"typename", @"ID": @"id", @"desc": @"description"};
}
@end






