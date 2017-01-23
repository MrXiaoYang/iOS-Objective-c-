//
//  BTOption.h
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BTOption : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *detailValue;

@property (nonatomic, strong) Class pushVCClass;


- (instancetype)initWithName:(NSString *)name
                        icon:(NSString *)icon;

- (instancetype)initWithName:(NSString *)name
                        icon:(NSString *)icon
                 pushVCClass:(Class)pushVCClass;

- (instancetype)initWithName:(NSString *)name
                        icon:(NSString *)icon
                 detailValue:(NSString *)detailValue;
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
                 pushVCClass:(Class)pushVCClass;

@end
