//
//  NHDiscoverTopicViewController.h
//  NeiHan
//
//  Created by Charles on 16/9/2.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseViewController.h"

@class NHDiscoverCategoryElement;
@interface NHDiscoverTopicViewController : NHBaseViewController

/** 
 * 构造方法
 * catogoryId : 分类Id
 */
- (instancetype)initWithCatogoryId:(NSInteger)categoryId;

- (instancetype)initWithCategoryElement:(NHDiscoverCategoryElement *)element;
@end
