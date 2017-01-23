//
//  recommendModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/10/21.
//  Copyright © 2015年 JimHuang. All rights reserved.
//
/**
 * 视频展示类 包含缩略图 标题 播放数 回复数
 *
 */
#import "BaseModel.h"
@interface AVModel : BaseModel
@property (nonatomic, strong) NSArray* list;
@end

@interface AVDataModel : BaseModel
//@property (nonatomic, strong)NSNumber* mid;
//@property (nonatomic, strong)NSString* subtitle;
//@property (nonatomic, assign)NSInteger favorites;
//@property (nonatomic, strong)NSString* duration;
//硬币数
//@property (nonatomic, assign)NSInteger coins;
//回复数
//@property (nonatomic, assign)NSInteger review;

//缩略图部分
//图片地址
@property (nonatomic, strong)NSString* pic;
//标题
@property (nonatomic, strong)NSString* title;
//播放数
@property (nonatomic, assign)NSInteger play;
//弹幕数
@property (nonatomic, assign)NSInteger video_review;
//简介
@property (nonatomic, strong)NSString* desc;
//作者
@property (nonatomic, strong)NSString* author;
//创建时间
@property (nonatomic, strong)NSString* create;
//av号
@property (nonatomic, strong)NSString* aid;
//cid
@property (nonatomic, strong)NSString* cid;
@end