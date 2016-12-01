//
//  AppDelegate.h
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 各种小提示:
 1.做音频播放的同学，不要添加全局断点，会导致播放音频时项目崩溃，且此崩溃无处可查。
 2.兔玩服务器要求请求参数不能为中文，需要把中文转换为 % 号形势
 3.带有分页的接口一定要抓取2个以上，这样才能找到分页规律
 4.http://www.cocoachina.com/ios/20150629/12298.html 这网址介绍了注释的写法，很赞。可以让你成为人见人爱的队友。
 5.插件HHEnumeration，可以自动提示枚举类型的变量
 
 */
#import <RESideMenu.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) RESideMenu *sideMenu;

@property(nonatomic,getter=isOnLine) BOOL onLine; //网络状态


@end

