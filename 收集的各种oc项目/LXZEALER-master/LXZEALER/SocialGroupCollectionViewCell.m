//
//  SocialGroupCollectionViewCell.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/3.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "SocialGroupCollectionViewCell.h"

@implementation SocialGroupCollectionViewCell{
    NSArray *_nameArray;
}

- (void)awakeFromNib{
    _nameArray = @[@"手机Z友会",@"智能硬件研究所",@"我们都是外设控",@"我就是ZEALER粉",@"水一下也无妨",@"摄影就是这么玩",@"苹果迷",@"疑难杂症综合室",@"每天学点小知识",@"科技相对论",@"ZEALER FIX"];
}

- (void)setImageForCellWithIndexpath:(NSIndexPath*)indexpath{
    
    NSString *imageName = [NSString stringWithFormat:@"group%ld.jpg",indexpath.row + 1];
    self.groupImageView.image = [UIImage imageNamed:imageName];
    
    self.groupNameLabel.text = _nameArray[indexpath.row];
}

@end
