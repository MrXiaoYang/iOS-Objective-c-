//
//  BTListPost.h
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BTListPostDynamic,BTSubjectAuthor,BTProduct,BTTag,BTListPostPics;

@interface BTListPost : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *relationId;

@property (nonatomic, copy) NSString *isRecommend;

@property (nonatomic, strong) BTSubjectAuthor *author;

@property (nonatomic, copy) NSString *datestr;

@property (nonatomic, strong) NSArray<BTProduct *> *product;

@property (nonatomic, strong) NSArray<BTTag *> *tags;

@property (nonatomic, strong) BTListPostDynamic *dynamic;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *authorId;

@property (nonatomic, copy) NSString *shareUrl;

@property (nonatomic, copy) NSString *publishTime;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *iTags;

@property (nonatomic, strong) NSArray<BTListPostPics *> *pics;

@property (nonatomic, copy) NSString *content;

@end


