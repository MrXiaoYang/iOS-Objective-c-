//
//  NHHomeTableViewCell.h
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseTableViewCell.h"

@class NHBaseImageView;

typedef NS_ENUM(NSUInteger, NHHomeTableViewCellItemType) {
    /** 点赞*/
    NHHomeTableViewCellItemTypeLike = 1,
    /** 踩*/
    NHHomeTableViewCellItemTypeDontLike,
    /** 评论*/
    NHHomeTableViewCellItemTypeComment,
    /** 分享*/
    NHHomeTableViewCellItemTypeShare
};

@class NHHomeTableViewCellFrame , NHHomeTableViewCell, NHDiscoverSearchCommonCellFrame, NHNeiHanUserInfoModel;
@protocol NHHomeTableViewCellDelegate <NSObject>

/** 分类*/
- (void)homeTableViewCellDidClickCategory:(NHHomeTableViewCell *)cell;
/** 个人中心*/
- (void)homeTableViewCell:(NHHomeTableViewCell *)cell gotoPersonalCenterWithUserInfo:(NHNeiHanUserInfoModel *)userInfoModel;
/** 点击底部item*/
- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickItemWithType:(NHHomeTableViewCellItemType)itemType;
/** 点击浏览大图*/
- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickImageView:(UIImageView *)imageView currentIndex:(NSInteger)currentIndex urls:(NSArray <NSURL *>*)urls;
/** 播放视频*/
- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickVideoWithVideoUrl:(NSString *)videoUrl videoCover:(NHBaseImageView *)baseImageView;

@optional
/** 点击关注*/
- (void)homeTableViewCellDidClickAttention:(NHHomeTableViewCell *)cell;
/** 删除*/
- (void)homeTableViewCellDidClickClose:(NHHomeTableViewCell *)cell;
@end
@interface NHHomeTableViewCell : NHBaseTableViewCell

/** 代理*/
@property (nonatomic, weak) id <NHHomeTableViewCellDelegate> delegate;
/** 首页cellFrame模型*/
@property (nonatomic, strong) NHHomeTableViewCellFrame *cellFrame;
/** 搜索cellFrame模型*/
@property (nonatomic, strong) NHDiscoverSearchCommonCellFrame *searchCellFrame;
/** 用来判断是否有删除按钮*/
@property (nonatomic, assign) BOOL isFromHomeController;

/** 判断是否在详情页*/
- (void)setCellFrame:(NHHomeTableViewCellFrame *)cellFrame isDetail:(BOOL)isDetail;
/** 设置关键字*/
- (void)setSearchCellFrame:(NHDiscoverSearchCommonCellFrame *)searchCellFrame keyWord:(NSString *)keyWord;
/** 点赞*/
- (void)didDigg;
/** 踩*/
- (void)didBury;

@end
