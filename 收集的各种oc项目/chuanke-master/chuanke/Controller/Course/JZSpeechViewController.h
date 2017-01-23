//
//  JZSpeechViewController.h
//  chuanke
//
//  Created by jinzelu on 15/7/24.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/iflyMSC.h"


@interface JZSpeechViewController : UIViewController<IFlyRecognizerViewDelegate>


@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象

@end
