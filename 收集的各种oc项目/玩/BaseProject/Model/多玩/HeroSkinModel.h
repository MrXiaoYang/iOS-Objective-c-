//
//  HeroSkinModel.h
//  BaseProject
//  英雄皮肤
//  Created by jiyingxin on 15/11/2.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"
//只有遇到字典才新建类型，类似于英雄皮肤这个接口，根是数组，则不用新建类型。 直接创建数组内部元素
/*解析规则
 1.遇到字典则新建类型
 2.属性命名不能是系统关键词，如果改动key，需要在.m文件中重写replacedKeyFromPropertyName方法， key是属性，值是原始值，例如  @{@"desc": @"description", @"ID":@"id"}
 */
@interface HeroSkinModel : BaseModel
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *bigImg;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *smallImg;
@end







