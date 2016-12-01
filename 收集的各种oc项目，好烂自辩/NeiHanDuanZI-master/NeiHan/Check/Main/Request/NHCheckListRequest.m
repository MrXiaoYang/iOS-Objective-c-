//
//  NHCheckListRequest.m
//  NeiHan
//
//  Created by Charles on 16/9/5.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHCheckListRequest.h"
#import "NSDate+Addition.h"

@implementation NHCheckListRequest

- (NSInteger)max_create_time {
    return [[NSDate date] timeIntervalSince1970] * 1000;
}
@end
