//
//  TuWanPicModel.h
//  BaseProject
//
//  Created by jiyingxin on 15/11/8.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class TuWanPicInfochildModel,TuWanPicShowitemModel,TuWanPicShowitemInfoModel,TuWanPicRelevantModel,TuWanPicContentModel,TuWanPicContentInfoModel;
@interface TuWanPicModel : BaseModel

@property (nonatomic, copy) NSString *color;

@property (nonatomic, copy) NSString *showtype;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *click;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *typechild;

@property (nonatomic, copy) NSString *longtitle;

@property (nonatomic, copy) NSString *typename;

@property (nonatomic, copy) NSString *html5;

@property (nonatomic, strong) TuWanPicInfochildModel *infochild;

@property (nonatomic, strong) NSArray<TuWanPicShowitemModel *> *showitem;

@property (nonatomic, copy) NSString *litpic;

@property (nonatomic, copy) NSString *aid;

@property (nonatomic, assign) NSInteger pictotal;

@property (nonatomic, copy) NSString *toutiao;

@property (nonatomic, copy) NSString *pubdate;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *timestamp;

@property (nonatomic, copy) NSString *murl;

@property (nonatomic, copy) NSString *banner;

@property (nonatomic, assign) NSInteger zangs;

@property (nonatomic, copy) NSString *writer;

@property (nonatomic, strong) NSArray<TuWanPicRelevantModel *> *relevant;

@property (nonatomic, copy) NSString *timer;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, strong) NSArray<TuWanPicContentModel *> *content;

@property (nonatomic, copy) NSString *desc;

@end
@interface TuWanPicInfochildModel : NSObject

@property (nonatomic, copy) NSString *later;

@property (nonatomic, copy) NSString *feature;

@property (nonatomic, copy) NSString *facial;

@property (nonatomic, copy) NSString *shoot;

@property (nonatomic, copy) NSString *role;

@property (nonatomic, copy) NSString *cn;

@end

@interface TuWanPicShowitemModel : NSObject

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, strong) TuWanPicShowitemInfoModel *info;

@property (nonatomic, copy) NSString *text;

@end

@interface TuWanPicShowitemInfoModel : NSObject

@property (nonatomic, copy) NSString *width;

@property (nonatomic, assign) NSInteger height;

@end

@interface TuWanPicRelevantModel : NSObject

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *litpic;

@property (nonatomic, copy) NSString *typeName;

@property (nonatomic, copy) NSString *click;

@property (nonatomic, copy) NSString *timestamp;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *color;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *typechild;

@property (nonatomic, copy) NSString *writer;

@property (nonatomic, copy) NSString *aid;

@property (nonatomic, copy) NSString *pubdate;

@end

@interface TuWanPicContentModel : NSObject

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, strong) TuWanPicContentInfoModel *info;

@property (nonatomic, copy) NSString *text;

@end

@interface TuWanPicContentInfoModel : NSObject

@property (nonatomic, copy) NSString *width;

@property (nonatomic, assign) NSInteger height;

@end

