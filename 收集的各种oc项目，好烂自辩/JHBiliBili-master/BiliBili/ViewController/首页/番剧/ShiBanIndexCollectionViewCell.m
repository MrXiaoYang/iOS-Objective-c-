//
//  ShiBanIndexCollectionViewCell.m
//  BiliBili
//
//  Created by JimHuang on 16/1/15.
//  Copyright © 2016年 JimHuang. All rights reserved.
//

#import "ShiBanIndexCollectionViewCell.h"
#import "ShiBanPlayTableViewController.h"
#import "UIApplication+Tools.h"

@interface ShiBanIndexCollectionViewCell()
@property (nonatomic, strong) UIButton *everyDayPlay;
@property (nonatomic, strong) UIButton *shinBanIndex;
@property (nonatomic, strong) UINavigationController *nav;
@end

@implementation ShiBanIndexCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview: self.everyDayPlay];
        [self addSubview: self.shinBanIndex];
    }
    return self;
}

- (void)everyDayPlayDown{
    //推出每日放送表
    [self.nav pushViewController: [[ShiBanPlayTableViewController alloc] init] animated:YES];
}

#pragma mark - 懒加载
- (UIButton *)everyDayPlay {
	if(_everyDayPlay == nil) {
        CGFloat width = (self.frame.size.width - 50) / 2;
		_everyDayPlay = [[UIButton alloc] initWithFrame: CGRectMake(20, 0, width, width * 0.29)];
        CGPoint center = _everyDayPlay.center;
        center.y = self.center.y;
        _everyDayPlay.center = center;

        [_everyDayPlay setBackgroundImage:[UIImage imageNamed:@"home_bangumi_timeline"] forState:UIControlStateNormal];
        [_everyDayPlay addTarget:self action:@selector(everyDayPlayDown) forControlEvents:UIControlEventTouchUpInside];
	}
	return _everyDayPlay;
}

- (UIButton *)shinBanIndex {
	if(_shinBanIndex == nil) {
        CGRect rect = self.everyDayPlay.frame;
        rect.origin.x += rect.size.width + 10;
		_shinBanIndex = [[UIButton alloc] initWithFrame: rect];
        [_shinBanIndex setBackgroundImage:[UIImage imageNamed:@"home_bangumi_category"] forState:UIControlStateNormal];
	}
	return _shinBanIndex;
}
- (UINavigationController *)nav{
	if(_nav == nil) {
		_nav = (UINavigationController *)[[UIApplication sharedApplication] activityViewController];
	}
	return _nav;
}

@end
