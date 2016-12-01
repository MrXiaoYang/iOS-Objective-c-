//
//  NHBaseTableViewCell.h
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHBaseTableViewCell : UITableViewCell

@property (nonatomic, weak) UITableView *tableView;

/**
 *  快速创建一个不是从xib中加载的tableview cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  快速创建一个从xib中加载的tableview cell
 */
+ (instancetype)nibCellWithTableView:(UITableView *)tableView; 
@end
