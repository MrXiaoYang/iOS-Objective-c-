//
//  RegionViewController.h
//  HappyBuy
//
//  Created by jiyingxin on 16/4/10.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "AlertViewController.h"

@interface RegionViewController : AlertViewController
@property (nonatomic, copy) void(^chooseRegionHandler)(NSString *region);
@end
