//
//  ZealerVideoWebViewController.h
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/6.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , Requestype) {
    ScrollViewFirstRequest,
    ScrollViewCollectionRequest,
    ScrollViewTableCellRequest
};

@interface ZealerVideoWebViewController : UIViewController

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic ,assign) Requestype type;

@end
