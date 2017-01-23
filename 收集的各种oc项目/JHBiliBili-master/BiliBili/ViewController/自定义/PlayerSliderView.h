//
//  PlayerSlideView.h
//  te
//
//  Created by apple-jd44 on 15/11/28.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlayerSliderView;

@protocol PlayerSliderViewDelegate<NSObject>
@optional
- (void)playerSliderTouchEnd:(CGFloat)endValue playerSliderView:(PlayerSliderView*)PlayerSliderView;
@end

@interface PlayerSliderView : UIView
@property (nonatomic, weak) id<PlayerSliderViewDelegate> delegate;

- (instancetype)initWithLineWidth:(CGFloat)lineWidth currentTimeColor:(UIColor*)currentTimeColor bufferTimeColor:(UIColor*)bufferTimeColor lineBackGroundColor:(UIColor*)lineBackGroundColor thumbImg:(UIImage*)thumbImg;
- (void)updateCurrentTime:(CGFloat)currentTime;
- (void)updateBufferTime:(CGFloat)bufferTime;
@end
