//
//  ThirdLoginView.h
//  BaseProject
//
//  Created by yingxin on 15/12/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ThirdLoginView;


typedef NS_ENUM(NSUInteger, LoginType) {
    LoginTypeWeChat,
    LoginTypeWeiBo,
    LoginTypeRenRen,
};


@protocol ThirdLoginViewDelegate <NSObject>

/** 点击的登陆按钮类型 */
- (void)thirdLoginView:(ThirdLoginView *)thirdLoginView selectLoginType:(LoginType)type;

@end

@interface ThirdLoginView : UIView

+ (ThirdLoginView *)thirdLoginViewWithDelegate:(id<ThirdLoginViewDelegate>)delegate;

@property(nonatomic, weak) id<ThirdLoginViewDelegate> delegate;

@end
