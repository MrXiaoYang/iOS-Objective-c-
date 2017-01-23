//
//  WebViewController.h
//  HappyBuy
//
//  Created by tarena on 16/4/1.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

- (instancetype)initWithURL:(NSURL *)webURL;

@property (nonatomic, strong) NSURL *webURL;

@end










