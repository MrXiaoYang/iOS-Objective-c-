//
//  NHHomeViewController.h
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//


#import "NHBaseViewController.h"

@class NHServiceListModel;
@interface NHHomeViewController : NHBaseViewController
@property (nonatomic, strong) NSArray <NHServiceListModel *>*models;
@end
