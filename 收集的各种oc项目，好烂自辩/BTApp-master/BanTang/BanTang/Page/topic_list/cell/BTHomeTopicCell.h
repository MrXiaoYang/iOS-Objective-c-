//
//  BTHomeTopicCell.h
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTHomeTopic;
@interface BTHomeTopicCell : UITableViewCell

@property (weak, nonatomic) UIImageView *iconView;

@property (nonatomic, strong) BTHomeTopic *topic;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
