//
//  SpecialModel.m
//  BiliBili
//
//  Created by apple-jd24 on 15/12/13.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SpecialModel.h"

@implementation SpecialModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list":[SpecialDateModel class]};
}
@end

@implementation SpecialDateModel

@end