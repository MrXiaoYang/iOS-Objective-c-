//
//  JHViewController.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/11.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JHViewControllerDelegate <NSObject>
@optional
- (void)JHViewGetOffset:(CGPoint)offset;
@end


@interface JHViewController : BaseViewController <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, weak) id<JHViewControllerDelegate> delegate;

- (instancetype)initWithControllers:(NSArray*)controllers;
- (NSInteger)currentPage;
- (void)setScrollViewPage:(NSInteger)page;
@end
