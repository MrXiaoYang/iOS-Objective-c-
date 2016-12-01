//
//  NHHomeServiceDataModel.h
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseModel.h"
#import "NHNeiHanUserInfoModel.h"

/**
 *  数据类型
 */
typedef NS_ENUM(NSUInteger, NHHomeServiceDataElementMediaType) {
    /** 大图*/
    NHHomeServiceDataElementMediaTypeLargeImage = 1,
    /** Gif图片*/
    NHHomeServiceDataElementMediaTypeGif = 2,
    /** 视频*/
    NHHomeServiceDataElementMediaTypeVideo = 3,
    /** 小图*/
    NHHomeServiceDataElementMediaTypeLittleImages = 4,
    /** 精华*/
    NHHomeServiceDataElementMediaTypeEssence = 5,
    
//    http://i.snssdk.com/neihan/in_app/essence_detail/6327517973125595394/?item_id=6327517935317287425&refer=click_feed
    
    
};

@class NHHomeServiceDataElementGroupLargeImage,NHHomeServiceDataElement, NHHomeServiceDataElementGroupGifVideo,NHHomeServiceDataElementGroupLarge_Image,NHHomeServiceDataElementComment,NHHomeServiceDataElementGroupLargeImageUrl, NHHomeServiceDataElementGroupDislike_reason, NHHomeServiceDataElementGroup;

@interface NHHomeServiceDataModel : NHBaseModel
@property (nonatomic, assign) BOOL has_more;
@property (nonatomic, copy) NSString *tip;
@property (nonatomic, assign) NSInteger min_time;
@property (nonatomic, assign) NSInteger max_time;
@property (nonatomic, strong) NSMutableArray <NHHomeServiceDataElement *>*data;
@end

@interface NHHomeServiceDataElement : NHBaseModel
/** 列表数据*/
@property (nonatomic, strong) NHHomeServiceDataElementGroup *group;
/** 列表中神评论*/
@property (nonatomic, strong) NSMutableArray <NHHomeServiceDataElementComment *>*comments;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger display_time;
@property (nonatomic, assign) NSInteger online_time;
@end

@interface NHHomeServiceDataElementComment : NHBaseModel

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *user_profile_image_url;
@property (nonatomic, copy) NSString *platform;
@property (nonatomic, copy) NSString *platformid;
@property (nonatomic, copy) NSString *user_profile_url;
@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, assign) BOOL user_verified;

@property (nonatomic, assign) NSInteger create_time;
@property (nonatomic, assign) NSInteger user_bury;
/** 用户ID*/
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger is_digg;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger share_type;
@property (nonatomic, assign) NSInteger group_id;
@property (nonatomic, assign) NSInteger comment_id;

@property (nonatomic, strong) NSArray <NHHomeServiceDataElementComment *>*reply_comments;

@end

@interface NHHomeServiceDataElementGroup : NHBaseModel
/** 文本*/
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *category_name;
@property (nonatomic, copy) NSString *status_desc;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *m3u8_url;
@property (nonatomic, copy) NSString *cover_image_url;

@property (nonatomic, assign) NSInteger category_id;
@property (nonatomic, assign) NSInteger create_time;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger favorite_count;
@property (nonatomic, assign) NSInteger user_favorite;
@property (nonatomic, assign) NSInteger share_type;
@property (nonatomic, assign) NSInteger is_can_share;
@property (nonatomic, assign) NSInteger category_type;
@property (nonatomic, assign) NSInteger go_detail_count;
@property (nonatomic, assign) NSInteger comment_count;
@property (nonatomic, assign) NSInteger label;
@property (nonatomic, assign) NSInteger share_count;
@property (nonatomic, assign) NSInteger id_str;
/** 数据类型*/
@property (nonatomic, assign) NHHomeServiceDataElementMediaType media_type;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger thas_commentsype;
/** 踩过*/
@property (nonatomic, assign) NSInteger user_bury;
/** 顶过*/
@property (nonatomic, assign) NSInteger user_digg;
/** 踩*/
@property (nonatomic, assign) NSInteger bury_count;
@property (nonatomic, assign) NSInteger online_time;
@property (nonatomic, assign) NSInteger repin_count;
/** 点赞*/
@property (nonatomic, assign) NSInteger digg_count;
@property (nonatomic, assign) NSInteger has_hot_comments;
@property (nonatomic, assign) NSInteger user_repin;
@property (nonatomic, assign) NSInteger duration;

@property (nonatomic, assign) BOOL allow_dislike;
@property (nonatomic, assign) BOOL category_visible;
@property (nonatomic, assign) BOOL is_anonymous;
@property (nonatomic, assign) BOOL is_multi_image;
@property (nonatomic, assign) BOOL is_gif;
@property (nonatomic, assign) BOOL has_comments;

@property (nonatomic, strong) NHHomeServiceDataElementGroupLargeImage * video_360P;
@property (nonatomic, strong) NHHomeServiceDataElementGroupLargeImage * video_720P;
@property (nonatomic, strong) NHHomeServiceDataElementGroupLargeImage * video_480p;

@property (nonatomic, strong) NHHomeServiceDataElementGroupLargeImage * large_cover;
@property (nonatomic, strong) NHHomeServiceDataElementGroupLargeImage * medium_cover;
@property (nonatomic, strong) NHHomeServiceDataElementGroupLargeImage * origin_video;

@property (nonatomic, strong) NHHomeServiceDataElementGroupGifVideo * gifvideo;
/** 当前数据对应的用户信息*/
@property (nonatomic, strong) NHNeiHanUserInfoModel *user;

@property (nonatomic, strong) NHHomeServiceDataElementGroupLarge_Image * large_image;
@property (nonatomic, strong) NHHomeServiceDataElementGroupLarge_Image * middle_image;

@property (nonatomic, strong) NSMutableArray <NHHomeServiceDataElementGroupDislike_reason *>* dislike_reason;
@property (nonatomic, strong) NSMutableArray <NHHomeServiceDataElementGroupLargeImage *>* large_image_list;
@property (nonatomic, strong) NSMutableArray <NHHomeServiceDataElementGroupLargeImage *>* thumb_image_list;

@end

@interface NHHomeServiceDataElementGroupLargeImage : NHBaseModel
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) BOOL is_gif;
@property (nonatomic, strong) NSMutableArray <NHHomeServiceDataElementGroupLargeImageUrl *>*url_list;
@end

@interface NHHomeServiceDataElementGroupLargeImageUrl : NHBaseModel
@property (nonatomic, copy) NSString *url;
@end

@interface NHHomeServiceDataElementGroupDislike_reason : NHBaseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger type;
@end
@interface NHHomeServiceDataElementGroupLarge_Image : NHBaseModel
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, assign) NSInteger r_height;
@property (nonatomic, assign) NSInteger r_width;
@property (nonatomic, assign) BOOL is_gif;
@property (nonatomic, strong) NSMutableArray <NHHomeServiceDataElementGroupLargeImageUrl *>*url_list;
@end
@interface NHHomeServiceDataElementGroupGifVideo : NHBaseModel
@property (nonatomic, strong) NHHomeServiceDataElementGroupLargeImage *video_360P;
@property (nonatomic, strong) NHHomeServiceDataElementGroupLargeImage *video_720P;
@property (nonatomic, strong) NHHomeServiceDataElementGroupLargeImage *video_480P;
@property (nonatomic, copy) NSString *mp4_url;
@property (nonatomic, copy) NSString *cover_image_uri;
@property (nonatomic, assign) NSInteger video_height;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) NSInteger video_width;

@end