//
//  NHCheckReportBottomView.h
//  NeiHan
//
//  Created by Charles on 16/9/5.
//  Copyright © 2016年 Charles. All rights reserved.
//  审核 举报视图

#import <UIKit/UIKit.h>

@interface NHCheckReportBottomView : UIView

- (void)showInView:(UIView *)view;

- (void)dismiss;

@property (nonatomic, copy) void(^checkReportBottomViewDidClickReportReasonHandle)(NHCheckReportBottomView *view, NSString *reportStr, NSInteger index);
@end
