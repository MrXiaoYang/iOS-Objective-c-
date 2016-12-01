//
//  NHPublishDraftBottomView.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  item类型
 */
typedef NS_ENUM(NSUInteger, NHPublishDraftBottomViewItemType) {
    /** 图片*/
    NHPublishDraftBottomViewItemTypePicture = 1,
    /** 视频*/
    NHPublishDraftBottomViewItemTypeVideo,
    /** 匿名*/
    NHPublishDraftBottomViewItemTypeAnonymous,
};

@class NHPublishDraftBottomView;
@protocol NHPublishDraftBottomViewDelegate <NSObject>
/** 点击回调*/
- (void)publishDraftBottomView:(NHPublishDraftBottomView *)bottomView didClickItemWithType:(NHPublishDraftBottomViewItemType)type;
@end

@interface NHPublishDraftBottomView : UIView
@property (nonatomic, weak) id <NHPublishDraftBottomViewDelegate> delegate;
/** 剩余可输入字数*/
@property (nonatomic, assign) NSInteger limitCount;

@end
