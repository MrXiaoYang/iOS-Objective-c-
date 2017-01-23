//
//  NHHomeDynamicRequest.h
//  NeiHan
//
//  Created by Charles on 16/9/10.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseRequest.h"

@interface NHHomeDynamicRequest : NHBaseRequest
/** bury 踩 digg 顶*/
@property (nonatomic, copy) NSString *action;
@property (nonatomic, assign) NSInteger group_id;
@end
