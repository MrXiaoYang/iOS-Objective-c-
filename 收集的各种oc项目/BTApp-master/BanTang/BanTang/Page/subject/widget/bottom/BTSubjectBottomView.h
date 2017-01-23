//
//  BTSubjectBottomView.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JoinButtonDidBlock)();

@interface BTSubjectBottomView : UIView

+ (instancetype)bottomView;

@property (nonatomic, copy) JoinButtonDidBlock joinButtonDidBlock;

@end
