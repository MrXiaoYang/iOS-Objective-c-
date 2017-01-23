//
//  RegisterCell.m
//  BaseProject
//
//  Created by yingxin on 15/12/30.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "RegisterCell.h"

@implementation RegisterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [_delegate textChangedInRegisterCell:self];
}

@end
