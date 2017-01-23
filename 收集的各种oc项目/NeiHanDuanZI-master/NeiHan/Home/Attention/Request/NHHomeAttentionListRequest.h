//
//  NHHomeAttentionListRequest.h
//  NeiHan
//
//  Created by Charles on 16/8/31.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseRequest.h"

@interface NHHomeAttentionListRequest : NHBaseRequest
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger homepage_user_id;
@end
