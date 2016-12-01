//
//  NHDiscoverModel.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseModel.h"

@class NHDiscoverGodComment ,NHDiscoverCategories, NHDiscoverCategoryElement, NHDiscoverRotate_bannerElement, NHDiscoverRotate_banner, NHDiscoverRotate_bannerElementBanner_url, NHDiscoverRotate_bannerElementBanner_url_URL;
@interface NHDiscoverModel : NHBaseModel
@property (nonatomic, strong) NSMutableArray *my_top_category_list;
@property (nonatomic, strong) NSMutableArray *my_category_list;

@property (nonatomic, strong) NHDiscoverRotate_banner *rotate_banner;
@property (nonatomic, strong) NHDiscoverCategories *categories;
@property (nonatomic, strong) NHDiscoverGodComment *god_comment;
@end

@interface NHDiscoverGodComment : NHBaseModel
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) NSInteger count;
@end

@interface NHDiscoverCategories : NHBaseModel
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) NSInteger category_count;

@property (nonatomic, strong) NSMutableArray <NHDiscoverCategoryElement *>*category_list;
@end

@interface NHDiscoverCategoryElement : NHBaseModel
 @property (nonatomic, assign) BOOL is_recommend;
@property (nonatomic, assign) BOOL is_top;
@property (nonatomic, assign) BOOL visible;
@property (nonatomic, assign) BOOL has_timeliness;
@property (nonatomic, assign) BOOL is_risk;

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *small_icon_url;
@property (nonatomic, copy) NSString *buttons;
@property (nonatomic, copy) NSString *extra;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *small_icon;
@property (nonatomic, copy) NSString *channels;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *placeholder;


@property (nonatomic, assign) NSInteger share_type;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger total_updates;
@property (nonatomic, assign) NSInteger big_category_id;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger allow_text;
@property (nonatomic, assign) NSInteger post_rule_id;
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, assign) NSInteger subscribe_count;
@property (nonatomic, assign) NSInteger allow_multi_image;
@property (nonatomic, assign) NSInteger today_updates;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger allow_gif;
@property (nonatomic, assign) NSInteger allow_text_and_pic;
@property (nonatomic, assign) NSInteger allow_video;
@property (nonatomic, assign) NSInteger dedup;
@property (nonatomic, strong) NSArray *material_bar;

@end
@interface NHDiscoverRotate_banner : NHBaseModel

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSMutableArray <NHDiscoverRotate_bannerElement*>*banners;
@end

@interface NHDiscoverRotate_bannerElement : NHBaseModel
@property (nonatomic, copy) NSString *schema_url;
@property (nonatomic, strong) NHDiscoverRotate_bannerElementBanner_url *banner_url;
@end

@interface NHDiscoverRotate_bannerElementBanner_url : NHBaseModel
@property (nonatomic, copy) NSString *title; 
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSMutableArray <NHDiscoverRotate_bannerElementBanner_url_URL *>*url_list;
@end

@interface NHDiscoverRotate_bannerElementBanner_url_URL : NHBaseModel
@property (nonatomic, copy) NSString *url;
@end
