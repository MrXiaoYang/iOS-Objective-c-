//
//  UnLoginCell.m
//  BaseProject
//
//  Created by yingxin on 15/12/30.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "UnLoginCell.h"

@implementation UnLoginCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



- (IBAction)clickLogin:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(unLoginCell:clickBtn:)]) {
        [_delegate unLoginCell:self clickBtn:ButtonTypeLogin];
    }
    
}

- (IBAction)clickRegister:(id)sender {
    if ([_delegate respondsToSelector:@selector(unLoginCell:clickBtn:)]) {
        [_delegate unLoginCell:self clickBtn:ButtonTypeRegister];
    }
}

@end
