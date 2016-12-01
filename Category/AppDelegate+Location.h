//
//  AppDelegate+Location.h
//  http://www.jianshu.com/users/f60047bf604f/latest_articles
//

#import "AppDelegate.h"
//@import Xcode7之后的新特性, 好处就是不需要到Build Phaze里面去引入类库了
@import CoreLocation;

@interface AppDelegate (Location)<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
- (void)setupLocation;

@end










