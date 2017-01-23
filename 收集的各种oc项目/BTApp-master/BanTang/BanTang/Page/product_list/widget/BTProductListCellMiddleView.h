//
//  BTProductListCellMiddleView.h
//  BanTang
//
//  Created by Ryan on 15/12/4.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BTProduct;
@interface BTProductListCellMiddleView : UIView

+ (instancetype)middleView;

@property (nonatomic, strong) BTProduct *product;

@property (nonatomic, copy) NSString *productPicHost;

@end
