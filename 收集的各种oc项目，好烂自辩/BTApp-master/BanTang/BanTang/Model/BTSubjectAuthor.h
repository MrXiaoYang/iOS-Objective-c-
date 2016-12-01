//
//  BTSubjectAuthor.h
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTSubjectAuthor : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *userCover;

@property (nonatomic, assign) NSInteger isOfficial;
@property (nonatomic, assign) NSInteger attentionType;


@end
