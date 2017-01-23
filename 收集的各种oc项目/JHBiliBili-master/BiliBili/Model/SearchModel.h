//
//  SearchModel.h
//  BiliBili
//
//  Created by apple-jd24 on 15/12/12.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseModel.h"
#import "ShinBanModel.h"


@interface SearchModel : BaseModel
/*搜索返回的字典
* bangumi 番剧
  special 专题
  topic 话题
  tvplay
  upuser up主
  video 相关视频
*/
@property (nonatomic, strong)NSDictionary* bangumi;
@property (nonatomic, strong)NSDictionary* special;
@property (nonatomic, strong)NSDictionary* video;
@end

/*
 番剧
 */
@interface SearchShibanModel : RecommentShinBanDataModel
//描述
@property (nonatomic, strong)NSString* evaluate;
//点击量
@property (nonatomic, assign)NSInteger play_count;
//订阅数
@property (nonatomic, assign)NSInteger favorites;
//是否完结
@property (nonatomic, strong)NSString* is_finish;
//最新更新集数
@property (nonatomic, strong)NSString* newest_ep_index;
@end



/*
 专题
 */
@interface SearchSpecialModel : BaseModel
//标题
@property (nonatomic, strong)NSString* title;
//点击数
@property (nonatomic, strong)NSString* click;
//订阅
@property (nonatomic, strong)NSString* favourite;
//图片
@property (nonatomic, strong)NSString* pic;
//spid
@property (nonatomic, strong)NSString* spid;
//简介
@property (nonatomic, strong)NSString* desc;
//@property (nonatomic, strong)NSString* author;
//@property (nonatomic, strong)NSNumber* is_bangumi;
//@property (nonatomic, strong)NSString* mid;
//@property (nonatomic, strong)NSString* typename;
//@property (nonatomic, strong)NSNumber* count;
//@property (nonatomic, strong)NSNumber* lastupdate;
//@property (nonatomic, strong)NSString* tag;
//@property (nonatomic, strong)NSString* arcurl;
//@property (nonatomic, strong)NSString* type;
//@property (nonatomic, strong)NSString* typeurl;
//@property (nonatomic, strong)NSNumber* pubdate;
//@property (nonatomic, strong)NSNumber* id;
//@property (nonatomic, strong)NSNumber* attention;
//@property (nonatomic, strong)NSString* thumb;
//@property (nonatomic, strong)NSNumber* spcount;
//@property (nonatomic, strong)NSNumber* bgmcount;
//@property (nonatomic, strong)NSNumber* is_bangumi_end;
//@property (nonatomic, strong)NSNumber* postdate;
//@property (nonatomic, strong)NSNumber* ischeck;
@end