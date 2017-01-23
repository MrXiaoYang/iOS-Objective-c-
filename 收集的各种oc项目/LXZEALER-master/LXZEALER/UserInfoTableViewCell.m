//
//  UserInfoTableViewCell.m
//  LXZEALER
//
//  Created by Lonely Stone on 16/1/27.
//  Copyright © 2016年 LonelyStone. All rights reserved.
//

#import "UserInfoTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation UserInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initDataForCellWithUser:(User*)user{
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:user.avatar_large]];
    
    self.nameLabel.text = user.name;
    
    self.descriptionLabel.text = user.userDescription;
    
    
}

@end
