//
//  BTProductListCell.m
//  BanTang
//
//  Created by Ryan on 15/12/4.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTProductListCell.h"
#import "BTProduct.h"
#import <Masonry.h>
#import "BTProductListCellTopView.h"
#import "BTProductListCellMiddleView.h"
#import "BTProductListCellBottomView.h"

@interface BTProductListCell() <BTProductListCellBottomViewDelegate>

@property (nonatomic, strong) BTProductListCellTopView *topView;

@property (nonatomic, strong) BTProductListCellMiddleView *middleView;

@property (nonatomic, strong) BTProductListCellBottomView *bottomView;

@end

@implementation BTProductListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *reuseId = @"productListCell";
    BTProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[BTProductListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.topView];
        [self.contentView addSubview:self.middleView];
        [self.contentView addSubview:self.bottomView];
    }
    return self;
}

- (void)setProduct:(BTProduct *)product
{
    _product = product;
    
    [self setupTopViewData];
    
    [self setupMiddleViewData];
    
    [self setupBottomViewData];
}

- (void)setupTopViewData
{
    self.topView.tag = self.tag;
    self.topView.product = self.product;
}

- (void)setupMiddleViewData
{
    self.middleView.productPicHost = self.productPicHost;
    self.middleView.product = self.product;
}

- (void)setupBottomViewData
{
    self.bottomView.userAvatrHost = self.userAvatrHost;
    self.bottomView.product = self.product;
}

#pragma mark - BTProductListCellBottomViewDelegate
- (void)bottomView:(BTProductListCellBottomView *)bottomView didClickBuy:(BTProduct *)product
{
    if ([self.delegate respondsToSelector:@selector(productListCell:didClickBuy:)]) {
        [self.delegate productListCell:self didClickBuy:product];
    }
}

- (void)bottomView:(BTProductListCellBottomView *)bottomView didClickComment:(BTProduct *)product
{
    if ([self.delegate respondsToSelector:@selector(productListCell:didClickComment:)]) {
        [self.delegate productListCell:self didClickComment:product];
    }
}

- (void)bottomView:(BTProductListCellBottomView *)bottomView didClickLike:(BTProduct *)product
{
    if ([self.delegate respondsToSelector:@selector(productListCell:didClickLike:)]) {
        [self.delegate productListCell:self didClickLike:product];
    }
}

- (void)bottomView:(BTProductListCellBottomView *)bottomView didClickLikerUserIcon:(BTProductLiker *)liker
{
    if ([self.delegate respondsToSelector:@selector(productListCell:didClickLikerUserIcon:)]) {
        [self.delegate productListCell:self didClickLikerUserIcon:liker];
    }
}

- (void)bottomView:(BTProductListCellBottomView *)bottomView didClickArrowIcon:(BTProduct *)product
{
    if ([self.delegate respondsToSelector:@selector(productListCell:didClickArrowIcon:)]) {
        [self.delegate productListCell:self didClickArrowIcon:product];
    }
}

- (BTProductListCellTopView *)topView
{
    if (!_topView) {
        BTProductListCellTopView *topView = [BTProductListCellTopView topView];
        [self.contentView addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self.contentView);
        }];
        _topView = topView;
    }
    return _topView;
}

- (BTProductListCellMiddleView *)middleView
{
    if (!_middleView) {
        BTProductListCellMiddleView *middleView = [BTProductListCellMiddleView middleView];
        [self.contentView addSubview:middleView];
        [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.topView.mas_bottom).offset(15);
        }];
        _middleView = middleView;
    }
    return _middleView;
}

- (BTProductListCellBottomView *)bottomView
{
    if (!_bottomView) {
       BTProductListCellBottomView *bottomView = [BTProductListCellBottomView bottomView];
       bottomView.delegate =self;
       [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.middleView.mas_bottom).offset(10);
            make.left.right.bottom.mas_equalTo(self.contentView);
        }];
       _bottomView = bottomView;
    }
    return _bottomView;
}

- (void)setLike:(BOOL)like
{
    _like = like;
    
    self.product.islike = like;
    
    NSInteger newCount = [self.product.likes integerValue];
    newCount = like ? newCount + 1 : newCount - 1;
    if (newCount <0) newCount = 0;
    if (like && newCount < 1)  newCount = 1;
    // 更新数据源
    self.product.likes = [NSString stringWithFormat:@"%zd",newCount];
    // 更新UI
    self.bottomView.likesCount = [NSString stringWithFormat:@"%zd",newCount];
    [self.bottomView setLike:like];
}
@end
