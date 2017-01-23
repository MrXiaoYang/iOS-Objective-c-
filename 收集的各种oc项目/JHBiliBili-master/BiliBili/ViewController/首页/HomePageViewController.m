//
//  HomePageViewController.m
//  BiliBili
//
//  Created by apple-jd44 on 15/10/31.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "HomePageViewController.h"
#import "ProfileTableViewController.h"
#import "SearchViewController.h"

#import "WMMenuView.h"
#import "SearchView.h"

CGFloat const MENUHEIGHT = 35;
CGFloat const MAXBLACKVIEWALPHA = 0.5;
CGFloat const BLACKVIEWSIZESCALE = 0.75;
@interface HomePageViewController ()<WMMenuViewDelegate, JHViewControllerDelegate, SearchViewDelegate>
@property (nonatomic, strong) WMMenuView *menuView;
@property (nonatomic, strong) UIPanGestureRecognizer *panG;
//侧边栏视图 用于判断触摸点是否在左侧
@property (nonatomic, strong) UIView *profileView;
//半透明黑色视图
@property (nonatomic, strong) UIView *blackView;
/**
 *  搜索按钮
 */
@property (nonatomic, strong)UIButton *searchButton;
/**
 *  主页按钮
 */
@property (nonatomic, strong)UIButton *homeButton;
@end

@implementation HomePageViewController

#pragma mark - 懒加载

- (UIPanGestureRecognizer *)panG{
    if (_panG == nil) {
        _panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMove:)];
    }
    return _panG;
}

- (UIButton *)searchButton{
    if(_searchButton == nil) {
        _searchButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 20, 20)];
        [_searchButton setImage:[UIImage imageNamed: @"ic_toolbar_menu_search"] forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(showSearchView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

- (UIButton *) homeButton {
    if(_homeButton == nil) {
        _homeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
        [_homeButton setImage:[UIImage imageNamed:@"ic_drawer_home"] forState:UIControlStateNormal];
        [_homeButton addTarget:self action:@selector(profileViewMoveToDestination) forControlEvents:UIControlEventTouchUpInside];
    }
    return _homeButton;
}

- (WMMenuView *)menuView{
    if (_menuView == nil) {
        _menuView = [[WMMenuView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, MENUHEIGHT) buttonItems:@[@"番剧",@"推荐",@"发现"] backgroundColor:[[ColorManager shareColorManager] colorWithString:@"themeColor"] norSize:15 selSize:15 norColor:[[ColorManager shareColorManager] colorWithString:@"HomePageViewController.menuView.norColor"] selColor:[[ColorManager shareColorManager] colorWithString:@"HomePageViewController.menuView.selColor"]];
        _menuView.delegate = self;
        _menuView.style = WMMenuViewStyleLine;
    }
    return _menuView;
}

- (UIView *)profileView{
    if(_profileView == nil) {
        //用于触发侧滑手势
        UIView* panView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.view.frame.size.height)];
        [panView addGestureRecognizer: self.panG];
        [self.view addSubview: panView];
        
        //侧边栏
        CGRect rect = self.view.frame;
        rect.size.width =  rect.size.width *BLACKVIEWSIZESCALE;
        rect.origin.x = -rect.size.width;
        _profileView = [[UIView alloc] initWithFrame:rect];
        ProfileTableViewController* tableVC = [[ProfileTableViewController alloc] init];
        [_profileView addSubview: tableVC.tableView];
        [tableVC.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.profileView);
        }];
        [self addChildViewController: tableVC];
        
        [_profileView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMove:)]];
    }
    return _profileView;
}

- (UIView *)blackView {
    if(_blackView == nil) {
        _blackView = [[UIView alloc] initWithFrame: self.view.frame];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0;
        [_blackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileViewMoveToOriginal)]];
        [_blackView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMove:)]];
    }
    return _blackView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - JHViewController
- (void)JHViewGetOffset:(CGPoint)offset{
    [self.menuView slideMenuAtProgress:offset.x / self.menuView.frame.size.width];
}

