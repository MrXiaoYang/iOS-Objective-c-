//
//  BTListPostProductCell.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/29.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BTProduct;

@interface BTListPostProductCell : UITableViewCell
@property (nonatomic, strong) BTProduct *product;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
