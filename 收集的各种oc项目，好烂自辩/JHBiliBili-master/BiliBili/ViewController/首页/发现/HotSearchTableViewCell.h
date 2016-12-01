//
//  HotSearchTableViewCell.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/23.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotSearchTableViewCell : UITableViewCell
- (void)setWithRank:(NSIndexPath*)index keyWord:(NSString*)keyWord state:(NSString*)state;
@end
