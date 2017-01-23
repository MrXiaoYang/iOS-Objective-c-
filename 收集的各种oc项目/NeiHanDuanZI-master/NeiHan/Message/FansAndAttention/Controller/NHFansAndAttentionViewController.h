//
//  NHFansAndAttentionViewController.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//  粉丝和关注

#import "NHBaseViewController.h"

typedef NS_ENUM(NSUInteger, NHFansAndAttentionVcType) {
    /** 关注*/
    NHFansAndAttentionViewControllerAttention,
    /** 粉丝*/
    NHFansAndAttentionViewControllerFans,
};

@interface NHFansAndAttentionViewController : NHBaseViewController
/** 构造方法*/
- (instancetype)initWithUserId:(NSInteger)userId vcType:(NHFansAndAttentionVcType)vcType;
@end
