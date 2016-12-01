//
//  NHDiscoverTopicRequest.h
//  NeiHan
//
//  Created by Charles on 16/9/2.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseRequest.h"

@interface NHDiscoverTopicRequest : NHBaseRequest
//&category_id=6&count=30&level=6&message_cursor=0&mpic=1
@property (nonatomic, assign) NSInteger category_id;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger mpic;;
@property (nonatomic, assign) NSInteger message_cursor;
//mpicmpic
@end
