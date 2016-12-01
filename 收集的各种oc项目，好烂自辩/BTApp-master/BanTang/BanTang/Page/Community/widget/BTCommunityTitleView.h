//
//  BTCommunityTitleView.h
//  BanTang
//
//  Created by Ryan on 15/12/7.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommunityTitleViewDidClickBlock)(NSInteger);

@interface BTCommunityTitleView : UIView

+ (instancetype)titleView;

@property (nonatomic, copy) CommunityTitleViewDidClickBlock didClickBlock;

@end
