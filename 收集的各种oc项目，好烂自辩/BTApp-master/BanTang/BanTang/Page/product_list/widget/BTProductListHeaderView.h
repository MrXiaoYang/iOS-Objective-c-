//
//  BTProductListHeaderView.h
//  BanTang
//
//  Created by Ryan on 15/12/2.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTTopicNewInfo;
@interface BTProductListHeaderView : UIView

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) BTTopicNewInfo *info;

@property (nonatomic, assign) CGFloat headerHeight;

- (void)show;

@end
