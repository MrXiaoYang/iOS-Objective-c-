//
//  AppDelegate+System.h

//

#import "AppDelegate.h"
#import <AFNetworkActivityIndicatorManager.h>
#import <AFNetworkReachabilityManager.h>

@interface AppDelegate (System)

- (void)setupGlobalConfig;

- (AFNetworkReachabilityStatus)netReachStatus;
- (BOOL)isOnLine;
@end
