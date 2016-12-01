//
//  NHPublishDraftPictureView.m
//  NeiHan
//
//  Created by Charles on 16/9/2.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHPublishDraftPictureView.h"
#import "UIView+Tap.h"
#import "NHPublishDraftPictureCollectionViewCell.h"
#import "UIView+Layer.h"

@interface NHPublishDraftPictureView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *colView;
@end

static NSString *cellID = @"NHPublishDraftPictureViewCellID";
static NSString *addCellID = @"NHPublishDraftPictureViewAddCellID";
@implementation NHPublishDraftPictureView

- (void)setPictureArray:(NSMutableArray <UIImage *>*)pictureArray {
    _pictureArray = pictureArray;
    [self.colView reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.colView.frame = self.bounds;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.pictureArray.count == 0) {
        return 0;
    }
    if (self.pictureArray.count >= 9) {
        return self.pictureArray.count;
    }
    return self.pictureArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WeakSelf(weakSelf);
    if (indexPath.row == self.pictureArray.count) {
        NHPublishDraftPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:addCellID forIndexPath:indexPath];
        cell.hiddenCloseBtn = YES;
        cell.image = [UIImage imageNamed:@"addfile"];
        cell.contentView.layerBorderColor = kCommonGrayTextColor;
        cell.contentView.layerBorderWidth = kLineHeight;
        cell.publishDraftPictureCellAddImgHandle = ^(NHPublishDraftPictureCollectionViewCell *cell) {
            if ([weakSelf.delegate respondsToSelector:@selector(publishDraftPictureViewAddImage:)]) {
                [weakSelf.delegate publishDraftPictureViewAddImage:weakSelf];
            }
        };
        return cell;
    }
    NHPublishDraftPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.image = self.pictureArray[indexPath.row];
    cell.publishDraftPictureCellDeleteImgHandle = ^(NHPublishDraftPictureCollectionViewCell *cell) {
        
        NSIndexPath *indexPath = [collectionView indexPathForCell:cell];
        if (weakSelf.pictureArray.count == 1) {
            [weakSelf.pictureArray removeAllObjects];
            [weakSelf.colView reloadData];
        } else {
            [weakSelf.pictureArray removeObjectAtIndex:indexPath.row];
            [weakSelf.colView deleteItemsAtIndexPaths:@[indexPath]];
        }
        if ([weakSelf.delegate respondsToSelector:@selector(publishDraftPictureView:picArrayDidChange:)]) {
            [weakSelf.delegate publishDraftPictureView:weakSelf picArrayDidChange:weakSelf.pictureArray];
        }
    };
    return cell;
}

- (void)addImages:(NSArray *)images {
    if (images.count) {
        [self.pictureArray addObjectsFromArray:images];
        if ([self.delegate respondsToSelector:@selector(publishDraftPictureView:picArrayDidChange:)]) {
            [self.delegate publishDraftPictureView:self picArrayDidChange:self.pictureArray];
        }
        [self.colView reloadData];
    }
}

- (UICollectionView *)colView {
    if (!_colView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemW = (kScreenWidth - 5 * 4 - 10) / 3.0;
        layout.itemSize = CGSizeMake(itemW, itemW);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        UICollectionView *col = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [self addSubview:col];
        _colView = col;
        col.delegate = self;
        col.dataSource = self;
        col.backgroundColor = [UIColor clearColor];
        [col registerClass:[NHPublishDraftPictureCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        [col registerClass:[NHPublishDraftPictureCollectionViewCell class] forCellWithReuseIdentifier:addCellID];
    }
    return _colView;
}
@end
