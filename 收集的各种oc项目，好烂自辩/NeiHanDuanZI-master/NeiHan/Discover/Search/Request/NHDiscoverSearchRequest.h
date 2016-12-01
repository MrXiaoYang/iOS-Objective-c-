//
//  NHDiscoverSearchRequest.h
//  NeiHan
//
//  Created by Charles on 16/9/2.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseRequest.h"

@interface NHDiscoverSearchRequest : NHBaseRequest
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, assign) NSInteger offset;
@end
