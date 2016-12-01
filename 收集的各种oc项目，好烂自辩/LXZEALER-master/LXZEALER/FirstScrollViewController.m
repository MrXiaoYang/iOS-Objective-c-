//
//  FirstScrollViewController.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/1.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "FirstScrollViewController.h"
#import "HJCarouselViewLayout.h"
#import "FirstCollectionViewCell.h"
#import "ZealerVideoWebViewController.h"

#define SCREEN_WIDTH self.view.bounds.size.width

@implementation FirstScrollViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initDateLabel];
    [self.view addSubview:self.collectionView];
    [self initCycleScrollView];
}

/*
 初始化主页上第一个照片轮播器,pageControl,显示日期的label
 */
- (void)initCycleScrollView{
  
    NSMutableArray *imageArray = [NSMutableArray array];
    
    for ( int i = 1 ; i <= 4; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"first%d.jpg",i]];
        [imageArray addObject:image];
    }

    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170) imagesGroup:imageArray];
    
    cycleScrollView.autoScrollTimeInterval = 2.0;
    cycleScrollView.delegate = self;
    cycleScrollView.dotColor = [UIColor colorWithWhite:0.906 alpha:1.000];
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    [self.view addSubview:cycleScrollView];

}
/**
 *  初始化日期label
 */
- (void)initDateLabel{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 175, SCREEN_WIDTH, 20)];
    titleLabel.text = @"一 十月31日更新 一";
    titleLabel.font = [UIFont systemFontOfSize:14.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 140)];
    view1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view1];
}

/*
 初始化主页第二个内容轮播效果,用UICollectionView实现,用HJCarouselViewLayout 进行布局
 */
- (UICollectionView*)collectionView{
    if (!_collectionView) {
        HJCarouselViewLayout *layout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimLinear];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(250, 130);
        layout.visibleCount = 3;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 195, SCREEN_WIDTH, 145) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"FirstCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell setImageForCellWithIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZealerVideoWebViewController *zealerVideoVC = [[ZealerVideoWebViewController alloc] init];
    zealerVideoVC.index = indexPath.row;
    zealerVideoVC.type = ScrollViewCollectionRequest;
    [self.navigationController pushViewController:zealerVideoVC animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    ZealerVideoWebViewController *zealerVideoVC = [[ZealerVideoWebViewController alloc] init];
    zealerVideoVC.index = index;
    zealerVideoVC.type = ScrollViewFirstRequest;
    [self.navigationController pushViewController:zealerVideoVC animated:YES];
}

@end
