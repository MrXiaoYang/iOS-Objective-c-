//
//  BaseInfoViewController.m
//  BiliBili
//
//  Created by apple-jd44 on 15/12/2.
//  Copyright © 2015年 JimHuang. All rights reserved.
//


#import "BaseInfoViewController.h"
#import "DownLoadTableViewController.h"

#import "AVInfoViewModel.h"

#import "ShiBanEpisodesTableViewCell.h"

#import "TakeHeadTableView.h"

@interface BaseInfoViewController ()

@property (nonatomic, strong) JHViewController* pageViewController;


@property (nonatomic, strong) NSValue* topFrame;
/**
 *  下载按钮
 */
@property (nonatomic, strong) UIButton* downLoadButton;

/**
 *  黑底
 */
@property (nonatomic, strong) UIView *blackView;
/**
 *  清晰度选择视图
 */
@property (nonatomic, strong) ResolutionView *ResolutionView;

@property (nonatomic, strong) NSMutableArray *controllers;
@end

@implementation BaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.pageViewController];
    //监听清晰度变化通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeResolution:) name:@"changeResolution" object:nil];
    //监听下载分集变化通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEpisode:) name:@"changeEpisode" object:nil];
    
    self.downLoadButton.hidden = NO;
    
    __block typeof(self) weakObj = self;
    self.tableView.mj_header = [MyRefreshComplete myRefreshHead:^{
        [self.vm refreshDataCompleteHandle:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            [self setProperty];
            [self setOtherProperty];
            for (UITableViewController* c in weakObj.controllers) {
                [c.tableView reloadData];
            }
            if (error) [MBProgressHUD showMsg:kerrorMessage WithView:self.view];
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tableView.mj_header endRefreshing];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - tableViewController
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"avInfoCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"avInfoCell"];
    }
    cell.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
    UIView* v =  [cell viewWithTag: 100];
    if (v == nil) {
        self.pageViewController.view.tag = 100;
        [cell.contentView addSubview: self.pageViewController.view];
        [self.pageViewController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return MENEVIEWHEIGHT;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWindowH - [self.topFrame CGRectValue].size.height - MENEVIEWHEIGHT;
}

#pragma mark - 方法
/**
 *  刷新后需要执行的方法 在子类重写
 */
- (void)setProperty{
    
}
/**
 *  刷新后需要执行一次的方法 在子类重写
 */
- (void)setOtherProperty{
    
}
/**
 *  获取所有分集 在子类重写
 *
 *  @return 分集数组
 */
- (NSArray*)allEpisode{
    return nil;
}

- (void)colorSetting{
    self.tableView.tableHeaderView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"AVInfoViewController.headView.backgroundColor"];
    self.tableView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
}

/**
 *  显示下载视图
 */
- (void)showDownLoadView{
    [UIView animateWithDuration:0.3 animations:^{
        self.downLoadView.alpha = 1.0;
        self.blackView.alpha = 0.5;
    }];
}

/**
 *  隐藏下载视图
 */
- (void)hideDownView{
    [self hideResolutionView];
    [UIView animateWithDuration:0.3 animations:^{
        self.downLoadView.alpha = 0;
        self.blackView.alpha = 0;
    }];
}
/**
 *  显示清晰度选择视图
 */
- (void)showResolutionView{
    [UIView animateWithDuration:0.3 animations:^{
        self.ResolutionView.alpha = 1;
    }];
}
/**
 *  隐藏清晰度选择视图
 */
- (void)hideResolutionView{
    if (self.ResolutionView.alpha == 0) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.ResolutionView.alpha = 0;
    }];
}

- (void)changeResolution:(NSNotification*)notification{
    NSDictionary *userInfo = notification.userInfo;
    UIButton* button = (UIButton* _Nullable)[self.downLoadView viewWithTag: 11];
    self.resolution = userInfo[@"title"];
    [button setTitle:@{@"high":@"精美画质",@"normal":@"普通画质",@"low":@"渣画质"}[self.resolution] forState:UIControlStateNormal];
    [self hideResolutionView];
}

- (void)changeEpisode:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    [self.vm downLoadVideoWithAidArray:@[@{@"aid":userInfo[@"episode"],@"quality":self.resolution,@"cid":userInfo[@"cid"],@"title":userInfo[@"title"]}] CompleteHandle:^(id responseObj, NSError *error) {
        if (error) [MBProgressHUD showMsg:@"离线失败" WithView:self.view];
        else [MBProgressHUD showMsg:@"离线成功" WithView:self.view];
    }];
}

- (void)setChildrenScrollEnabled{
    for (UITableViewController* vc in self.controllers) {
        vc.tableView.scrollEnabled = YES;
    }
}

- (void)setWithModel:(id)model section:(NSString*)section{
    
}

- (void)touchAllCacheButton{
    [self.vm downLoadVideoWithAidArray:[self allEpisode] CompleteHandle:^(id responseObj, NSError *error) {
        if (error) [MBProgressHUD showMsg:@"离线失败" WithView:self.view];
        else [MBProgressHUD showMsg:@"离线成功" WithView:self.view];
    }];
}

- (void)touchCacheListButton{
    [self.navigationController pushViewController:[[DownLoadTableViewController alloc] init] animated:YES];
}

#pragma mark - JHViewController

- (void)JHViewGetOffset:(CGPoint)offset{
    [self.menuView slideMenuAtProgress: offset.x / self.menuView.frame.size.width];
}

