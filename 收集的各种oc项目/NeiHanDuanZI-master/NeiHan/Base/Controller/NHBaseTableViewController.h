//
//  NHBaseTableViewController.h
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseViewController.h"
#import "NHBaseTableViewCell.h"
#import "NHBaseTableView.h"

typedef void(^NHTableVcCellSelectedHandle)(NHBaseTableViewCell *cell, NSIndexPath *indexPath);

typedef NS_ENUM(NSUInteger, NHBaseTableVcRefreshType) {
    /** 无法刷新*/
    NHBaseTableVcRefreshTypeNone = 0,
    /** 只能刷新*/
    NHBaseTableVcRefreshTypeOnlyCanRefresh,
    /** 只能上拉加载*/
    NHBaseTableVcRefreshTypeOnlyCanLoadMore,
    /** 能刷新*/
    NHBaseTableVcRefreshTypeRefreshAndLoadMore
};
@interface NHBaseTableViewController : NHBaseViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *_dataArray;
}

/** 刚才执行的是刷新*/
@property (nonatomic, assign) NSInteger isRefresh;

/** 刚才执行的是上拉加载*/
@property (nonatomic, assign) NSInteger isLoadMore;

/** 添加空界面文字*/
- (void)nh_addEmptyPageWithText:(NSString *)text;

/** 设置导航栏右边的item*/
- (void)nh_setUpNavRightItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *rightItemTitle))handle;

/** 设置导航栏左边的item*/
- (void)nh_setUpNavLeftItemTitle:(NSString *)itemTitle handle:(void(^)(NSString *rightItemTitle))handle;

/** 监听通知*/
- (void)nh_observeNotiWithNotiName:(NSString *)notiName action:(SEL)action;

/** 隐藏statusBar*/
@property (nonatomic, assign) BOOL hiddenStatusBar;

/** statusBar风格*/
@property (nonatomic, assign) UIStatusBarStyle barStyle;

/** 导航右边Item*/
@property (nonatomic, strong) UIBarButtonItem *navRightItem;

/** 导航左边Item*/
@property (nonatomic, strong) UIBarButtonItem *navLeftItem;

/** 标题*/
@property (nonatomic, copy) NSString *navItemTitle;

/** 表视图*/
@property (nonatomic, weak) NHBaseTableView *tableView;

/** 表视图偏移*/
@property (nonatomic, assign) UIEdgeInsets tableEdgeInset;

/** 分割线颜色*/
@property (nonatomic, assign) UIColor *sepLineColor;

/** 数据源数量*/
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 加载刷新类型*/
@property (nonatomic, assign) NHBaseTableVcRefreshType refreshType;

/** 是否需要系统的cell的分割线*/
@property (nonatomic, assign) BOOL needCellSepLine;

/** 刷新数据*/
- (void)nh_reloadData;

/** 开始下拉*/
- (void)nh_beginRefresh;

/** 停止刷新*/
- (void)nh_endRefresh;

/** 停止上拉加载*/
- (void)nh_endLoadMore;

/** 隐藏刷新*/
- (void)nh_hiddenRrefresh;

/** 隐藏上拉加载*/
- (void)nh_hiddenLoadMore;

/** 提示没有更多信息*/
- (void)nh_noticeNoMoreData;

/** 配置数据*/
- (void)nh_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass;

/** 配置数据*/
- (void)nh_commonConfigResponseWithResponse:(id)response isRefresh:(BOOL)isRefresh modelClass:(__unsafe_unretained Class)modelClass emptyText:(NSString *)emptyText;

/** 是否在下拉刷新*/
@property (nonatomic, assign, readonly) BOOL isHeaderRefreshing;

/** 是否在上拉加载*/
@property (nonatomic, assign, readonly) BOOL isFooterRefreshing;

#pragma mark - 子类去重写
/** 分组数量*/
- (NSInteger)nh_numberOfSections;

/** 某个分组的cell数量*/
- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section;

/** 某行的cell*/
- (NHBaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath;

/** 点击某行*/
- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(NHBaseTableViewCell *)cell;

/** 某行行高*/
- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath;

/** 某个组头*/
- (UIView *)nh_headerAtSection:(NSInteger)section;

/** 某个组尾*/
- (UIView *)nh_footerAtSection:(NSInteger)section;

/** 某个组头高度*/
- (CGFloat)nh_sectionHeaderHeightAtSection:(NSInteger)section;

/** 某个组尾高度*/
- (CGFloat)nh_sectionFooterHeightAtSection:(NSInteger)section;

/** 分割线偏移*/
- (UIEdgeInsets)nh_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 子类去继承
/** 刷新方法*/
- (void)nh_refresh;

/** 上拉加载方法*/
- (void)nh_loadMore;

@property (nonatomic, assign) BOOL showRefreshIcon;

- (void)endRefreshIconAnimation;

@property (nonatomic, weak, readonly) UIView *refreshHeader;

#pragma mark - loading & alert
- (void)nh_showLoading;

- (void)nh_hiddenLoading;

- (void)nh_showTitle:(NSString *)title after:(NSTimeInterval)after;


@end
