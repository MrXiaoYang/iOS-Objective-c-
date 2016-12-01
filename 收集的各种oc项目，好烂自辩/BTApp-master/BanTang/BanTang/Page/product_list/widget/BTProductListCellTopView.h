//
//  BTProductListCellTopView.h
//  BanTang
//
//  Created by Ryan on 15/12/4.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BTProduct;

@interface BTProductListCellTopView : UIView

+ (instancetype)topView;

@property (nonatomic, strong) BTProduct *product;

@end
