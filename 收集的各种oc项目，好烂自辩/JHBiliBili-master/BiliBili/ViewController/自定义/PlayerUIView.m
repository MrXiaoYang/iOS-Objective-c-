//
//  PlayerUIView.m
//  te
//
//  Created by apple-jd44 on 15/11/27.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "PlayerUIView.h"
#import "PlayerSliderView.h"

@interface PlayerUIView ()<PlayerSliderViewDelegate>
@property (nonatomic, strong) UIView* headView;
@property (nonatomic, strong) UIView* bottomView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* timeLabel;
@property (nonatomic, strong) PlayerSliderView* slideView;
@property (nonatomic, strong) UIButton* playButton;
@property (nonatomic, strong) UIButton* danMuButton;
@property (nonatomic, strong) NSDateFormatter* formatter;
@property (nonatomic, assign) NSInteger allTime;
@property (nonatomic, strong) NSString* allFormatterTime;
@property (nonatomic, strong) NSTimer* timer;
@end

@implementation PlayerUIView

- (instancetype)initWithTitle:(NSString*)title videoTime:(NSInteger)videoTime{
    if (self = [super init]) {
        self.titleLabel.text = title;
        self.fadeTime = 0.5;
        //初始化title
        [self addSubview: self.headView];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(self.mas_height).multipliedBy(0.1);
        }];
        //初始化时间面板
        [self addSubview: self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(self.mas_height).multipliedBy(0.25);
        }];
        
    }
    return self;
}

#pragma mark - 方法

- (void)showPlayer{
    self.hidden = NO;
    [self.timer invalidate];
    [UIView animateWithDuration:self.fadeTime animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        //显示三秒后自动隐藏
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoHiddenPlayer) userInfo:nil repeats:NO];
    }];
}

- (void)autoHiddenPlayer{
    self.returnBlock();
    [self hiddenPlayer];
}

- (void)hiddenPlayer{
    [self.timer invalidate];
    [UIView animateWithDuration:self.fadeTime animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
- (void)updateCurrentTime:(CGFloat)currentTime bufferTime:(CGFloat)bufferTime allTime:(NSInteger)allTime{
    self.allTime = allTime;
    self.allFormatterTime = [self.formatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:allTime]];
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceReferenceDate:currentTime];
    self.timeLabel.text = [NSString stringWithFormat:@"%@/%@",[self.formatter stringFromDate: date],self.allFormatterTime];
    
    [self.slideView updateCurrentTime: currentTime / self.allTime];
    [self.slideView updateBufferTime: bufferTime / self.allTime];
}

- (void)setWithTitle:(NSString*)title videoTime:(NSInteger)videoTime{
    self.titleLabel.text = title;
    self.allTime = videoTime;
}

- (void)updateValue:(handle) block{
    self.returnBlock = block;
}

#pragma mark - 协议
- (void)playButtonTouchDown{
    self.playButton.selected = !self.playButton.isSelected;
    if([self.delegate respondsToSelector:@selector(playerTouchPlayerButton:)]){
        [self.delegate playerTouchPlayerButton: self];
    }
}

- (void)danMuButtonDown{
    if([self.delegate respondsToSelector:@selector(playerTouchDanMuButton:)]){
        [self.delegate playerTouchDanMuButton: self];
    }
}

- (void)arrowButtonDown{
    if([self.delegate respondsToSelector:@selector(playerTouchBackArrow:)]){
        [self.delegate playerTouchBackArrow: self];
    }
}

#pragma mark - 懒加载

- (UIView *)headView{
    if(_headView == nil) {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        
        UIButton* arrowButton = [[UIButton alloc] init];
        [arrowButton setBackgroundImage:[UIImage imageNamed:@"bili_player_back_button"] forState:UIControlStateNormal];
        [arrowButton addTarget:self action:@selector(arrowButtonDown) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview: arrowButton];
        [arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(20);
            make.centerY.equalTo(_headView);
            make.width.mas_equalTo(18);
            make.height.mas_equalTo(16);
        }];

        [_headView addSubview: self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(arrowButton.mas_right).mas_offset(10);
            make.centerY.equalTo(arrowButton);
        }];
    }
    return _headView;
}


- (UIView *)bottomView {
    if(_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        
        [_bottomView addSubview: self.slideView];

        [self.slideView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.equalTo(_bottomView);
            make.width.equalTo(_bottomView).mas_offset(-20);
            make.height.mas_equalTo(_bottomView.mas_height).multipliedBy(0.4);
        }];
        
        UIView* tempView = [[UIView alloc] init];
        [_bottomView addSubview: tempView];
        [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.slideView.mas_bottom);
            make.left.right.bottom.mas_equalTo(0);
        }];
        
        self.playButton = [[UIButton alloc] init];
        UIImage *buttonNorImg = [[UIImage imageNamed:@"ic_action_download_play"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage *buttonSelImg = [[UIImage imageNamed:@"ic_action_download_pause"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        self.playButton.tintColor = [UIColor whiteColor];
        [self.playButton setBackgroundImage:buttonNorImg forState:UIControlStateNormal];
        [self.playButton setBackgroundImage:buttonSelImg forState:UIControlStateSelected];
        [self.playButton addTarget:self action:@selector(playButtonTouchDown) forControlEvents:UIControlEventTouchUpInside];
        [tempView addSubview: self.playButton];
        [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tempView).mas_offset(20);
            make.width.mas_equalTo(23);
            make.height.mas_equalTo(26);
            make.centerY.equalTo(tempView);
        }];
        
        self.danMuButton = [UIButton new];
        [self.danMuButton setImage:[UIImage imageNamed:@"ic_answer_danmaku2"] forState:UIControlStateNormal];
        [self.danMuButton addTarget:self action:@selector(danMuButtonDown) forControlEvents:UIControlEventTouchUpInside];
        [self.danMuButton setTitle:@" 弹幕开关" forState:UIControlStateNormal];
        self.danMuButton.titleLabel.font = [UIFont systemFontOfSize: 12];
        [tempView addSubview: self.danMuButton];
        [self.danMuButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.playButton);
            make.right.mas_offset(-20);
        }];
        
        [_bottomView addSubview: self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.playButton.mas_right).mas_offset(20);
            make.centerY.equalTo(self.playButton);
        }];
    }
    return _bottomView;
}



- (UILabel *)titleLabel{
    if(_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize: 13];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if(_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize: 15];
        _timeLabel.text = @"00:00/00:00";
        _timeLabel.textColor = [UIColor whiteColor];
    }
    return _timeLabel;
}


- (NSDateFormatter *)formatter{
    if(_formatter == nil) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:@"mm:ss"];
    }
    return _formatter;
}

- (PlayerSliderView *)slideView{
    if(_slideView == nil) {
        _slideView = [[PlayerSliderView alloc] initWithLineWidth:3 currentTimeColor:[[ColorManager shareColorManager] colorWithString:@"themeColor"] bufferTimeColor:[UIColor grayColor] lineBackGroundColor:[UIColor whiteColor] thumbImg:nil];
        _slideView.delegate = self;
    }
    return _slideView;
}

#pragma mark - PlayerSliderView

- (void)playerSliderTouchEnd:(CGFloat)endValue playerSliderView:(PlayerSliderView *)PlayerSliderView{
    if([self.delegate respondsToSelector:@selector(playerTouchSlider:slideValue:)]){
        [self.delegate playerTouchSlider: self slideValue: endValue];
    }
}

@end
