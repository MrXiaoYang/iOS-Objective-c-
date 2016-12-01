//
//  MyRefreshComplet.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/19.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface MyRefreshComplete : NSObject
+ (id)myRefreshHead:(void(^)())block;
+ (id)myRefreshFoot:(void(^)())block;
@end