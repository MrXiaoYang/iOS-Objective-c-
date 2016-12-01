//
//  VideoModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/13.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseModel.h"
@class CIDDataModel;
@class VideoDataModel;

@interface VideoModel : BaseModel
@property (nonatomic, strong) NSMutableArray<VideoDataModel*>* durl;
@end

@interface VideoDataModel : BaseModel
//视频长度
//@property (nonatomic, assign)NSInteger length;
@property (nonatomic, strong)NSString* url;
@property (nonatomic, strong)NSString* cid;
@property (nonatomic, strong)NSString* title;
@property (nonatomic, strong)NSArray<NSString*>* backup_url;
@end

@interface CIDModel : BaseModel
@property (nonatomic, strong) NSArray<CIDDataModel*>* list;
@end

@interface CIDDataModel : BaseModel
//@property (nonatomic, strong)NSString* Mp3Url;
//@property (nonatomic, strong)NSNumber* Mp3Click;
//@property (nonatomic, strong)NSNumber* Mp3Length;
//@property (nonatomic, strong)NSNumber* Mp4Click;
//@property (nonatomic, strong)NSString* Mp4Url;
//@property (nonatomic, assign)NSInteger Mp4Length;
//@property (nonatomic, strong)NSNumber* size;
//@property (nonatomic, strong)NSNumber* P;
@property (nonatomic, strong)NSString* AV;
@property (nonatomic, strong)NSString* Title;
@property (nonatomic, strong)NSString* CID;

@end

