//
//  BarrageDescriptor+Tools.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/13.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BarrageDescriptor.h"

@interface BarrageDescriptor (Tools)
+ (instancetype)descriptorWithText:(NSString*)text fontSize:(NSNumber*)size color:(NSInteger)color style:(NSNumber*)style;
@end
