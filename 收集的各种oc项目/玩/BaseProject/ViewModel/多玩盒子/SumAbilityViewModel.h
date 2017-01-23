//
//  SumAbilityViewModel.h
//  BaseProject
//
//  Created by jiyingxin on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "DuoWanNetManager.h"

@interface SumAbilityViewModel : BaseViewModel

@property(nonatomic) NSInteger rowNumber;

/** 返回某行的数据类型，主要用于给详情页传值 */
- (SumAbilityModel *)modelForRow:(NSInteger)row;

- (NSString *)titleForRow:(NSInteger)row;
- (NSURL *)iconURLForRow:(NSInteger)row;

@end
