//
//  BTMessageOpeartionCell.h
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTFirstpageElement,BTMessageDiverLabelCell;
@interface BTMessageOpeartionCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) BTFirstpageElement *element;

@end

@interface BTMessageDiverLabelCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, copy) NSString *title;

@end

