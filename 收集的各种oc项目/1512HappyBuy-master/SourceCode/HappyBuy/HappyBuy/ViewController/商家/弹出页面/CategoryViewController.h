//
//  CategoryViewController.h
//  HappyBuy
//
//  Created by jiyingxin on 16/4/10.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "AlertViewController.h"

@interface CategoryViewController : AlertViewController
@property (nonatomic, copy) void(^chooseCategoryHandler)(NSString *category);
@end
