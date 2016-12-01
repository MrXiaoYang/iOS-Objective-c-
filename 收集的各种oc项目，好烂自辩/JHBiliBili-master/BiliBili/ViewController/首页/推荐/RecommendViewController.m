//
//  RecommendViewController.m
//  BiliBili
//
//  Created by apple-jd44 on 15/10/22.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "RecommendViewController.h"
#import "AVInfoViewController.h"
#import "WebViewController.h"

#import "RecommendTitleViewCell.h"
#import "RecommendContentCollectionViewCell.h"

#import "RecommentCollectionViewFlowLayout.h"

#import "RecommendViewModel.h"

#import "iCarousel.h"

@interface RecommendViewController ()<iCarouselDelegate, iCarouselDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) RecommendViewModel* vm;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) iCarousel* headScrollView;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation RecommendViewController

#pragma mark - 方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.collectionView];
    self.collectionView.mj_header = [MyRefreshComplete myRefreshHead:^{
        [self.vm refreshDataCompleteHandle:^(NSError *error) {
            [self.collectionView.mj_header endRefreshing];
            [self.headScrollView reloadData];
            [self.collectionView reloadData];
            if (error) [MBProgressHUD showMsg:kerrorMessage WithView:self.view];
        }];
    }];
    
    [self.collectionView.mj_header beginRefreshing];
}

- (void)colorSetting{
    self.collectionView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
    [self.collectionView reloadData];
}

- (void)timerStart{
    [self.headScrollView scrollToItemAtIndex:self.headScrollView.currentItemIndex + 1 animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.vm sectionCount];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* dic = self.vm.dicMap[indexPath.section];
    NSString* key = [dic allKeys].firstObject;
    if (indexPath.row == 0) {
        RecommendTitleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"RecommendTitleViewCell" forIndexPath:indexPath];
        [cell setTitle:key titleImg:[NSString stringWithFormat:@"home_region_icon_%@",[dic[key] componentsSeparatedByString:@"-"].firstObject]];
        return cell;
    }else{
        RecommendContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"RecommendContentCollectionViewCell" forIndexPath:indexPath];
        //-1因为第一个cell是分区头
        cell.titleLabel.text = [self.vm titleForRow:indexPath.row - 1 section:dic[key]];
        [cell.imgv setImageWithURL: [self.vm picForRow:indexPath.row - 1 section:dic[key]]];
        cell.playLabel.text = [self.vm playForRow:indexPath.row - 1 section:dic[key]];
        cell.danMuLabel.text = [self.vm danMuCountForRow:indexPath.row - 1 section:dic[key]];
        [cell setUpProperty];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dic = self.vm.dicMap[indexPath.section];
    NSString* key = [dic allValues].firstObject;
    AVInfoViewController* vc = [[AVInfoViewController alloc] init];
    [vc setWithModel:[self.vm AVDataModelForRow: indexPath.row - 1 section:key] section: key];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - icarouse

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return [self.vm numberOfHeadImg];
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIImageView *)view{
    if (view == nil) {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW / 2)];
    }
    [view setImageWithURL:[self.vm headImgURL:index]];
    return view;
}
//滚动视图跳转
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    WebViewController* wbc = [[WebViewController alloc] init];
    wbc.URL = [self.vm headImgLink:index];
    [self.navigationController pushViewController:wbc animated:YES];
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    return value;
}

#pragma mark - 懒加载

- (RecommendViewModel *)vm{
    if (_vm == nil) {
        _vm = [[RecommendViewModel alloc] init];
    }
    return _vm;
}

- (iCarousel *)headScrollView{
    if (_headScrollView == nil) {
        _headScrollView = [[iCarousel alloc] initWithFrame: CGRectMake(0, -self.collectionView.frame.size.width / 2, self.collectionView.frame.size.width, self.collectionView.frame.size.width / 2)];
        _headScrollView.delegate = self;
        _headScrollView.dataSource = self;
        _headScrollView.type = iCarouselTypeInvertedCylinder;
        _headScrollView.pagingEnabled = YES;
        //手动滚动速度
        _headScrollView.scrollSpeed = 2;
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return _headScrollView;
}


- (UICollectionView *)collectionView {
	if(_collectionView == nil) {

		_collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:[[RecommentCollectionViewFlowLayout alloc] init]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(self.collectionView.frame.size.width / 2, 0, 0, 0);
        [_collectionView registerClass:[RecommendTitleViewCell class] forCellWithReuseIdentifier: @"RecommendTitleViewCell"];
        [_collectionView registerClass:[RecommendContentCollectionViewCell class] forCellWithReuseIdentifier: @"RecommendContentCollectionViewCell"];
        [_collectionView addSubview: self.headScrollView];
	}
	return _collectionView;
}

- (NSTimer *)timer {
	if(_timer == nil) {
		_timer = [NSTimer timerWithTimeInterval:8 target:self selector:@selector(timerStart) userInfo:nil repeats:YES];
	}
	return _timer;
}

@end
