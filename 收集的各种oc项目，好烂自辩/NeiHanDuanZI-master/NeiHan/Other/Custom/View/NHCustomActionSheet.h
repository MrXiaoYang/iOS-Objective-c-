//
//  NHCustomActionSheet.h
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//  自定义ActionSheet，类似于系统的UIActionSheet

#import <UIKit/UIKit.h>

@class NHCustomActionSheet;
typedef void(^NHCustomActionSheetItemClickHandle)(NHCustomActionSheet *actionSheet, NSInteger currentIndex, NSString *title);

@interface NHCustomActionSheet : UIView

/**
 *  初始化
 *
 *  @param cancelTitle 取消
 *  @param alertTitle  提示文字
 *  @param title       子控件文本
 */
+ (instancetype)actionSheetWithCancelTitle:(NSString *)cancelTitle alertTitle:(NSString *)alertTitle SubTitles:(NSString *)title,...NS_REQUIRES_NIL_TERMINATION;

- (void)setCustomActionSheetItemClickHandle:(NHCustomActionSheetItemClickHandle)itemClickHandle;

- (void)setActionSheetDismissItemClickHandle:(NHCustomActionSheetItemClickHandle)dismissItemClickHandle;

- (void)show;

@end
