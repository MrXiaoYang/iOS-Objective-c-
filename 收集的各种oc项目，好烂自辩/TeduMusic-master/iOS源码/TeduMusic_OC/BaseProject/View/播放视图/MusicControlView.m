//
//  MusicControlView.m
//  BaseProject
//
//  Created by yingxin on 15/12/23.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MusicControlView.h"

@implementation MusicControlView

+ (MusicControlView *)sharedMusicControlView{
    static MusicControlView *v = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
    return v;
}

- (IBAction)playNext:(id)sender {
}

- (IBAction)play:(id)sender {
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
