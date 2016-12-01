//
//  SocialWebViewController.h
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/3.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SocialWebViewController : BaseViewController

@property (nonatomic, assign) int websiteId;

/**
 *  加载webView
 */
- (void)loadRequest;

@end
