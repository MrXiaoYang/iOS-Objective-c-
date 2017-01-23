//
//  BTProfileHeaderView.h
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTUserInfo;
@interface BTProfileHeaderView : UIView

+ (instancetype)headerView;

@property (nonatomic, strong) BTUserInfo *userInfo;

@end