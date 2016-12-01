//
//  FirstTableViewCell.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/2.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "FirstTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation FirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

/**
 *  给首页上的视频区的cell添加图片
 *
 *  @param indexpath cell indexpath
 */
- (void)setImageForCellWithIndexpath:(NSIndexPath*)indexpath{
    
    NSArray *imageNameArray = [NSArray arrayWithObjects:@"video1.jpg",
                         @"video2.jpg",
                         @"video3.jpg",
                         @"video4.jpg",
                         @"video5.jpg",nil];
    //根据网络请求加载cell上的图片,由于此项目拿不到zealer的URL所以只能使用死图片.
    [self.titleImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:imageNameArray[indexpath.row]]];
}

/**
 *  为 "社区" 功能的cell设置图片
 *
 *  @param indexpath cell 的 indexpath
 */
- (void)setImageForCommentCellWithIndexpath:(NSIndexPath*)indexpath{
    NSString *imageName = [NSString stringWithFormat:@"comment%ld.jpg",indexpath.row + 1];
    [self.commentImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:imageName]];
}

@end
