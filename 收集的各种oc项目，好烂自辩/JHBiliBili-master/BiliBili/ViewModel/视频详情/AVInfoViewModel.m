//
//  AVItemViewModel.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/7.
//  Copyright © 2015年 JimHuang. All rights reserved.
//


#import "AVInfoNetManager.h"
#import "VideoNetManager.h"

#import "ShinBanInfoModel.h"
#import "DanMuModel.h"

#import "AVInfoViewModel.h"

#import "NSString+Tools.h"

@interface AVInfoViewModel ()
////新番独有属性
////承包商数组
@property (nonatomic, strong) NSMutableArray <InvestorDataModel*>* investorList;

@property (nonatomic, strong) NSString* section;

@property (nonatomic, assign) NSInteger allReplyCount;
@end

@implementation AVInfoViewModel
//相关视频
- (NSURL*)sameVideoPicForRow:(NSInteger)row{
    return [NSURL URLWithString:self.sameVideoList[row].pic];
}
- (NSString*)sameVideoTitleForRow:(NSInteger)row{
    return self.sameVideoList[row].title;
}
- (NSString*)sameVideoPlayNumForRow:(NSInteger)row{
    return [NSString stringWithFormatNum:self.sameVideoList[row].click];
}
- (NSString*)sameVideoReplyForRow:(NSInteger)row{
    return [NSString stringWithFormatNum:self.sameVideoList[row].dm_count];
}

- (sameVideoDataModel*)sameVideoModelForRow:(NSInteger)row{
    return self.sameVideoList[row];
}

- (NSInteger)sameVideoCount{
    return self.sameVideoList.count;
}

//评论
- (NSString*)replyNameForRow:(NSInteger)row{
    return self.replyList[row].nick;
}
- (NSURL*)replyIconForRow:(NSInteger)row{
    return [NSURL URLWithString: self.replyList[row].face];
}
- (NSString*)replyMessageForRow:(NSInteger)row{
    return self.replyList[row].msg;
}
- (NSString*)replyTimeForRow:(NSInteger)row{
    return self.replyList[row].create_at;
}
- (NSString*)replyLVForRow:(NSInteger)row{
    return [NSString stringWithFormat:@"#%ld", (long)self.replyList[row].lv];
}
- (NSString*)replyGoodForRow:(NSInteger)row{
    return [NSString stringWithFormatNum:self.replyList[row].good];
}
- (NSString*)replyGenderForRow:(NSInteger)row{
    return self.replyList[row].sex;
}
- (NSInteger)replyCount{
    return self.replyList.count;
}
- (NSInteger)allReply{
    return self.allReplyCount;
}


