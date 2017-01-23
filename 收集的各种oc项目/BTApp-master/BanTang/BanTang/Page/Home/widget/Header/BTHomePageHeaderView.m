//
//  BTHomePageHeaderView.m
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTHomePageHeaderView.h"
#import "BTEntryListCell.h"
#import "BTHomeBanner.h"
#import "BTNoHLbutton.h"
#import <SDCycleScrollView.h>

static NSString *const reuseID = @"enrtyListCell";

@interface BTHomePageHeaderView() < UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *diverLine;

@property (nonatomic, strong) UIView *leftButtonView;

@property (nonatomic, strong) UIView *rightButtonView;

@end

@implementation BTHomePageHeaderView

- (instancetype)initWithBannerImagesArray:(NSArray *)imagesArray
                           entryListArray:(NSArray *)entryListArray
{
    if (imagesArray){
        NSMutableArray *array = [NSMutableArray array];
        for (BTHomeBanner *banner in imagesArray) {
            [array addObject:banner.photo];
        }
        self.imagesArray = [array copy];
    }
    
    if (entryListArray) self.entryListArray = entryListArray;
    
    if (self = [super init])
    {
        [self addSubview:self.cycleScrollView];
        [self addSubview:self.collectionView];
        [self addSubview:self.diverLine];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.entryListArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BTEntryListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID
                                                                      forIndexPath:indexPath];
    cell.entryList = self.entryListArray[indexPath.item];
    
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(headerView:didClickEntryListWithIndex:)]) {
        [self.delegate headerView:self didClickEntryListWithIndex:indexPath.item];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(98, 98);
}

#pragma SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(headerView:didClickBannerViewWithIndex:)]) {
        [self.delegate headerView:self didClickBannerViewWithIndex:index];
    }
}
#pragma mark - event Responder
- (void)leftButtonDidClick
{
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickRightButton:)]) {
        [self.delegate headerViewDidClickLeftButton:self];
    }
}

- (void)rightButtonDidClick
{
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickRightButton:)]) {
        [self.delegate headerViewDidClickRightButton:self];
    }
}
#pragma mark - Setter
// 设置轮播图图片数组
- (void)setImagesArray:(NSArray *)imagesArray
{
    _imagesArray = imagesArray;
    NSMutableArray *muArray = [NSMutableArray array];
    for (BTHomeBanner *banner in imagesArray) {
        [muArray addObject:banner.photo];
    }
    self.cycleScrollView.imageURLStringsGroup = [muArray mutableCopy];
}
// 设置collectionView的数据源
- (void)setEntryListArray:(NSArray *)entryListArray
{
    _entryListArray = entryListArray;
    [self.collectionView reloadData];
}
#pragma mark - Getter
- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_Width, 180) imageURLStringsGroup:@[]];
        _cycleScrollView.delegate = self;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    }
    return _cycleScrollView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGRect frame =   CGRectMake(0,
                                    CGRectGetMaxY(self.cycleScrollView.frame),
                                    CGRectGetWidth(self.cycleScrollView.frame),
                                    128);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.contentInset = UIEdgeInsetsMake(15, 15, 15, 15);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[BTEntryListCell class] forCellWithReuseIdentifier:reuseID];
    }
    return _collectionView;
}

- (UIView *)diverLine
{
    if (!_diverLine) {
        _diverLine = [UIView new];
        _diverLine.backgroundColor    = kUIColorFromRGB(0xeeeeee);
        _diverLine.layer.shadowColor  = kUIColorFromRGB(0xeeeeee).CGColor;
        _diverLine.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    }
    return _diverLine;
}

- (UIView *)leftButtonView
{
    if (!_leftButtonView) {
        _leftButtonView = [UIView new];
        _leftButtonView.backgroundColor = kUIColorFromRGB(0x565937);
        _leftButtonView.alpha = 0.8;
        _leftButtonView.layer.cornerRadius = 17;
        _leftButtonView.layer.masksToBounds = YES;
        _leftButtonView.frame = CGRectMake(10, 25, 34, 34);
        
        BTNoHLbutton *leftButton = [[BTNoHLbutton alloc] init];
        [leftButton addTarget:self action:@selector(leftButtonDidClick)
              forControlEvents:UIControlEventTouchUpInside];
        [leftButton setImage:[UIImage imageNamed:@"home_search_icon"]
                    forState:UIControlStateNormal];
        leftButton.center = _leftButtonView.center;
        CGFloat x = (34 - 20) * 0.5;
        CGFloat y = (34 - 20) * 0.5;
        leftButton.frame = CGRectMake(x, y, 20, 20);
        [_leftButtonView addSubview:leftButton];
    }
    return _leftButtonView;
}

- (UIView *)rightButtonView
{
    if (!_rightButtonView) {
        _rightButtonView = [UIView new];
        _rightButtonView.backgroundColor = kUIColorFromRGB(0x565937);
        _rightButtonView.alpha = 0.8;
        CGFloat x = kScreen_Width - 10 - 34;
        _rightButtonView.layer.cornerRadius = 17;
        _rightButtonView.layer.masksToBounds = YES;
        _rightButtonView.frame = CGRectMake(x, 25, 34, 34);
        
        BTNoHLbutton *rightButton = [[BTNoHLbutton alloc] init];
        [rightButton addTarget:self action:@selector(rightButtonDidClick)
             forControlEvents:UIControlEventTouchUpInside];
        [rightButton setImage:[UIImage imageNamed:@"sign_bar_icon"]
                     forState:UIControlStateNormal];
        rightButton.center = _rightButtonView.center;
        CGFloat btnX = (34 - 20) * 0.5;
        CGFloat btnY = (34 - 20) * 0.5;
        rightButton.frame = CGRectMake(btnX, btnY, 20, 20);
        [_rightButtonView addSubview:rightButton];
    }
    return _rightButtonView;
}

- (void)layoutSubviews
{
    self.diverLine.frame = CGRectMake(0, self.height - 1, self.width, 1);
}
@end
