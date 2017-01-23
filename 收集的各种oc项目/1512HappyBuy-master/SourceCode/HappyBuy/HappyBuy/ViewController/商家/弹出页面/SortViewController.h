//
//  SortViewController.h
//  HappyBuy
//
//  Created by jiyingxin on 16/4/10.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "AlertViewController.h"
#import "PlistDataManager.h"
@interface SortViewController : AlertViewController

@property (nonatomic, copy) void(^chooseSortHandler)(SortsModel *sortModel);

@end
