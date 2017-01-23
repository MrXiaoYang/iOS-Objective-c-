//
//  BaseInfoViewController.h
//  BiliBili
//
//  Created by apple-jd44 on 15/12/2.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMMenuView.h"
#import "JHViewController.h"
#import "ResolutionView.h"

#define MENEVIEWHEIGHT 40

#define MAXOFFSET self.tableView.tableHeaderView.frame.size.height

#define MINOFFSET 0

#define EDGE 10

@class TakeHeadTableView,WMMenuView;
@interface BaseInfoViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,WMMenuViewDelegate,JHViewControllerDelegate>
@property (strong, nonatomic) TakeHeadTableView *tableView;
@property (nonatomic, strong) WMMenuView* menuView;
@property (nonatomic, strong) id vm;
@property (nonatomic, strong) NSString *resolution;
/**
 *  下载视图
 */
@property (nonatomic, strong) UIView* downLoadView;

- (void)setWithModel:(id)model section:(NSString*)section;
/**
 *  初始化属性
 */
- (void)setProperty;
/**
 *  初始化其它只需要加载一次的属性
 */
- (void)setOtherProperty;
/**
 *  监听分集变化通知
 *
 */
- (void)changeEpisode:(NSNotification*)notification;

- (NSArray*)allEpisode;
@end
