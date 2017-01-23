//
//  BusinessCell.h
//  HappyBuy
//
//  Created by tarena on 16/4/1.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessCell : UITableViewCell
/** 商家图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
/** 已购买数量 */
@property (weak, nonatomic) IBOutlet UILabel *buyNumLb;
/** 商家名称 */
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
/** 价格 */
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
/** 折扣 */
@property (weak, nonatomic) IBOutlet UILabel *discountLb;

//设置价格的, ¥86
@property (nonatomic, strong) NSString *price;
@end










