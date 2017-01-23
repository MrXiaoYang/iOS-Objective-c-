//
//  MainViewModel.h
//  HappyBuy
//
//  Created by tarena on 16/3/31.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlistDataManager.h"
/*
 ViewModel层是 介于 请求层和控制器之间. 用于完成视图显示和底层数据模型之间的逻辑.
 原则: ViewModel绝对不会出现UI开头的类
 */

@interface MainViewModel : NSObject
/** 根据UI定义属性和方法 */
@property (nonatomic) NSInteger rowNumber;
- (NSString *)iconNameForIndex:(NSInteger)index;
- (NSString *)titleForIndex:(NSInteger)index;
/** 根据Model定义属性和方法 */
@property (nonatomic, strong) NSArray<MenuDataModel *> *menuDataList;
- (void)getMenuData:(void(^)(NSError *error))completionHandler;

@end







