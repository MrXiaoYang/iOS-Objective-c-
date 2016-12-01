//
//  AppDelegate+Location.h
//  HappyBuy
//
//  Created by tarena on 16/4/1.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "AppDelegate.h"
//@import Xcode7之后的新特性, 好处就是不需要到Build Phaze里面去引入类库了
@import CoreLocation;

@interface AppDelegate (Location)<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
- (void)setupLocation;

@end










