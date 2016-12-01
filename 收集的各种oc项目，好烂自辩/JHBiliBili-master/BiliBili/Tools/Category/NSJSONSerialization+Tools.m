//
//  NSJSONSerialization+Tools.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/17.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "NSJSONSerialization+Tools.h"

@implementation NSJSONSerialization (Tools)
+ (id)json2DicWithData:(NSData*)data{
    if (data == nil) return nil;
    id dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments error:nil];
    return dic;
}
@end
