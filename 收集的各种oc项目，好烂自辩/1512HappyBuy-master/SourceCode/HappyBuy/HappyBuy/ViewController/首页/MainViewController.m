//
//  MainViewController.m
//  HappyBuy
//
//  Created by tarena on 16/3/31.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewModel.h"
#import "BusinessCell.h"
#import "BusinessViewModel.h"
#import "WebViewController.h"
#import "MapViewController.h"

#define kItemIconTag   100
#define kItemLabelTag   200

@interface MainViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
/** <#属性#> */
@property (nonatomic, strong) BusinessViewModel *businessVM;

@property (weak, nonatomic) IBOutlet UIPageControl *pageC;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** <#属性#> */
@property (nonatomic, strong) MainViewModel *mainVM;

/** 计算属性 */
@property (nonatomic) CGFloat lineSpace;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cityBarItem;

/** 存储当前选中的类别名称 */
@property (nonatomic, strong) NSString *category;

@end

@implementation MainViewController
#pragma mark - LazyLoad
- (BusinessViewModel *)businessVM{
    if (!_businessVM) {
        _businessVM = [BusinessViewModel new];
    }
    return _businessVM;
}

- (MainViewModel *)mainVM{
    if (!_mainVM) {
        _mainVM = [MainViewModel new];
    }
    return _mainVM;
}

// 这样通过计算返回值得属性 称为 计算属性
- (CGFloat)lineSpace{
    /*
     设 边距 = x, 间隔 = y, 屏幕宽=width
     解: y = 2x;
     2x + 3y + 4*60 = width;
     求:y?
     y + 3y = width - 4*60;
     4y = width - 4*60;
     y = (width - 4*60)/4;
     */
    return (kScreenW - 4*60)/4;
}
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.businessVM.rowNumber;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    cell.titleLb.text = [self.businessVM shopNameForIndex:row];
    [cell.iconIV setImageURL:[self.businessVM iconURLForIndex:row]];
    cell.buyNumLb.text = [self.businessVM saleNumForIndex:row];
    cell.price = [self.businessVM currentPriceForIndex:row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WebViewController *webVC = [[WebViewController alloc] initWithURL:[self.businessVM businessURLForIndex:indexPath.row]];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _collectionView) {
        _pageC.currentPage = _collectionView.contentOffset.x / kScreenW + 0.5;
    }
}

#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.category = [self.mainVM titleForIndex:indexPath.row];
    [self.view showBusyHUD];
    [self.businessVM getBusinessWithCategory:self.category requestMode:RequestModeRefresh completionHandler:^(NSError *error) {
        [self.view hideBusyHUD];
        if (error) {
            [self.view showWarning:error.localizedDescription];
        }else{
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.mainVM.rowNumber;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    UIImageView *iconIV = (UIImageView *)[cell.contentView viewWithTag:kItemIconTag];
    UILabel *titleLb = (UILabel *)[cell.contentView viewWithTag:kItemLabelTag];
    iconIV.image = [UIImage imageNamed:[self.mainVM iconNameForIndex:indexPath.row]];
    titleLb.text = [self.mainVM titleForIndex:indexPath.row];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.lineSpace;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, self.lineSpace/2, 15, self.lineSpace/2);
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];    
    self.category = @"美食";
    self.cityBarItem.title = kCurrentCity;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    [self.mainVM getMenuData:^(NSError *error) {
        //15 / 8 = 1
        //15 % 8 > 0  = 1(真)
        _pageC.numberOfPages = _mainVM.rowNumber/8 + (_mainVM.rowNumber%8 > 0);
        [_collectionView reloadData];
    }];
    //监听城市的变化
    /*
     监听添加的原则: 一定要有加有删
     对立的生命周期:
     viewWillAppear -> viewWillDisappear
     viewDidAppear -> viewDidDisappear
     viewDidLoad -> viewDidUnload(抛弃)->改为dealloc
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChanged:) name:kCurrentCityChangedNotification object:nil];
    
    [self.tableView addHeaderRefresh:^{
        [self.businessVM getBusinessWithCategory:self.category requestMode:RequestModeRefresh completionHandler:^(NSError *error) {
            if (error) {
                [self.view showWarning:error.localizedDescription];
            }else{
                [self.tableView reloadData];
            }
            [self.tableView endHeaderRefresh];
        }];
    }];
    [self.tableView beginHeaderRefresh];
    
    [self.tableView addBackFooterRefresh:^{
        [self.businessVM getBusinessWithCategory:self.category requestMode:RequestModeMore completionHandler:^(NSError *error) {
            if (error) {
                [self.view showWarning:error.localizedDescription];
            }else{
                [self.tableView reloadData];
            }
            [self.tableView endFooterRefresh];
        }];
    }];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 方法
- (void)cityChanged:(NSNotification *)noti{
    self.cityBarItem.title = kCurrentCity;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"MapViewController"]) {
        MapViewController *mapVC = segue.destinationViewController;
        mapVC.category = self.category;
        mapVC.businessVM = self.businessVM;
    }
}


@end
