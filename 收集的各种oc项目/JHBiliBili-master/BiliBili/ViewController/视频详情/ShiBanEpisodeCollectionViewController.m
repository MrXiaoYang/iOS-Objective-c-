//
//  ShiBanEpisodeCollectionViewController.m
//  BiliBili
//
//  Created by apple-jd44 on 15/12/3.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ShiBanEpisodeCollectionViewController.h"

#import "ShinBanInfoModel.h"

#import "ShiBanEpisodeCollectionViewCell.h"
#define EDGE 10

@interface ShiBanEpisodeCollectionViewController ()

@end

@implementation ShiBanEpisodeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[ShiBanEpisodeCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.collectionView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
    }
    return self;
}

#pragma mark <UICollectionViewDataSource>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeEpisode" object:nil userInfo:@{@"episode":self.episodes[indexPath.row].av_id,@"cid":self.episodes[indexPath.row].av_cid,@"title":self.episodes[indexPath.row].index_title}];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.episodes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShiBanEpisodeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = self.episodes[indexPath.row].index;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell的宽度等于(屏宽-2*边距-(列数-1)*item间的间距)/列数
    CGFloat inset = [self collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:0];
    CGFloat width = (kWindowW - 2 * EDGE - (4 - 1) * inset) / 4;
    
    return CGSizeMake(width, width * 0.45);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(EDGE, EDGE, EDGE, EDGE);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return EDGE;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return EDGE;
}

@end
