//
//  HotSearchButton.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/23.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotSearchButton : UIButton
//@property (nonatomic, strong) NSString* keyWord;
@property (nonatomic, strong) UILabel* label;
- (instancetype)initWithKeyWord:(NSString*)keyWord;
@end
