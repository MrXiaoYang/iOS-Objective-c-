//
//  ShiBanInfoViewController.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/24.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseInfoViewController.h"
@class RecommentShinBanDataModel;
@interface ShiBanInfoViewController : BaseInfoViewController
@property (nonatomic, strong) NSMutableArray* controllers;
- (void)setWithModel:(RecommentShinBanDataModel*)model;
@end
