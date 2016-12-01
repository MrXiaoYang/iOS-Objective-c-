//
//  BTDoubleTitleLabel.h
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapDoubleTitleLabelBlock)();

@interface BTDoubleTitleLabel : UIView

@property (nonatomic, copy) NSString *num;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) TapDoubleTitleLabelBlock tapBlock;

@end
