//
//  UnLoginCell.h
//  BaseProject
//
//  Created by yingxin on 15/12/30.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UnLoginCell;

typedef NS_ENUM(NSUInteger, ButtonType) {
    ButtonTypeLogin,
    ButtonTypeRegister,
};


@protocol UnLoginCellDelegate <NSObject>

-(void)unLoginCell:(UnLoginCell *)cell clickBtn:(ButtonType)type;

@end


@interface UnLoginCell : UITableViewCell

@property(nonatomic, weak) id<UnLoginCellDelegate> delegate;

@end
