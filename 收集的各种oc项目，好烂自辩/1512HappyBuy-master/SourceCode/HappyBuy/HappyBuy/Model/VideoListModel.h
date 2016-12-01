//
//  VideoListModel.h
//  HappyBuy
//
//  Created by tarena on 16/3/29.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 解析原则:
 总体原则: 遇到字典则新建类型
 具体:先建好所有类型, 再补充属性
 .m文件实现不要忘记写.  命名要有层次感
 */
//@class强行声明类型
//NSArray<数组中元素的类型 *> *array; xcode7新特性

/*
 1.检查类的命名是否规范
 2.检查属性中是否有关键词
 */

@class VideoListVideolistModel,VideoListVideosidlistModel;
@interface VideoListModel : NSObject

@property (nonatomic, copy) NSString *videoHomeSid;

@property (nonatomic, strong) NSArray<VideoListVideosidlistModel *> *videoSidList;

@property (nonatomic, strong) NSArray<VideoListVideolistModel *> *videoList;

@end

@interface VideoListVideosidlistModel : NSObject

@property (nonatomic, copy) NSString *sid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imgsrc;

@end

@interface VideoListVideolistModel : NSObject

@property (nonatomic, copy) NSString *ptime;

@property (nonatomic, copy) NSString *videosource;

@property (nonatomic, copy) NSString *topicImg;

@property (nonatomic, copy) NSString *topicSid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *sectiontitle;

@property (nonatomic, copy) NSString *vid;

@property (nonatomic, copy) NSString *m3u8_url;

@property (nonatomic, assign) NSInteger playersize;

@property (nonatomic, copy) NSString *topicName;

@property (nonatomic, assign) NSInteger replyCount;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *replyBoard;

@property (nonatomic, assign) NSInteger playCount;

@property (nonatomic, assign) NSInteger length;

@property (nonatomic, copy) NSString *topicDesc;

@property (nonatomic, copy) NSString *mp4Hd_url;

@property (nonatomic, copy) NSString *replyid;

@property (nonatomic, copy) NSString *m3u8Hd_url;

@property (nonatomic, copy) NSString *mp4_url;
//description -> desc
@property (nonatomic, copy) NSString *desc;

@end

