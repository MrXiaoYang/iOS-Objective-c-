//
//  TuWanVideoModel.m
//  BaseProject
//
//  Created by jiyingxin on 15/11/8.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "TuWanVideoModel.h"

@implementation TuWanVideoModel


+ (NSDictionary *)objectClassInArray{
    return @{@"content" : [TuWanVideoContentModel class], @"relevant" : [TuWanVideoRelevantModel class]};
}
@end
@implementation TuWanVideoContentModel

@end


@implementation TuWanVideoRelevantModel

@end


