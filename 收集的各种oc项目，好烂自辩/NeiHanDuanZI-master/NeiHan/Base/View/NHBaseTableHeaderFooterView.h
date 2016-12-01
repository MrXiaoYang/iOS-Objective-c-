//
//  NHBaseTableHeaderFooterView.h
//  NeiHan
//
//  Created by Charles on 16/8/31.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHBaseTableHeaderFooterView : UITableViewHeaderFooterView
/**
 *  快速创建一个不是从xib中加载的tableview header footer
 */
+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView;
/**
 *  快速创建一个从xib中加载的tableview header footer
 */
+ (instancetype)nibHeaderFooterViewWithTableView:(UITableView *)tableView;
 
@end