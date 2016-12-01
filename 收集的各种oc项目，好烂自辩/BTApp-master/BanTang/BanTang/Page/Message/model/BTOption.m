//
//  BTOption.m
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTOption.h"

@implementation BTOption

- (instancetype)initWithName:(NSString *)name
                        icon:(NSString *)icon
                 pushVCClass:(Class)pushVCClass
{
    return [[[self class] alloc] initWithName:name
                                         icon:icon
                                  detailValue:nil
                                  pushVCClass:nil];
}

- (instancetype)initWithName:(NSString *)name
                        icon:(NSString *)icon
{
    return [[[self class] alloc] initWithName:name
                                         icon:icon
                                  detailValue:nil
                                  pushVCClass:nil];
}

- (instancetype)initWithName:(NSString *)name
                        icon:(NSString *)icon
                 detailValue:(NSString *)detailValue
{
    return [[[self class] alloc] initWithName:name
                                         icon:icon
                                  detailValue:detailValue
                                  pushVCClass:nil];
}
/**
 *  万能初始化构造器
 *
 *  @param name        名字
 *  @param icon        图片
 *  @param detailValue 详细值
 *  @param pushVCClass push的控制器
 *  @param block       点击block
 *
 *  @return option
 */
- (instancetype)initWithName:(NSString *)name
                        icon:(NSString *)icon
                 detailValue:(NSString *)detailValue
                 pushVCClass:(Class)pushVCClass
{
    BTOption *option = [[BTOption alloc] init];
    option.name = name;
    option.icon = icon;
    option.detailValue = detailValue;
    option.pushVCClass = pushVCClass;
    return option;
}
@end