- (NSAttributedString*)infoTags{
    NSDictionary* textAtt =  @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSForegroundColorAttributeName: [[ColorManager shareColorManager] colorWithString:@"themeColor"]};
    
    NSMutableAttributedString* mstr = [[NSMutableAttributedString alloc] initWithString:@"" attributes:textAtt];
    [self.tagList enumerateObjectsUsingBlock:^(TagDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [mstr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",obj.name,(idx == self.tagList.count - 1)?@"":@","] attributes:textAtt]];
        [mstr appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    }];
    return [mstr copy];
}


//视频信息
- (NSString*)infoTitle{
    return self.AVData.title;
}
- (NSURL*)infoImgURL{
    return [NSURL URLWithString: self.AVData.pic];
}
- (NSString*)infoUpName{
    return self.AVData.author;
}
- (NSString*)infoPlayNum{
    return [NSString stringWithFormatNum:self.AVData.play];
}
- (NSString*)infoDanMuCount{
    return self.AVData.video_review >= 0?[NSString stringWithFormatNum: self.AVData.video_review]:nil;
}
- (NSString*)infoTime{
    return self.AVData.create;
}

//视频aid
- (NSString*)videoAid{
    return self.AVData.aid;
}
//视频cid
- (NSString*)videoCid{
    return self.AVData.cid;
}
//视频标题
- (NSString*)videoTitle{
    return self.AVData.title;
}
//视频详情
- (NSString*)infoBrief{
    return self.AVData.desc;
}

//其它
- (episodesModel*)AVModel2EpisodesModel{
    episodesModel* model = [[episodesModel alloc] init];
    model.index = [self infoTitle];
    model.av_id = [self videoAid];
    model.av_cid = [self videoCid];
    model.index_title = [self videoTitle];
    return model;
}


//承包商排行
- (NSURL*)investorIconForRow:(NSInteger)row{
    return [NSURL URLWithString:self.investorList[row].face];
}
- (NSString*)investorNameForRow:(NSInteger)row{
    return self.investorList[row].uname;
}
- (NSString*)investorMessageForRow:(NSInteger)row{
    return self.investorList[row].message;
}

- (NSInteger)investorCount{
    return self.investorList.count;
}

- (NSInteger)investorRankForRow:(NSInteger)row{
    return self.investorList[row].rank;
}

- (BOOL)isShiBan{
    return [self.section isEqualToString:@"13-3day.json"];
}


#define pagesize @20
#define page @1

- (void)refreshDataCompleteHandle:(void(^)(NSError *error))complete{
    NSMutableArray<AFHTTPRequestOperation*>* arr = [NSMutableArray array];
    NSString *aid = [self videoAid];
    if (!aid) {
        complete(nil);
        return;
    }
    
    //评论请求
    [arr addObject:[AVInfoNetManager GetReplyWithParameter:@{@"pagesize":pagesize.stringValue, @"page":page.stringValue, @"aid": aid} completionHandler:^(ReplyModel* responseObj, NSError *error) {
        self.replyList = [responseObj.list mutableCopy];
        self.allReplyCount = responseObj.results;
    }]];
    //相似视频请求
    [arr addObject:[AVInfoNetManager GetSameVideoWithParameter:aid completionHandler:^(sameVideoModel* responseObj, NSError *error) {
        self.sameVideoList = [responseObj.list mutableCopy];
    }]];
    //新番的情况下 增加一个承包商请求
    if ([self isShiBan]) {
        [arr addObject: [AVInfoNetManager GetInverstorWithParameter:@{@"aid":aid} completionHandler:^(InvestorModel* responseObj, NSError *error) {
            self.investorList = [responseObj.list mutableCopy];
        }]];
    }
    //tag请求
    [arr addObject: [AVInfoNetManager GetTagWithParameter:@{@"aid":aid} completionHandler:^(TagModel* responseObj, NSError *error) {
        self.tagList = [responseObj.result mutableCopy];
    }]];
    //视频cid请求
    [arr addObject: [VideoNetManager GetCIDWithParameter:aid completionHandler:^(id responseObj, NSError *error) {
        self.AVData.cid = [CIDModel mj_objectWithKeyValues:[NSJSONSerialization json2DicWithData: responseObj]].list.firstObject.CID;
    }]];
    
    NSArray* operations = [AFURLConnectionOperation batchOfRequestOperations:arr progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
    } completionBlock:^(NSArray *operations) {
        complete(nil);
    }];
    [[NSOperationQueue mainQueue] addOperations:@[operations.lastObject] waitUntilFinished:NO];
    
}

/*
 下拉获取更多评论方法
 */
- (void)getMoveReplyCompleteHandle:(void(^)(NSError *error))complete{
    [AVInfoNetManager GetReplyWithParameter:@{@"pagesize":pagesize.stringValue, @"page":@([self replyCount] / pagesize.intValue + 1), @"aid":[self videoAid]} completionHandler:^(ReplyModel* responseObj, NSError *error) {
        [self.replyList addObjectsFromArray:responseObj.list];
        self.allReplyCount = responseObj.results;
        complete(error);
    }];
}

/*
 下载视频方法
 */
