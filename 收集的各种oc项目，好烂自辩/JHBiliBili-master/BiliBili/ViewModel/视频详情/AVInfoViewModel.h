//
//  AVItemViewModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/7.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseViewModel.h"
#import "AVInfoNetManager.h"
#import "AVModel.h"
@class episodesModel;
/**
 *  视频详情子项
 */
@interface AVInfoViewModel : BaseViewModel
//相关视频数组
@property (nonatomic, strong) NSMutableArray <sameVideoDataModel*>* sameVideoList;
//回复数组
@property (nonatomic, strong) NSMutableArray <ReplyDataModel*>* replyList;
//tag数组
@property (nonatomic, strong) NSMutableArray <TagDataModel*>* tagList;

//存放视频详情 例如up名 播放数
@property (nonatomic, strong) AVDataModel* AVData;

//相关视频
- (NSURL*)sameVideoPicForRow:(NSInteger)row;
- (NSString*)sameVideoTitleForRow:(NSInteger)row;
- (NSString*)sameVideoPlayNumForRow:(NSInteger)row;
- (NSString*)sameVideoReplyForRow:(NSInteger)row;
- (NSInteger)sameVideoCount;
- (sameVideoDataModel*)sameVideoModelForRow:(NSInteger)row;

//评论
- (NSString*)replyNameForRow:(NSInteger)row;
- (NSURL*)replyIconForRow:(NSInteger)row;
- (NSString*)replyMessageForRow:(NSInteger)row;
- (NSString*)replyTimeForRow:(NSInteger)row;
- (NSString*)replyLVForRow:(NSInteger)row;
- (NSString*)replyGoodForRow:(NSInteger)row;
- (NSString*)replyGenderForRow:(NSInteger)row;
//评论数组个数
- (NSInteger)replyCount;
//总评论个数
- (NSInteger)allReply;

//视频信息
- (NSString*)infoTitle;
- (NSURL*)infoImgURL;
- (NSString*)infoUpName;
- (NSString*)infoPlayNum;
- (NSString*)infoDanMuCount;
- (NSString*)infoTime;

//视频详情
- (NSString*)infoBrief;
- (NSAttributedString*)infoTags;
- (NSString*)videoAid;

//承包商排行
- (NSURL*)investorIconForRow:(NSInteger)row;
- (NSString*)investorNameForRow:(NSInteger)row;
- (NSString*)investorMessageForRow:(NSInteger)row;
- (NSInteger)investorRankForRow:(NSInteger)row;
- (NSInteger)investorCount;

//其它
- (episodesModel*)AVModel2EpisodesModel;

- (void)setAVData:(AVDataModel *)AVData section:(NSString*)section;
//判断是不是新番
- (BOOL)isShiBan;
- (NSString*)videoCid;
- (NSString*)videoTitle;

- (void)refreshDataCompleteHandle:(void(^)(NSError *error))complete;
- (void)getMoveReplyCompleteHandle:(void(^)(NSError *error))complete;
- (void)downLoadVideoWithAidArray:(NSArray*)aidArray CompleteHandle:(void(^)(id responseObj,NSError *error))complete;

@end
