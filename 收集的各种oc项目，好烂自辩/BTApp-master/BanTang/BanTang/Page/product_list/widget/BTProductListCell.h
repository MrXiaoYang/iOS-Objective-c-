//
//  BTTopicDetailNewCell.h
//  BanTang
//
//  Created by Ryan on 15/12/4.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTProduct,BTProductListCell,BTProductLiker;

@protocol BTProductListCellDelegate <NSObject>
/**
 *  点击了第几张图片
 */
- (void)productListCell:(BTProductListCell *)listCell didClickPicWithIndex:(NSInteger)index;
/**
 *  点击了喜欢的人的头像
 */
- (void)productListCell:(BTProductListCell *)listCell didClickLikerUserIcon:(BTProductLiker *)liker;
/**
 *  点击了评论
 */
- (void)productListCell:(BTProductListCell *)listCell didClickComment:(BTProduct *)product;
/**
 *  点击了喜欢
 */
- (void)productListCell:(BTProductListCell *)listCell didClickLike:(BTProduct *)product;
/**
 *  点击了购买
 */
- (void)productListCell:(BTProductListCell *)listCell didClickBuy:(BTProduct *)product;
/**
 *  点击了购买
 */
- (void)productListCell:(BTProductListCell *)listCell didClickArrowIcon:(BTProduct *)product;

@end



@interface BTProductListCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) BTProduct *product;

/** 头像地址域名 */
@property (nonatomic, copy) NSString *userAvatrHost;

/** 产品图片地址域名 */
@property (nonatomic, copy) NSString *productPicHost;

@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, weak)id <BTProductListCellDelegate> delegate;

@property (nonatomic, assign) BOOL like;

@end
