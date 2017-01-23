//
//  BTListPostLikesUsersCell.h
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickIconBlock)(NSInteger);

@interface BTListPostLikesUsersCell : UITableViewCell

@property (nonatomic, strong) NSArray *likesUsers;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)hideTopDiverLine:(BOOL)hide;

@property (nonatomic, copy) ClickIconBlock clickIconBlock;

@end
