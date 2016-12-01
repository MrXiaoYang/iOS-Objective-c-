//
//  ReplyModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/6.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

/**
 *   评论模型
 * 
 */

#import "BaseModel.h"

@interface ReplyModel : BaseModel
@property (nonatomic, strong) NSArray* list;
@property (nonatomic, assign) NSInteger results;
@end


@interface ReplyDataModel : BaseModel
//头像
@property (nonatomic, strong)NSString* face;
//性别
@property (nonatomic, strong)NSString* sex;
//昵称
@property (nonatomic, strong)NSString* nick;
//发表时间
@property (nonatomic, strong)NSString* create_at;
//楼层
@property (nonatomic, assign)NSInteger lv;
//点赞数
@property (nonatomic, assign)NSInteger good;
//回复内容
@property (nonatomic, strong)NSString* msg;
//@property (nonatomic, strong)NSNumber* mid;
//@property (nonatomic, strong)NSNumber* ad_check;
//@property (nonatomic, strong)NSNumber* rank;
//@property (nonatomic, strong)NSNumber* bad;
//@property (nonatomic, strong)NSDictionary* level_info;
//@property (nonatomic, strong)NSNumber* fbid;
//@property (nonatomic, strong)NSNumber* create;
//@property (nonatomic, strong)NSString* device;
//@property (nonatomic, strong)NSNumber* reply_count;
@end