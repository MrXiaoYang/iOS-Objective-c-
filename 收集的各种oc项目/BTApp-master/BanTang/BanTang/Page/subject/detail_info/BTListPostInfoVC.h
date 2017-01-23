//
//  BTListPostInfoVC.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/29.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTListPost,BTListPostDynamic;
@interface BTListPostInfoVC : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSString *extendId;

@property (nonatomic, strong) BTListPostDynamic *dynamic;

@property (nonatomic, assign) NSInteger indexPathRow;

@end
