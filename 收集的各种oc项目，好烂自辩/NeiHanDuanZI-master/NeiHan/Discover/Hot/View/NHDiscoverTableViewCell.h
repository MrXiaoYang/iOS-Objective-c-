//
//  NHDiscoverTableViewCell.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseTableViewCell.h"

@class NHDiscoverCategoryElement;
@interface NHDiscoverTableViewCell : NHBaseTableViewCell
/** 设置数据*/
@property (nonatomic, strong) NHDiscoverCategoryElement *elementModel;

- (void)setElementModel:(NHDiscoverCategoryElement *)elementModel keyWord:(NSString *)keyWord;

@end
