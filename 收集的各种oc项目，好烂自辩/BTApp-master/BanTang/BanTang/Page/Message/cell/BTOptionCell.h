//
//  BTMessageOptionCell.h
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTOption;
typedef void(^OptionCellDidClickBlock)();

@interface BTOptionCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) BTOption *option;

@property (nonatomic, copy) OptionCellDidClickBlock optionCellDidClickBlock;

- (void)hideSpeatorLine:(BOOL)boolean;

@end
