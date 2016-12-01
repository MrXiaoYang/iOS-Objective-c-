//
//  BarrageDescriptor+Tools.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/13.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BarrageDescriptor+Tools.h"
#import "UIColor+Art.h"
@implementation BarrageDescriptor (Tools)
+ (instancetype)descriptorWithText:(NSString*)text fontSize:(NSNumber*)size color:(NSInteger)color style:(NSNumber*)style{
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    if (style.intValue == 1) {
        descriptor.spiritName = @"BarrageWalkTextSpirit";
    }else if(style.intValue == 4 || style.intValue == 5){
        descriptor.spiritName = @"BarrageFloatTextSpirit";
    }
    [descriptor.params setObject:text forKey:@"text"];
    [descriptor.params setObject:size forKey:@"fontSize"];
    [descriptor.params setObject:@(1) forKey:@"borderWidth"];
    [descriptor.params setObject:[UIColor colorWithHex:color] forKey:@"textColor"];
    [descriptor.params setObject:@(100 * (double)random()/RAND_MAX+50) forKey:@"speed"];
    [descriptor.params setObject:@(3) forKey:@"duration"];
    [descriptor.params setObject:(style.intValue == 1) ? @(1) : (style.intValue == 4) ? @(2) : @(1) forKey:@"direction"];
    return descriptor;
}
@end
