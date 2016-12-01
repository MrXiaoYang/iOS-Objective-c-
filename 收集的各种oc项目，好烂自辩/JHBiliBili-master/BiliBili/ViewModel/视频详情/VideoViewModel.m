//
//  VideoViewModel.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/13.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "VideoViewModel.h"

#import "XML2Dic.h"

#import "DanMuModel.h"

#import "VideoNetManager.h"

@interface VideoViewModel()
@property (nonatomic, strong) NSArray<VideoDataModel*>* list;
@property (nonatomic, strong) NSDictionary<NSNumber*,NSMutableArray<DanMuModel*>*>* danMuDic;
@property (nonatomic, strong) NSString* aid;
@end


@implementation VideoViewModel

- (NSDictionary*)videoDanMu{
    return self.danMuDic;
}
- (NSURL*)videoURL{
    //判断默认设置是否为高清
    NSString* tempStr = [[self firstObj].url componentsSeparatedByString:@":"].firstObject;
    if ([tempStr isEqualToString:@"http"] || [tempStr isEqualToString:@"https"]) {
        return [[[NSUserDefaults standardUserDefaults] stringForKey:@"HightResolution"] isEqualToString:@"yes"]?[NSURL URLWithString:[self firstObj].url]:[NSURL URLWithString:[self firstObj].backup_url.firstObject];
    }else{
        return [NSURL fileURLWithPath:[kDownloadPath stringByAppendingPathComponent:[self firstObj].url]];
    }
}

- (NSString*)videoCid{
    return [self firstObj].cid;
}

- (NSString*)videoTitle{
    return [self firstObj].title;
}

- (VideoDataModel*)firstObj{
    return self.list.firstObject;
}

- (void)refreshDataCompleteHandle:(void(^)(NSError *error))complete{
    //先尝试从本地获取 没有再从网络获取
    
    NSDictionary<NSString*, NSDictionary*>* dic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"downLoad"];
    if (dic[self.aid] != nil) {
        self.list.firstObject.title = dic[self.aid][@"name"];
        self.list.firstObject.url = dic[self.aid][@"url"];
        self.danMuDic = [NSKeyedUnarchiver unarchiveObjectWithFile: [kDownloadPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.danmu",self.aid]]];
        complete(nil);
        return;
    }
    [VideoNetManager GetVideoWithParameter:self.aid completionHandler:^(VideoModel *responseObj, NSError *error) {
        self.list = responseObj.durl;
        [VideoNetManager DownDanMuWithParameter:[self videoCid] completionHandler:^(NSDictionary *responseObj, NSError *error) {
            self.danMuDic = responseObj;
            complete(error);
        }];
    }];
}

- (instancetype)initWithAid:(NSString*)aid{
    if (self = [super init]) {
        self.aid = aid;
    }
    return self;
}

#pragma mark - 懒加载

- (NSArray<VideoDataModel *> *)list{
    if (_list == nil) {
        _list = @[[[VideoDataModel alloc]init]];
    }
    return _list;
}

- (NSDictionary<NSNumber *,NSMutableArray<DanMuModel *> *> *)danMuDic{
    if (_danMuDic == nil) {
        _danMuDic = [NSMutableDictionary dictionary];
    }
    return _danMuDic;
}

@end

