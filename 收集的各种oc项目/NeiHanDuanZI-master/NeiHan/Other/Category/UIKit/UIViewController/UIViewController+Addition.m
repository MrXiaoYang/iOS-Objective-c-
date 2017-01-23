//
//  UIViewController+Addition.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "UIViewController+Addition.h"

@implementation UIViewController (Addition)

- (BOOL)isCurrentAndVisibleViewController {
    return self.isViewLoaded && self.view.window;
}

- (void)pushToNextViewController:(UIViewController *)nextVC {
    self.navigationController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}
@end
