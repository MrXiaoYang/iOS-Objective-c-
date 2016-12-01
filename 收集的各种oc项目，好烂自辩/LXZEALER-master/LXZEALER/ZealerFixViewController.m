//
//  ZealerFixViewController.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/2.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "ZealerFixViewController.h"
#import "ZealerFixCollectionViewCell.h"
#import "ZealerFixDetailViewController.h"

#define SCREEN_WIDTH self.view.bounds.size.width

@interface ZealerFixViewController ()

@end

@implementation ZealerFixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self initZealerFixImageView];
}

- (UICollectionView*)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 8;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(120, 140);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(8, 8, SCREEN_WIDTH - 16, 140) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor colorWithRed:0.882 green:0.898 blue:0.918 alpha:1.000];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"ZealerFixCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (void)initZealerFixImageView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 156, SCREEN_WIDTH - 16, 130)];
    imageView.image = [UIImage imageNamed:@"fix"];
    [self.view addSubview:imageView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    tapGesture.numberOfTapsRequired = 1;
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tapGesture];
}

#pragma mark - Go To ZealerFix Website
- (void)tapGestureAction{
    ZealerFixDetailViewController *detail = [[ZealerFixDetailViewController alloc] init];
    detail.index = 7;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 7;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    ZealerFixCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setImageForCellWithIndexpath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPat{
    ZealerFixDetailViewController *detail = [[ZealerFixDetailViewController alloc] init];
    detail.index = indexPat.row;
    [self.navigationController pushViewController:detail animated:YES];
}


@end
