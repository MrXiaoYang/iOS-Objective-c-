//
//  PlayerUIView.h
//  te
//
//  Created by apple-jd44 on 15/11/27.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerUIView;
@protocol PlayerUIViewDelegate<NSObject>
@optional
- (void)playerTouchBackArrow:(PlayerUIView*)UIView;
- (void)playerTouchDanMuButton:(PlayerUIView*)UIView;
- (void)playerTouchPlayerButton:(PlayerUIView*)UIView;
- (void)playerTouchSlider:(PlayerUIView*)UIView slideValue:(CGFloat)value;
@end

typedef void(^handle)();
@interface PlayerUIView : UIView
//淡出时间
@property (nonatomic, assign) CGFloat fadeTime;
@property (nonatomic, weak) id<PlayerUIViewDelegate> delegate;
@property (nonatomic, strong) handle returnBlock;
- (instancetype)initWithTitle:(NSString*)title videoTime:(NSInteger)videoTime;
- (void)setWithTitle:(NSString*)title videoTime:(NSInteger)videoTime;
- (void)showPlayer;
- (void)hiddenPlayer;
/**
 *  用于更新参数
 *
 */
- (void)updateValue:(handle) block;
/**
 *  更新时间
 *  @param time 传递秒数
 */
- (void)updateCurrentTime:(CGFloat)currentTime bufferTime:(CGFloat)bufferTime allTime:(NSInteger)allTime;
@end
