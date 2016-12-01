//
//  BusinessCell.m
//  HappyBuy
//
//  Created by tarena on 16/4/1.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "BusinessCell.h"

@implementation BusinessCell

- (void)setPrice:(NSString *)price{
    _price = price;
    //红色¥ + 黑色数字
    NSDictionary *str1Dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName: [UIColor redColor]};
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"¥" attributes:str1Dic];
    
    NSDictionary *str2Dic = @{NSFontAttributeName:[UIFont systemFontOfSize:20], NSForegroundColorAttributeName: [UIColor blackColor]};
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:price attributes:str2Dic];
    NSMutableAttributedString *str = [NSMutableAttributedString new];
    [str appendAttributedString:str1];
    [str appendAttributedString:str2];
    _priceLb.attributedText = str;
}

- (void)awakeFromNib {
    // Initialization code
//用于去掉cell的左侧空隙
    self.separatorInset = UIEdgeInsetsZero;
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
