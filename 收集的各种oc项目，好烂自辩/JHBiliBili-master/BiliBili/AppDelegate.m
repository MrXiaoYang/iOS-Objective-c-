//
//  AppDelegate.m
//  BaseProject
//
//  Created by JimHuang on 15/10/21.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "RecommendViewController.h"
#import "ShinBanViewController.h"
#import "FindViewController.h"
#import "WMPageController.h"
#import "SearchView.h"
@interface AppDelegate ()
@property (nonatomic, strong) HomePageViewController* vc;
@property (nonatomic, strong) WMPageController* pvc;
@property (nonatomic, strong) UINavigationController* nav;
@property (strong, nonatomic) UIImageView* imgView;
/**
 *  启动动画底部view
 */
@property (strong, nonatomic) UIView* view;
/**
 *  搜索输入框
 */
@property (nonatomic, strong) SearchView* searchView;
@property (strong, nonatomic) NSMutableArray* arr;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self defaultsSetting];
    [self.window makeKeyAndVisible];
    [self.window addSubview:self.view];
    return YES;
}


#pragma mark - 方法
- (void)defaultsSetting{
    [[UINavigationBar appearance] setTranslucent:NO];
    /** 配置导航栏题目的样式 */
    [[UINavigationBar appearance] setBarTintColor: [[ColorManager shareColorManager] colorWithString:@"themeColor"]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
//    NSLog(@"arr---%@",kCachePath);
    //判断清空缓存是否标记
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"clearCache"] == YES) {
        NSArray<NSString*>* arr = [[NSFileManager defaultManager] subpathsAtPath: kCachePath];
        
        [arr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[NSFileManager defaultManager] removeItemAtPath:[kCachePath stringByAppendingPathComponent:obj] error:nil];
        }];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"clearCache"];
    }
    //判断视频清晰度是否默认为空
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"HightResolution"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"HightResolution"];
    }
}
/**
 *  启动动画
 */
- (void)animationEnd{
    self.arr = nil;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.8 animations:^{
        weakSelf.view.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.view removeFromSuperview];
    }];
}

#pragma mark - 懒加载

- (UIWindow *)window{
    if (_window == nil) {
        _window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
        _window.rootViewController = self.nav;
        _window.backgroundColor = [UIColor whiteColor];
    }
    return _window;
}
- (HomePageViewController *)vc{
    if (_vc == nil) {
        _vc = [[HomePageViewController alloc] initWithControllers:@[[[ShinBanViewController alloc] init], [[RecommendViewController alloc] init], [[FindViewController alloc] init]]];
        }
    return _vc;
}
- (UINavigationController *)nav{
    if (_nav == nil) {
        _nav = [[UINavigationController alloc] initWithRootViewController:self.vc];
        self.searchView.hidden = YES;
    }
    return _nav;
}

- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_splash_icon_00067"]];
        CGPoint p = self.window.center;
        p.y = self.window.frame.size.height - 50;
        _imgView.center = p;
        _imgView.animationImages = self.arr;
        // 设置动画的时长
        _imgView.animationDuration = 68*0.029;
        // 重复次数
        _imgView.animationRepeatCount = 1;
        // 开始动画
        [_imgView startAnimating];
        [self performSelector:@selector(animationEnd) withObject:nil afterDelay:_imgView.animationDuration];
    }
    return _imgView;
}

- (UIView *)view{
    if (_view == nil) {
        _view = [[UIView alloc] initWithFrame:self.window.frame];
        _view.backgroundColor = kRGBColor(246, 246, 246);
        [_view addSubview: self.imgView];
    }
    return _view;
}

- (SearchView *)searchView {
    if(_searchView == nil) {
        _searchView = [[SearchView alloc] init];
        _searchView.tag = 105;
        [self.nav.view addSubview: _searchView];
        [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(_searchView.superview).mas_offset(-10);
            make.height.mas_equalTo(40);
            make.centerX.mas_offset(0);
            make.top.mas_offset(25);
        }];
    }
    return _searchView;
}

- (NSMutableArray *)arr{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
        for (int i = 0; i < 68; i++) {
            // 生成图片路径
            NSString *imageName = [NSString stringWithFormat:@"ic_splash_icon_000%02d.png",i];
            NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
            // 创建图片对象
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            
            // 图片对象添加到数组中
            [_arr addObject:image];
        }
        
    }
    return _arr;
}

@end
