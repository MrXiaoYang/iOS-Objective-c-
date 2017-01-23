//
//  NHCommonAPIConstant.h
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//  接口常量

#import <Foundation/Foundation.h>

@interface NHCommonAPIConstant : NSObject

#pragma mark - HOME / 首页
/** 内涵动态列表*/
UIKIT_EXTERN NSString *const kNHHomeServiceListAPI;
/** 内涵当前用户关注的用户发布的动态列表*/
UIKIT_EXTERN NSString *const kNHHomeAttentionDynamicListAPI;
/** 内涵某个动态评论列表*/
UIKIT_EXTERN NSString *const kNHHomeDynamicCommentListAPI;
/** 内涵某个分类的动态列表*/
UIKIT_EXTERN NSString *const kNHHomeCategoryDynamicListAPI;
/** 内涵举报动态*/
UIKIT_EXTERN NSString *const kNHHomeReportDynamicAPI;
/** 内涵点赞动态*/
UIKIT_EXTERN NSString *const kNHHomeDynamicLikeAPI;

#pragma mark - DISCOVER / 发现
/** 内涵热吧列表和轮播图*/
UIKIT_EXTERN NSString *const kNHDiscoverHotListAPI;
/** 内涵当前用户订阅的热吧列表*/
UIKIT_EXTERN NSString *const kNHDiscoverSubscribeListAPI;
/** 内涵搜索用户列表*/
UIKIT_EXTERN NSString *const kNHDiscoverSearchUserListAPI;
/** 内涵搜索热吧列表*/
UIKIT_EXTERN NSString *const kNHDiscoverSearchHotDraftListAPI;
/** 内涵搜索动态列表*/
UIKIT_EXTERN NSString *const kNHDiscoverSearchDynamicListAPI;
/** 内涵附近的用户列表*/
UIKIT_EXTERN NSString *const kNHDiscoverNearByUserListAPI;
/** 内涵推荐的用户列表*/
UIKIT_EXTERN NSString *const kNHDiscoverRecommendUserListAPI;

#pragma mark - PUBLISH / 发布
/** 内涵用户发布动态可选择的热吧列表*/
UIKIT_EXTERN NSString *const kNHUserPublishSelectDraftListAPI;
/** 内涵用户发布动态*/
UIKIT_EXTERN NSString *const kNHUserPublishDraftAPI;

#pragma mark - USER / 用户
/** 内涵用户个人信息*/
UIKIT_EXTERN NSString *const kNHUserProfileInfoAPI;
/** 内涵用户的关注用户列表*/
UIKIT_EXTERN NSString *const kNHUserFansListAPI;
/** 内涵用户的粉丝列表*/
UIKIT_EXTERN NSString *const kNHUserAttentionListAPI;
/** 内涵用户的投稿列表*/
UIKIT_EXTERN NSString *const kNHUserPublishDraftListAPI;
/** 内涵用户的收藏列表*/
UIKIT_EXTERN NSString *const kNHUserColDynamicListAPI;
/** 内涵用户的评论列表*/
UIKIT_EXTERN NSString *const kNHUserDynamicCommentListAPI;
/** 内涵用户的黑名单列表*/
UIKIT_EXTERN NSString *const kNHUserBlackUserListAPI;
/** 内涵用户的积分*/
UIKIT_EXTERN NSString *const kNHUserPointAPI;


#pragma mark - CHECK / 审核
/** 内涵审核的动态列表*/
UIKIT_EXTERN NSString *const kNHCheckDynamicListAPI;

@end
