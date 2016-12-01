//
//  RegisterCell.h
//  BaseProject
//
//  Created by yingxin on 15/12/30.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterCell;

@protocol RegisterCellDelegate <NSObject>

- (void)textChangedInRegisterCell:(RegisterCell *)cell;

@end

@interface RegisterCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;

@property(nonatomic, weak) id<RegisterCellDelegate> delegate;

@end
