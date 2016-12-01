//
//  ZBCategoryViewModel.h
//  BaseProject
//
//  Created by jiyingxin on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "DuoWanNetManager.h"

@interface ZBCategoryViewModel : BaseViewModel
/** 行数 */
@property(nonatomic) NSInteger rowNumber;
/** 某行tag值 */
- (NSString *)tagForRow:(NSInteger)row;
/** 某行题目 */
- (NSString *)titleForRow:(NSInteger)row;
@end