- (void)downLoadVideoWithAidArray:(NSArray*)aidArray CompleteHandle:(void(^)(id responseObj,NSError *error))complete{
    //请求下载队列
    NSMutableArray<AFHTTPRequestOperation*>* arr = [NSMutableArray array];
    
    [aidArray enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull dicObj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [arr addObject: [VideoNetManager GetVideoPathWithCid:dicObj[@"cid"] Aid:dicObj[@"aid"] title:dicObj[@"title"] completionHandler:^(VideoModel* vmObj, NSError *error) {
            NSString* archName = [NSString stringWithFormat:@"%@.arch",vmObj.durl.firstObject.cid];
            //归档VideoModel对象
            [ArchiverObj archiveWithObj:vmObj path: [kArchPath stringByAppendingPathComponent: archName]];
            //把视频信息写入userDefault
            [[UserDefaultDownLoadManager shareDownLoadManager] updateDownLoadDicWithKey:dicObj[@"aid"] Obj: @{@"aid":dicObj[@"aid"],@"status":@"downsuspand",@"index": @(idx), @"name": vmObj.durl.firstObject.title,@"vmpath": archName,@"quality":dicObj[@"quality"],@"cid":vmObj.durl.firstObject.cid}];
        }]];
        
    }];
    
    NSArray* operations = [AFURLConnectionOperation batchOfRequestOperations:arr progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations){
        NSLog(@"%lu,%lu", (unsigned long)numberOfFinishedOperations, (unsigned long)totalNumberOfOperations);
        //参数获取完成后 自动下载第一个视频
    } completionBlock:^(NSArray *operations){
        //显示成功信息
        complete(nil,nil);
        NSDictionary* downDic = [UserDefaultDownLoadManager shareDownLoadManager].downLoadDic;
        
        [downDic enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, NSDictionary*  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj[@"index"] isEqualToNumber: @(0)]) {
                [self autoDownLoadNextVideoWithIndex: @(0)];
                *stop = YES;
            }
        }];
        
    }];
    [[NSOperationQueue mainQueue] addOperations:@[operations.lastObject] waitUntilFinished: NO];
    
}


#pragma mark - 初始化
- (void)setAVData:(AVDataModel *)AVData section:(NSString*)section{
    self.AVData = AVData;
    self.section = section;
}

#pragma mark - 私有方法
- (void)autoDownLoadNextVideoWithIndex:(NSNumber*)index{
    NSDictionary* downDic = [UserDefaultDownLoadManager shareDownLoadManager].downLoadDic;
    
    [downDic enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, NSDictionary*  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj[@"index"] isEqualToNumber: index]){
            //找到要下载的对象 解档
            VideoModel* model = [NSKeyedUnarchiver unarchiveObjectWithFile:[kArchPath stringByAppendingPathComponent: obj[@"vmpath"]]];
            //更新状态
            NSMutableDictionary* MDic = [obj mutableCopy];
            MDic[@"status"] = @"downloading";
            [[UserDefaultDownLoadManager shareDownLoadManager] updateDownLoadDicWithKey:key Obj:MDic];
            
            [AVInfoNetManager DownVideoWithDic:@{@"aid": key, @"vm":model, @"quality":obj[@"quality"]} completionHandler:^(NSDictionary* responseObj, NSError *error) {
                //                下载完成 下载信息写入userDefault
                [ArchiverObj archiveWithObj:responseObj[@"danmuobj"] path: [kDownloadPath stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.arch", obj[@"cid"]]]];
                MDic[@"status"] = responseObj[@"status"];
                MDic[@"videopath"] = responseObj[@"videopath"];
                [[UserDefaultDownLoadManager shareDownLoadManager] updateDownLoadDicWithKey:key Obj:MDic];
                //判断是否有下个任务 有的话 自动下载
                [self autoDownLoadNextVideoWithIndex: @(index.intValue + 1)];
            }];
            
            *stop = YES;
            //所有任务下载完成
        }else if(index.intValue >= downDic.count){
            return;
        }
    }];
    
}

#pragma mark - 懒加载
- (NSMutableArray<sameVideoDataModel *> *)sameVideoList{
    if (_sameVideoList == nil) {
        _sameVideoList = [NSMutableArray array];
    }
    return _sameVideoList;
}

- (NSMutableArray<ReplyDataModel *> *)replyList{
    if (_replyList == nil) {
        _replyList = [NSMutableArray array];
    }
    return _replyList;
}

- (NSMutableArray<TagDataModel *> *)tagList{
    if (_tagList == nil) {
        _tagList = [NSMutableArray array];
    }
    return _tagList;
}

- (AVDataModel *)AVData{
    if (_AVData == nil) {
        _AVData = [AVDataModel new];
    }
    return _AVData;
}

- (NSMutableArray<InvestorDataModel *> *)investorList{
    if (_investorList == nil) {
        _investorList = [NSMutableArray array];
    }
    return _investorList;
}


@end
