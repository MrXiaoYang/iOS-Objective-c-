//
//  BTMessageNotice.h
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTMessageNotice : NSObject

@property (nonatomic, copy) NSString *msgContent;

@property (nonatomic, copy) NSString *msgId;

@property (nonatomic, copy) NSString *srcUserAvatar;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *typeId;

@property (nonatomic, copy) NSString *msgUrl;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *srcUserName;

@property (nonatomic, copy) NSString *datestr;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *srcUserId;

@end
