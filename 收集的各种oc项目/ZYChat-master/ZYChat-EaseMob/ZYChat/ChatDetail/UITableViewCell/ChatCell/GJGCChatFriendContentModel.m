//
//  GJGCChatFriendContentModel.m
//  ZYChat
//
//  Created by ZYVincent QQ:1003081775 on 14-11-5.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import "GJGCChatFriendContentModel.h"
#import "GJGCChatFriendCellStyle.h"

@implementation GJGCChatFriendContentModel

- (instancetype)init
{
    if (self = [super init]) {
        
        self.isTimeSubModel = NO;
        self.isGroupChat = NO;
        self.audioModel = [[GJCFAudioModel alloc]init];
        self.faildType = 0;
        self.supportImageTagArray = [[NSArray alloc]initWithObjects:@"imageTag", nil];
    }
    return self;
}

- (void)setImageMessageUrl:(NSString *)imageMessageUrl
{
    if ([_imageMessageUrl isEqualToString:imageMessageUrl]) {
        return;
    }
    
    if (GJCFStringIsNull(imageMessageUrl)) {
        _imageMessageUrl = @"";
        return;
    }
    
    if ([imageMessageUrl hasPrefix:@"local_file_"]) {
        
        _imageMessageUrl = nil;
        _imageMessageUrl = [imageMessageUrl copy];
                
    }else{
        
        _imageMessageUrl = nil;
        _imageMessageUrl = [imageMessageUrl copy];
    }
    
}

+ (GJGCChatFriendContentModel *)timeSubModel
{
    GJGCChatFriendContentModel *timeSubModel = [[GJGCChatFriendContentModel alloc]init];
    timeSubModel.isTimeSubModel = YES;
    
    return timeSubModel;
}

- (void)setupUserInfoByExtendUserContent:(GJGCMessageExtendUserModel *)userInfo
{
    self.headUrl = userInfo.headThumb;
    if (self.talkType == GJGCChatFriendTalkTypeGroup) {
        self.senderName = [GJGCChatFriendCellStyle formateGroupChatSenderName:userInfo.nickName];
    }
}

@end
