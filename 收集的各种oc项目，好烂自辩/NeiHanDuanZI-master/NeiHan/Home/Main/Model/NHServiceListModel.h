//
//  NHServiceListModel.h
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseModel.h"

@interface NHServiceListModel : NHBaseModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger refresh_interval;
@end
