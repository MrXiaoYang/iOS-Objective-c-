//
//  NHDiscoverHeaderView.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDiscoverHeaderView.h"
#import "NHDiscoverHeaderViewViewCell.h"
#import "NHDiscoverModel.h"
#import "NHDiscoverHeaderPageControl.h"

#define kCellIdentifier @"news"
#define kMaxSections 200
#define kTimeInterval 5.0f
 
@interface NHDiscoverHeaderView() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) NHDiscoverHeaderPageControl *pageControl;
@end

@implementation NHDiscoverHeaderView {
    UIView *_lineView;
}

- (NHDiscoverHeaderPageControl *)pageControl {
    if (_pageControl == nil) {
        NHDiscoverHeaderPageControl *pageControl = [NHDiscoverHeaderPageControl pageControl];
        [self addSubview:pageControl];
         pageControl.frame = CGRectMake(kScreenWidth - 100, self.frame.size.height - 20, 100, 20);
        _pageControl = pageControl;
        pageControl.selectedItemColor = [UIColor redColor];
        pageControl.normalItemColor = kOrangeColor;
    }
    return _pageControl;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //确定是水平滚动，还是垂直滚动
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0) collectionViewLayout:flowLayout];
        
        [self addSubview:collectionView];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.pagingEnabled = YES;
        [collectionView setBackgroundColor:[UIColor clearColor]];
        _collectionView = collectionView;
        
    }
    return _collectionView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    _lineView.frame = CGRectMake(0, self.frame.size.height - 0.5f, self.frame.size.width, 0.5f);
    [self bringSubviewToFront:self.pageControl];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    _lineView = [[UIView alloc] init];
    [self addSubview:_lineView];
    _lineView.backgroundColor = [UIColor colorWithRed:0.91f green:0.91f blue:0.91f alpha:1.00f];
}

/**
 *  设置数据模型数组 配置UI
 */
- (void)setModelArray:(NSArray *)modelArray {
    _modelArray = modelArray;
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:_modelArray];
    [tmp addObjectsFromArray:modelArray];
    _modelArray = tmp.copy;
    
    if (modelArray.count == 0) {
        return ;
    }
    self.pageControl.numberOfItems = _modelArray.count;

    
    // 添加定时器
    [self addTimer];
    
    // 注册cell
    [self.collectionView registerClass:[NHDiscoverHeaderViewViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    
    // 默认显示最中间的那组
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:kMaxSections / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    [self bringSubviewToFront:self.pageControl];
    
    [self.collectionView reloadData];
}

/**
 *  添加定时器
 */
- (void)addTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

/**
 *  移除定时器
 */
- (void)removeTimer {
    // 停止定时器
    [self.timer invalidate];
    self.timer = nil;
}

/**
 *  重置索引值 确保循环复用
 */
- (NSIndexPath *)resetIndexPath {
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:kMaxSections / 2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}

/**
 *  下一页
 */
- (void)nextPage {
    // 1.马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    // 2.计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.modelArray.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 3.通过动画滚动到下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return kMaxSections;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1. 初始化
    NHDiscoverHeaderViewViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    // 2. 设置数据模型和索引
    NHDiscoverRotate_bannerElement *element = self.modelArray[indexPath.row];
    NHDiscoverRotate_bannerElementBanner_url_URL *urlModel =  element.banner_url.url_list.firstObject;
    cell.url = urlModel.url;
    cell.title = element.banner_url.title;
  
    // 3. 返回cell
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

#pragma mark  - UICollectionViewDelegate
/**
 *  当用户即将开始拖拽的时候就调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

/**
 *  当用户停止拖拽的时候就调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.modelArray.count;
    self.pageControl.currentIndex = page;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NHDiscoverHeaderViewViewCell *cell = (NHDiscoverHeaderViewViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NHDiscoverRotate_bannerElement *element = self.modelArray[indexPath.row];
    
    if (self.discoverHeaderViewGoToPageHandle) {
        self.discoverHeaderViewGoToPageHandle(cell, element);
    }
    
}
@end
