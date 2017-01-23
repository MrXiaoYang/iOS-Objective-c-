//
//  NHPublishDraftTopView.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHPublishDraftTopView : UIView
/** 吧名*/
@property (nonatomic, copy) NSString *topicName;
/** 点击回调*/
@property (nonatomic, copy) void(^publishDraftTopViewChangeTopicHandle)();

+ (instancetype)topView;
@end
