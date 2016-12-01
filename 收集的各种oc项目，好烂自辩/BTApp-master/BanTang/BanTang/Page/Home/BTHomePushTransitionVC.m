//
//  BTHomePushTransitionVC.m
//  BanTang
//
//  Created by Ryan on 16/1/5.
//  Copyright © 2016年 Ryan. All rights reserved.
//

#import "BTHomePushTransitionVC.h"
#import "BTHomeTopicCell.h"

@interface BTHomePushTransitionVC ()

@end

@implementation BTHomePushTransitionVC

- (UIImageView *)transitionSourceImageView
{
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    BTHomeTopicCell *cell = (BTHomeTopicCell *)[self.tableView cellForRowAtIndexPath:selectedIndexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.iconView.image];
    imageView.contentMode = cell.imageView.contentMode;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    imageView.frame = [cell.iconView convertRect:cell.iconView.frame toView:self.tableView.superview];
    CGRect tmp = imageView.frame;
    tmp.size = CGSizeMake(kScreen_Width, 200);
    imageView.frame = tmp;
    return imageView;
}

- (UIColor *)transitionSourceBackgroundColor
{
    return self.tableView.backgroundColor;
}

- (CGRect)transitionDestinationImageViewFrame
{
	NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    BTHomeTopicCell *cell = (BTHomeTopicCell *)[self.tableView cellForRowAtIndexPath:selectedIndexPath];
    CGRect cellFrameInSuperview = [cell.iconView convertRect:cell.iconView.frame toView:self.tableView.superview];
    return cellFrameInSuperview;
}


@end
