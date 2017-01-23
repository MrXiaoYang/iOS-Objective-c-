//
//  ShiBanPlayTableModel.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/26.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ShiBanPlayTableModel.h"

@implementation ShiBanPlayTableModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[ShiBanPlayTableDateModel class]};
}
@end

@implementation ShiBanPlayTableDateModel

@end
