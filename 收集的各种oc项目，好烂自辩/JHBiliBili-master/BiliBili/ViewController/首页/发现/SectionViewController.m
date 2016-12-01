//
//  SectionViewController.m
//  BiliBili
//
//  Created by apple-jd24 on 15/12/16.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SectionViewController.h"

#import "WMMenuView.h"

#define MENUHEIGHT 35
@interface SectionViewController ()<WMMenuViewDelegate, JHViewControllerDelegate>
@property (nonatomic, strong)NSArray* titleArr;
@property (nonatomic, strong)WMMenuView* menuView;
@end

@implementation SectionViewController
- (instancetype)initWithControllers:(NSArray *)controllers titles:(NSArray*)titles style:(NSString*)style{
    if (self = [super initWithControllers:controllers]) {
        self.titleArr = titles;
        self.navigationItem.title = style;
        self.delegate = self;
        self.scrollView.bounces = NO;
        self.view.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
        [self.view addSubview: self.menuView];
        //重新指定滚动视图约束
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).mas_offset(MENUHEIGHT);
        }];
    }
    return self;
}

#pragma mark - JHViewController
- (void)JHViewGetOffset:(CGPoint)offset{
    [self.menuView slideMenuAtProgress:offset.x / self.menuView.frame.size.width];
}

#pragma mark - WMMenuView
- (void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex{
    [self setScrollViewPage:index];
}

#pragma mark - 懒加载

- (WMMenuView *) menuView {
	if(_menuView == nil) {
        _menuView = [[WMMenuView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, MENUHEIGHT) buttonItems: self.titleArr backgroundColor:[[ColorManager shareColorManager] colorWithString:@"themeColor"] norSize:15 selSize:15 norColor:[[ColorManager shareColorManager] colorWithString:@"HomePageViewController.menuView.norColor"] selColor:[[ColorManager shareColorManager] colorWithString:@"HomePageViewController.menuView.selColor"]];
        _menuView.delegate = self;
        _menuView.style = WMMenuViewStyleLine;
	}
	return _menuView;
}

@end
