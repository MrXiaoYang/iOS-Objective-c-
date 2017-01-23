//
//  NHCustomSegmentView.h
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//  切换视图，类似于系统的UISegmentControl

#import <UIKit/UIKit.h>

@interface NHCustomSegmentView : UIView

- (instancetype)initWithItemTitles:(NSArray *)itemTitles;

/**
 *  从0开始
 */
@property (nonatomic, copy) void(^NHCustomSegmentViewBtnClickHandle)(NHCustomSegmentView *segment, NSString *currentTitle, NSInteger currentIndex);

- (void)clickDefault;

@end
