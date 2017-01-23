//
//  BTIconLabelView.h
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapIconLabelViewBlock)();

@interface BTIconLabelView : UIView

@property (nonatomic, copy) NSString *iconImageName;

@property (nonatomic, copy) NSString *num;

@property (nonatomic, copy) TapIconLabelViewBlock tapIconBlock;

@end