#pragma mark - WMMenuView
- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index{
    return self.view.frame.size.width / ([self.vm isShiBan]?4:3);
}
- (void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex{
    [self.pageViewController setScrollViewPage:index];
}

#pragma mark - UIScrollerView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y > MAXOFFSET){
        [scrollView setContentOffset:CGPointMake(0, MAXOFFSET)];
        scrollView.scrollEnabled = NO;
        [self setChildrenScrollEnabled];
    }
}

#pragma mark - 懒加载
- (NSValue *)topFrame{
    if (_topFrame == nil) {
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        CGRect rectNav = self.navigationController.navigationBar.frame;
        rectStatus.size.height += rectNav.size.height;
        _topFrame = [NSValue valueWithCGRect: rectStatus];
    }
    return _topFrame;
}

- (TakeHeadTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[TakeHeadTableView alloc] initWithHeadHeight:kWindowW * 0.4 + 30];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview: _tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _tableView;
}

- (JHViewController *)pageViewController{
    if (_pageViewController == nil) {
        _pageViewController = [[JHViewController alloc] initWithControllers:[self.controllers copy]];
        _pageViewController.delegate = self;
    }
    return _pageViewController;
}

- (UIButton *)downLoadButton{
    if(_downLoadButton == nil) {
        _downLoadButton = [[UIButton alloc] init];
        [_downLoadButton setImage:[UIImage imageNamed:@"ic_file_download_black"] forState:UIControlStateNormal];
        [_downLoadButton setBackgroundColor:[[ColorManager shareColorManager] colorWithString:@"backgroundColor"]];
        [self.view addSubview: _downLoadButton];
        [_downLoadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
        //显示下载视图
        [_downLoadButton addTarget:self action:@selector(showDownLoadView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downLoadButton;
}

- (UIView *)downLoadView {
    if(_downLoadView == nil) {
        _downLoadView = [[UIView alloc] init];
        _downLoadView.alpha = 0;
        _downLoadView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
        
        [self.view insertSubview:_downLoadView atIndex: 3];
        [_downLoadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.equalTo(self.downLoadButton);
            make.height.mas_equalTo(kWindowH / 2);
        }];
        
        //全部缓存按钮
        UIButton* allCacheButton = [[UIButton alloc] init];
        allCacheButton.titleLabel.font = [UIFont systemFontOfSize: 14];
        [allCacheButton setTitleColor:[[ColorManager shareColorManager] colorWithString:@"textColor"] forState:UIControlStateNormal];
        [allCacheButton setTitle:@"全部缓存" forState:UIControlStateNormal];
        
        //全部缓存
        [allCacheButton addTarget:self action:@selector(touchAllCacheButton) forControlEvents:UIControlEventTouchUpInside];
        
        [_downLoadView addSubview: allCacheButton];
        [allCacheButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(0);
            make.height.mas_equalTo(_downLoadView.superview.mas_height).multipliedBy(0.15);
        }];
        
        //画质选择按钮
        UIButton* resolutionButton = [[UIButton alloc] init];
        resolutionButton.tag = 11;
        resolutionButton.titleLabel.font = [UIFont systemFontOfSize: 14];
        [resolutionButton setTitleColor:[[ColorManager shareColorManager] colorWithString:@"textColor"] forState:UIControlStateNormal];
        [resolutionButton addTarget:self action:@selector(showResolutionView) forControlEvents:UIControlEventTouchUpInside];
        [resolutionButton setTitle:@"普通画质" forState:UIControlStateNormal];
        [_downLoadView addSubview: resolutionButton];
        [resolutionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(allCacheButton.mas_right);
            make.size.equalTo(allCacheButton);
            make.centerY.equalTo(allCacheButton);
        }];
        
        
        UIButton* cacheListButton = [[UIButton alloc] init];
        cacheListButton.titleLabel.font = [UIFont systemFontOfSize: 14];
        [cacheListButton setTitleColor:[[ColorManager shareColorManager] colorWithString:@"textColor"] forState:UIControlStateNormal];
        [cacheListButton setTitle:@"离线列表" forState:UIControlStateNormal];
        //推出离线下载视图
        [cacheListButton addTarget:self action:@selector(touchCacheListButton) forControlEvents:UIControlEventTouchUpInside];
        
        [_downLoadView addSubview: cacheListButton];
        [cacheListButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(resolutionButton.mas_right);
            make.size.equalTo(resolutionButton);
            make.centerY.equalTo(resolutionButton);
            make.right.mas_equalTo(0);
        }];
        
    }
    return _downLoadView;
}


- (UIView *)blackView {
    if(_blackView == nil) {
        _blackView = [[UIView alloc] init];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0;
        [_blackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDownView)]];
        [self.view insertSubview:_blackView atIndex:1];
        [_blackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _blackView;
}

- (ResolutionView *)ResolutionView {
    if(_ResolutionView == nil) {
        _ResolutionView = [[ResolutionView alloc] init];
        _ResolutionView.alpha = 0;
        [self.view addSubview: _ResolutionView];
        [_ResolutionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(100);
            make.width.mas_equalTo(80);
            make.bottom.mas_equalTo(self.downLoadButton.mas_top).mas_offset(-10);
            make.centerX.equalTo(self.downLoadView);
        }];
    }
    return _ResolutionView;
}

- (NSString *)resolution{
    if (_resolution == nil) {
        _resolution = @"normal";
    }
    return _resolution;
}

@end
