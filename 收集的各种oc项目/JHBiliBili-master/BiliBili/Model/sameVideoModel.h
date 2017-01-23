//
//  sameVideoModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/6.
//  Copyright © 2015年 JimHuang. All rights reserved.
//
/**
 *  视频推荐
 *
 */
#import "BaseModel.h"

@interface sameVideoModel : BaseModel
@property (nonatomic, strong) NSArray* list;
@end

@interface sameVideoDataModel : BaseModel
//av号
@property (nonatomic, strong)NSString* identity;
//回复数
@property (nonatomic, assign)NSInteger dm_count;
//播放数
@property (nonatomic, assign)NSInteger click;
//图片
@property (nonatomic, strong)NSString* pic;
//标题
@property (nonatomic, strong)NSString* title;
@property (nonatomic, strong)NSString* desc;
@property (nonatomic, strong)NSString* author_name;
@property (nonatomic, strong)NSString* pubdate;
//@property (nonatomic, strong)NSString* stow;
//@property (nonatomic, strong)NSString* subtitle;
//@property (nonatomic, strong)NSString* editdate;
//@property (nonatomic, strong)NSString* scores;
//@property (nonatomic, strong)NSString* duration;
//@property (nonatomic, strong)NSString* typeID;
@end
