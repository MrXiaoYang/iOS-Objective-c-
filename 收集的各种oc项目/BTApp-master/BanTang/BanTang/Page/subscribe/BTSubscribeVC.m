//
//  BTSubscribeVC.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTSubscribeVC.h"
#import "BTSubscribeTag.h"
#import "BTNoHLbutton.h"

@interface BTSubscribeVC () <UISearchBarDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BTSubscribeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    
    [self loadData];
    
    [self setupNavItem];
}

- (void)loadData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"subscribe_tags.json" ofType:nil];
    
    NSData *jsonData =  [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    self.dataArray =  [BTSubscribeTag mj_objectArrayWithKeyValuesArray:dict[@"data"]];
    
    NSString *imageWName = @"";
    if (rx_iPhone5) {
        imageWName = @"320";
    }else if (rx_iPhone6){
        imageWName = @"375";
    }else if (rx_iPhone6P) {
        imageWName = @"414";
    }
    
    NSInteger maxColums = 2;
    CGFloat padding = 10;
    CGFloat btnW = (kScreen_Width - 3 * padding) / maxColums;
    CGFloat btnH = 105;
    
    for (NSInteger index = 0; index<self.dataArray.count; index++)
    {
        BTSubscribeTag *tag = self.dataArray[index];
        BTNoHLbutton *btn = [[BTNoHLbutton alloc] init];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString *imageName = [NSString stringWithFormat:@"%@_%@",tag.enName,imageWName];
        NSString *selectedImageName = [NSString stringWithFormat:@"GS_%@",imageName];
        UIImage *selectedImage = [self waterImageWithBgImageName:selectedImageName bgW:btnW bgH:100];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setImage:selectedImage forState:UIControlStateSelected];
        NSInteger col = index % maxColums;
        NSInteger row = index / maxColums;
        CGFloat btnX = padding + (btnW + padding) * col;
        CGFloat btnY = padding + (btnH + 25) * row;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [self.scrollView addSubview:btn];
        if (index == self.dataArray.count - 1)
        {
            self.scrollView.contentSize = CGSizeMake(kScreen_Width, CGRectGetMaxY(btn.frame) + 25);
        }
    }
}

- (UIImage *)waterImageWithBgImageName:(NSString *)name bgW:(CGFloat)btnW bgH:(CGFloat)btnH
{
    UIImage *bgImage = [UIImage imageNamed:name];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(btnW, btnH), NO, 0.0);
    
    // 2.画背景
    [bgImage drawInRect:CGRectMake(0, 0, btnW, btnH)];
    
    // 3.画右下角的水印
    UIImage *waterImage = [UIImage imageNamed:@"subcibe_check_icon"];
    CGFloat waterX = (btnW - 30) * 0.5;
    CGFloat waterY = (btnH - 30) * 0.4;
    [waterImage drawInRect:CGRectMake(waterX, waterY, 30, 30)];
    
    // 4.从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.结束上下文
    UIGraphicsEndImageContext();
    
    // 6.显示到UIImageView
    return newImage;
}

- (void)btnClick:(BTNoHLbutton *)btn
{
    btn.selected = !btn.isSelected;
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    NSLog(@"shouldBeginEditing");
    
    return YES;
}

#pragma mark 搜索框的代理方法，搜索输入框获得焦点（聚焦）
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    // 修改UISearchBar右侧的取消按钮文字颜色及背景图片
    for (UIView *searchbuttons in [searchBar subviews]){
        if ([searchbuttons isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton*)searchbuttons;
            // 修改文字颜色
            [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            
            [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
}

- (void)setupNavItem
{
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"搜索感兴趣的清单或单品";
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, kScreen_Width,44);
    searchBar.returnKeyType = UIReturnKeySearch;
    self.navigationItem.titleView = searchBar;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.bounds;
        _scrollView.height -= 64;
    }
    return _scrollView;
}


@end
