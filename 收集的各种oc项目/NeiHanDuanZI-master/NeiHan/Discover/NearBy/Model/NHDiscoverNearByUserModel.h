//
//  NHDiscoverNearByUserModel.h
//  NeiHan
//
//  Created by Charles on 16/9/4.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseModel.h"

@interface NHDiscoverNearByUserModel : NHBaseModel
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatar_url;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger last_update;
@end
