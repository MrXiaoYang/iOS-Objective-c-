//
//  VideoModel.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/13.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel
- (NSMutableArray<VideoDataModel *> *)durl{
    if (_durl == nil) {
        _durl = [NSMutableArray array];
    }
    return _durl;
}
@end

@implementation VideoDataModel


@end

@implementation CIDModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list":[CIDDataModel class]};
}
@end

@implementation CIDDataModel


@end