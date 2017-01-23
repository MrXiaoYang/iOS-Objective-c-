//
//  SectionViewController.h
//  BiliBili
//
//  Created by apple-jd24 on 15/12/16.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "JHViewController.h"
/**
 *  分区总控制器
 */
@interface SectionViewController : JHViewController
- (instancetype)initWithControllers:(NSArray *)controllers titles:(NSArray*)titles style:(NSString*)style;
@end
