//
//  BTProductListVC.h
//  BanTang
//
//  Created by Ryan on 15/12/2.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMPZoomTransitionAnimator.h"

@interface BTProductListVC : UIViewController <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>

@property (nonatomic, copy) NSString *extendID;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) CGFloat startHeight;

@end
