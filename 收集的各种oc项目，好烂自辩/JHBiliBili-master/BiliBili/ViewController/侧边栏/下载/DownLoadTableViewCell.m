//
//  DownLoadTableViewCell.m
//  BiliBili
//
//  Created by apple-jd44 on 15/12/4.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "DownLoadTableViewCell.h"
#import "BaseNetManager.h"
@interface DownLoadTableViewCell ()

@end
@implementation DownLoadTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier taskIsPause:(BOOL)taskIsPause{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.progressView setProgress: 0];
        self.detailTextLabel.text = @"0%";
        self.textLabel.font = [UIFont systemFontOfSize: 13];
        [self.textLabel setTextColor:[[ColorManager shareColorManager] colorWithString:@"textColor"]];
        self.suspandButton.selected = taskIsPause;
        //self.aid = aid;
    }
    return self;
}


- (void)updateProgress:(float)progress{
    [self.progressView setProgress: progress];
    self.detailTextLabel.text = [NSString stringWithFormat:@"%.1f%%", progress * 100];
}

- (void)updateBolock:(buttonHandle)buttonHandle{
    self.block = buttonHandle;
}

- (void)touchSuspandButton{
    if (self.block) self.block();
}

#pragma mark - 懒加载
- (UIProgressView *)progressView {
    if(_progressView == nil) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.progressTintColor = [[ColorManager shareColorManager] colorWithString:@"themeColor" alpha:0.8];
        _progressView.trackTintColor = [UIColor clearColor];
        [self.contentView addSubview: self.progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _progressView;
}

- (UIButton *)suspandButton {
    if(_suspandButton == nil) {
        _suspandButton = [[UIButton alloc] init];
        [_suspandButton setBackgroundImage:[UIImage imageNamed:@"ic_action_download_play"] forState:UIControlStateSelected];
        [_suspandButton setBackgroundImage:[UIImage imageNamed:@"ic_action_download_pause"] forState:UIControlStateNormal];
        //按钮点击
        [_suspandButton addTarget:self action:@selector(touchSuspandButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview: _suspandButton];
        [_suspandButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.right.mas_offset(-5);
        }];
    }
    return _suspandButton;
}

@end
