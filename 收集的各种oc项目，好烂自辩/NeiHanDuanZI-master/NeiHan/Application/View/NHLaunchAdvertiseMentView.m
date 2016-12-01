//
//  NHLaunchAdvertiseMentView.m
//  NeiHan
//
//  Created by Charles on 16/9/6.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHLaunchAdvertiseMentView.h"

@interface NHLaunchAdvertiseMentView ()
@property (nonatomic, weak) UIImageView *img;
@property (nonatomic, weak) UIButton *downloadBtn;
@property (nonatomic, weak) UIButton *cancelBtn;
@end

@implementation NHLaunchAdvertiseMentView {
    NHLaunchAdvertiseMentViewCancelHandle _cancelHandle;
    NHLaunchAdvertiseMentViewDownloadHandle _downloadHandle;
}

- (void)setUpLaunchAdvertiseMentViewCancelHandle:(NHLaunchAdvertiseMentViewCancelHandle)cancelHandle {
    _cancelHandle = cancelHandle;
}

- (void)setUpLaunchAdvertiseMentViewDownloadHandle:(NHLaunchAdvertiseMentViewDownloadHandle)downloadHandle {
    _downloadHandle = downloadHandle;
}

- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    [self.img sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    
}

- (UIImageView *)img {
    if (!_img) {
        UIImageView *img = [[UIImageView alloc] init];
        [self addSubview:img];
        _img = img;
        
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.clipsToBounds = YES;
    }
    return _img;
}

- (UIButton *)downloadBtn {
    if (!_downloadBtn) {
        UIButton *download = [[UIButton alloc] init];
        [self addSubview:download];
        _downloadBtn = download;
        [download setTitle:@"前往下载" forState:UIControlStateNormal];
        [download addTarget:self action:@selector(downloadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        download.backgroundColor = kWhiteColor;
        [download setTitleColor:kBlackColor forState:UIControlStateNormal];
    }
    return _downloadBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        UIButton *cancelBtn = [[UIButton alloc] init];
        [self addSubview:cancelBtn];
        _cancelBtn = cancelBtn;
        [cancelBtn setTitle:@"跳过广告" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.backgroundColor = kWhiteColor;
        [cancelBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    }
    return _cancelBtn;
}

- (void)downloadBtnClick:(UIButton *)btn {
    if (_downloadHandle) {
        _downloadHandle();
    }
}

- (void)cancelBtnClick:(UIButton *)btn {
    if (_cancelHandle) {
        _cancelHandle();
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.img.frame = self.bounds;
    
    CGFloat cancelX = kScreenWidth - 70;
    CGFloat cancelY = 15;
    CGFloat cancelW = 60;
    CGFloat cancelH = 20;
    self.downloadBtn.frame = CGRectMake(cancelX, cancelY, cancelW, cancelH);
}
@end
