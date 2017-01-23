//
//  Factory.m
//  BaseProject
//
//  Created by yingxin on 15/12/13.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "Factory.h"

@implementation Factory


+ (void)addShowMenuBarItem:(UIViewController *)vc{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks handler:^(id sender) {
        [vc.sideMenuViewController presentLeftMenuViewController];
    }];
    
    vc.navigationItem.leftBarButtonItem = backItem;
}

@end
