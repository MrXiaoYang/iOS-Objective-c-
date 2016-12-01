//
//  Constants.h
//  HappyBuy
//
//  Created by tarena on 16/3/28.
//  Copyright © 2016年 tedu. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

/** RGB颜色宏 */
#define kRGBColor(R,G,B,Alpha) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:Alpha]

/** 屏幕宽 */
#define kScreenW [UIScreen mainScreen].bounds.size.width
/** 屏幕高 */
#define kScreenH [UIScreen mainScreen].bounds.size.height

//在宏中使用\可以达到换行的效果
#define WK(weakSelf) \
__weak __typeof(&*self)weakSelf = self;


/** 存储当前选中的城市 */
#define kCurrentCityName  @"kCurrentCityName"
/** 当前城市 */
#define kCurrentCity [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentCityName]

/** 当前城市变化的通知 */
#define kCurrentCityChangedNotification @"kCurrentCityChangedNotification"

//Documents文件夹的路径
#define kDocPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
//appdelegate的实例对象
#import "AppDelegate.h"
#define kAppdelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#endif /* Constants_h */









