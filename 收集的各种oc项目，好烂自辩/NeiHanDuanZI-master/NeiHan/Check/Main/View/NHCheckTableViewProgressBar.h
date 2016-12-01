//
//  NHCheckTableViewProgressBar.h
//  NeiHan
//
//  Created by Charles on 16/9/6.
//  Copyright © 2016年 Charles. All rights reserved.
//  审核 好笑不好笑loading视图

#import <UIKit/UIKit.h>

typedef void(^NHCheckTableViewProgressBarFinishLoadingHandle)();

@interface NHCheckTableViewProgressBar : UIView

+ (instancetype)bar;

// leftScale + rightScale = 1
@property (nonatomic, assign) CGFloat leftScale;
@property (nonatomic, assign) CGFloat rightScale;

/** 加载loading完毕时候的回调*/
- (void)setUpCheckTableViewProgressBarFinishLoadingHandle:(NHCheckTableViewProgressBarFinishLoadingHandle)finishLoadingHandle;

@end