#pragma mark - WMMenuView
- (void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex{
    [self setScrollViewPage:index];
}
#pragma mark - SearchView
- (void)searchButtonDown:(SearchView *)searchView searchText:(NSString *)searchText{
    if (![searchText isEqualToString: @""] && searchText != nil) {
        __weak typeof(self)weakSelf = self;
        [self hideSearchView: nil handel:^{
            [weakSelf.navigationController pushViewController:[[SearchViewController alloc] initWithkeyWord: searchText] animated:YES];
        }];
    }
}

#pragma mark - 方法
- (instancetype)initWithControllers:(NSArray *)controllers{
    if (self = [super initWithControllers:controllers]) {
        //顶部菜单视图
        [self.view addSubview: self.menuView];
        self.delegate = self;
        self.scrollView.bounces = NO;
        //重新指定滚动视图约束
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).mas_offset(MENUHEIGHT);
        }];
        
        [self.view addSubview: self.blackView];
        [self.view addSubview: self.profileView];
        
        //使用弹簧控件缩小菜单按钮和边缘距离
        UIBarButtonItem *spaceItemRight=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItemRight.width = -13;
        self.navigationItem.rightBarButtonItems = @[spaceItemRight,[[UIBarButtonItem alloc] initWithCustomView: self.searchButton]];
        
        //使用弹簧控件缩小菜单按钮和边缘距离
        UIBarButtonItem *spaceItemLeft=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItemLeft.width = -13;
        self.navigationItem.leftBarButtonItems = @[spaceItemLeft,[[UIBarButtonItem alloc] initWithCustomView: self.homeButton]];
        
    }
    return self;
}

/**
 *  手势移动方法
 *
 */
- (void)panMove:(UIPanGestureRecognizer*)sender{
    
    //每次移动的值
    CGFloat moveValue = [sender translationInView:nil].x;
    //侧边栏新的位置
    CGRect newPosition = self.profileView.frame;
    if (newPosition.origin.x < 0 || (newPosition.origin.x == 0 && [sender velocityInView:nil].x < 0)) {
        newPosition.origin.x += moveValue * BLACKVIEWSIZESCALE;
        self.profileView.frame = newPosition;
        //黑色视图透明值
        CGFloat blackViewAlpha = MAXBLACKVIEWALPHA + (newPosition.origin.x / newPosition.size.width) * MAXBLACKVIEWALPHA;
        self.blackView.alpha = blackViewAlpha;
    //视图偏移值超过最大值的时候
    }else{
        [self profileViewMoveToDestination];
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        //如果视图停留在超过视图一半宽的位置或者速度超过800 自动移动到指定位置
        if([sender velocityInView:nil].x > 800 || newPosition.origin.x > -newPosition.size.width / 2)
        {
            [self profileViewMoveToDestination];
        }else{
            [self profileViewMoveToOriginal];
        }
    }
    [sender setTranslation:CGPointZero inView:nil];
}
/** 侧边栏视图移动到目的地位置*/
- (void)profileViewMoveToDestination{
    CGRect destination = CGRectMake(0, 0, self.profileView.frame.size.width, self.profileView.frame.size.height);
    [UIView animateWithDuration:0.25 animations:^{
        [self.profileView setFrame: destination];
        [self showBlackView];
    }];
}
/** 侧边栏视图移动到初始位置*/
- (void)profileViewMoveToOriginal{
    CGRect destination = CGRectMake(-self.profileView.frame.size.width, 0, self.profileView.frame.size.width, self.profileView.frame.size.height);
    [UIView animateWithDuration:0.25 animations:^{
        [self.profileView setFrame: destination];
        [self hideBlackView];
        //将搜索视图隐藏
        [self hideSearchView: nil handel: nil];
    }];
}
/**
 *  隐藏黑色视图
 *
 */
- (void)hideBlackView{
    self.blackView.alpha = 0;
}
/**
 *  显示黑色视图
 *
 */
- (void)showBlackView{
    self.blackView.alpha = MAXBLACKVIEWALPHA;
}
/**
 *  显示搜索视图
 */
- (void)showSearchView:(UIButton*)button{
    SearchView* vc = (SearchView* _Nullable)[self.navigationController.view viewWithTag: 105];
    vc.delegate = self;
    [vc showSearchView];
    [UIView animateWithDuration:1 animations:^{
        [self showBlackView];
    }];
}
/**
 *  隐藏搜索视图
 */
- (void)hideSearchView:(UIButton*)button handel:(void(^)())handel{
    SearchView* vc = (SearchView* _Nullable)[self.navigationController.view viewWithTag: 105];
    [vc hideSearchView: handel];
    [self hideBlackView];
    [vc endEditing:YES];
}

- (void)colorSetting{
    self.view.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
    self.menuView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"themeColor"];
    self.navigationController.navigationBar.barTintColor = [[ColorManager shareColorManager] colorWithString:@"themeColor"];
}


@end
