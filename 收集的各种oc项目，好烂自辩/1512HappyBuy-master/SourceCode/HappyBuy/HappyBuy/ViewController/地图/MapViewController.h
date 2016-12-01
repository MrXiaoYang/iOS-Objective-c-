//
//  MapViewController.h
//  HappyBuy
//
//  Created by jiyingxin on 16/4/3.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessViewModel.h"

@interface MapViewController : UIViewController

@property (nonatomic) NSString *category;
@property (nonatomic) BusinessViewModel *businessVM;
@end
