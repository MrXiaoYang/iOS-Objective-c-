//
//  BTLikesUserCell.h
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTSubjectAuthor;
@interface BTLikesUserCell : UITableViewCell

@property (nonatomic, strong) BTSubjectAuthor *author;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
