//
//  UserInfoTableViewCell.h
//  LXZEALER
//
//  Created by Lonely Stone on 16/1/27.
//  Copyright © 2016年 LonelyStone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


- (void)initDataForCellWithUser:(User*)user;

@end
