//
//  ShiBanPlayTableModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/26.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseModel.h"
#import "ShinBanModel.h"
@class ShiBanPlayTableDateModel;
@interface ShiBanPlayTableModel : BaseModel
@property (nonatomic, strong) NSArray<ShiBanPlayTableDateModel*>* list;
@end

@interface ShiBanPlayTableDateModel : RecommentShinBanDataModel
/**
 *  最新话
 */
@property (nonatomic, strong)NSString* bgmcount;
/**
 *  更新时间
 */
@property (nonatomic, strong)NSString* weekday;
//@property (nonatomic, strong)NSNumber* favorites;
//@property (nonatomic, strong)NSString* pub_time;
//@property (nonatomic, strong)NSString* square_cover;
//@property (nonatomic, strong)NSNumber* new;
//@property (nonatomic, strong)NSNumber* play_count;
//@property (nonatomic, strong)NSString* url;
//@property (nonatomic, strong)NSNumber* bangumi_id;
//@property (nonatomic, strong)NSString* cover;
//@property (nonatomic, strong)NSNumber* lastupdate;
//@property (nonatomic, strong)NSNumber* is_finish;
//@property (nonatomic, strong)NSNumber* arealimit;
//@property (nonatomic, strong)NSString* lastupdate_at;
//@property (nonatomic, strong)NSNumber* attention;
//@property (nonatomic, strong)NSNumber* spid;
//@property (nonatomic, strong)NSString* area;
//@property (nonatomic, strong)NSNumber* danmaku_count;
@end
