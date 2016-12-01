//
//  BTProductListCellBottomView.h
//  BanTang
//
//  Created by Ryan on 15/12/4.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BTProduct,BTProductListCellBottomView,BTProductLiker;

@protocol BTProductListCellBottomViewDelegate <NSObject>
/**
 *  点击了喜欢的人的头像
 */
- (void)bottomView:(BTProductListCellBottomView *)bottomView didClickLikerUserIcon:(BTProductLiker *)liker;
/**
 *  点击了箭头
 */
- (void)bottomView:(BTProductListCellBottomView *)bottomView didClickArrowIcon:(BTProduct *)product;
/**
 *  点击了评论
 */
- (void)bottomView:(BTProductListCellBottomView *)bottomView didClickComment:(BTProduct *)product;
/**
 *  点击了喜欢
 */
- (void)bottomView:(BTProductListCellBottomView *)bottomView didClickLike:(BTProduct *)product;
/**
 *  点击了购买
 */
- (void)bottomView:(BTProductListCellBottomView *)bottomView didClickBuy:(BTProduct *)product;

@end

@interface BTProductListCellBottomView : UIView

+ (instancetype)bottomView;

@property (nonatomic, copy) NSString *userAvatrHost;

@property (nonatomic, strong) BTProduct *product;

@property (nonatomic, weak)id <BTProductListCellBottomViewDelegate> delegate;

@property (nonatomic, assign,getter=isLike) BOOL like;

@property (nonatomic, copy) NSString *likesCount;

@end
