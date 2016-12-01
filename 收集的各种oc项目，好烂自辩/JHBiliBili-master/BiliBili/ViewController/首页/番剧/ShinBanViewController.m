//
//  ShinBanViewController.m
//  BiliBili
//
//  Created by apple-jd44 on 15/10/28.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ShinBanViewController.h"
#import "ShiBanPlayTableViewController.h"
#import "ShiBanInfoViewController.h"

#import "ShiBanTitleCollectionViewCell.h"
#import "ShiBanRecommentCollectionViewCell.h"
#import "ShiBanIndexCollectionViewCell.h"

#import "ShinBanViewModel.h"

#define kColNum 3
#define kEdge 10

@interface ShinBanViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) ShinBanViewModel* vm;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UIButton *everyDayPlay;
@property (strong, nonatomic) UIButton *shinBanIndex;
@end

@implementation ShinBanViewController
#pragma mark - 方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.collectionView];
    [self.collectionView.mj_header beginRefreshing];
}

- (void)colorSetting{
    self.collectionView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell的宽度等于(屏宽-2*边距-(列数-1)*item间的间距)/列数
    if (indexPath.section == 0) {
        return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.width / 4);
    }else if(indexPath.section == 1){
        return CGSizeMake(self.collectionView.frame.size.width, 25);
    }else{
        CGFloat inset = [self collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex: 2];
        CGFloat width = (kWindowW - 2 * kEdge - (kColNum - 1) * inset) / kColNum;
        
        return CGSizeMake(width, width / 0.7 + 30);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return section == 2?UIEdgeInsetsMake(kEdge, kEdge, kEdge, kEdge):UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return section == 2?5:0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return section == 2?10:0;
}


#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 2?self.vm.recommentList.count:1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //0 新番索引 1 分区头 2内容
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"ShiBanIndexCollectionViewCell" forIndexPath:indexPath];
    }else if(indexPath.section == 1){
        ShiBanTitleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShiBanTitleCollectionViewCell" forIndexPath: indexPath];
        [cell setUpProperty];
        return cell;
    }else{
        ShiBanRecommentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"ShiBanRecommentCollectionViewCell" forIndexPath: indexPath];
        [cell.imgView setImageWithURL: [self.vm commendCoverForRow: indexPath.row]];
        cell.Label.text = [self.vm commendTitileForRow: indexPath.row];
        [cell setUpProperty];
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        ShiBanInfoViewController* avc = [[ShiBanInfoViewController alloc] init];
        [avc setWithModel:self.vm.recommentList[indexPath.row]];
        [self.navigationController pushViewController:avc animated:YES];
    }
}

#pragma mark - 懒加载
- (ShinBanViewModel *)vm{
    if (_vm == nil) {
        _vm = [ShinBanViewModel new];
    }
    return _vm;
}

- (UICollectionView *)collectionView {
	if(_collectionView == nil) {
		_collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout: [[UICollectionViewFlowLayout alloc] init]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[ShiBanTitleCollectionViewCell class] forCellWithReuseIdentifier: @"ShiBanTitleCollectionViewCell"];
        [_collectionView registerClass:[ShiBanRecommentCollectionViewCell class] forCellWithReuseIdentifier: @"ShiBanRecommentCollectionViewCell"];
        [_collectionView registerClass:[ShiBanIndexCollectionViewCell class] forCellWithReuseIdentifier: @"ShiBanIndexCollectionViewCell"];
        
        _collectionView.mj_header = [MyRefreshComplete myRefreshHead:^{
            [self.vm refreshDataCompleteHandle:^(NSError *error) {
                [_collectionView.mj_header endRefreshing];
                [_collectionView reloadData];
            }];
        }];
        _collectionView.mj_footer = [MyRefreshComplete myRefreshFoot:^{
            [self.vm getMoreDataCompleteHandle:^(NSError *error) {
                [_collectionView.mj_footer endRefreshing];
                [_collectionView reloadData];
            }];
        }];
	}
	return _collectionView;
}

@end
