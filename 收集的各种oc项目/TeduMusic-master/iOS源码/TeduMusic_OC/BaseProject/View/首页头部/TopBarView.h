//
//  TopBarView.h
//  BaseProject
//
//  Created by jiyingxin on 15/12/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopBarView;

/** 按钮类型 */
typedef NS_ENUM(NSUInteger, TopBarViewBtnType) {
    TopBarViewBtnTypeHeader,        //头像
    TopBarViewBtnTypeMy,            //我的
    TopBarViewBtnTypeDiscover,      //发现
    TopBarViewBtnTypeMusicHouse,    //乐馆
    TopBarViewBtnTypeSearch,        //搜索
};


@protocol TopBarViewDelegate <NSObject>

- (void)topBarView:(TopBarView *)topBarView clicksBtnWithType:(TopBarViewBtnType)btnType;

@end


@interface TopBarView : UIView
{
    UIButton *_currentBtn;
}

@property(nonatomic,weak) id<TopBarViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *myBtn;

+ (TopBarView *)defaultTopBarView;
- (id)initWithDelegate:(id<TopBarViewDelegate>)delegate;
@end
