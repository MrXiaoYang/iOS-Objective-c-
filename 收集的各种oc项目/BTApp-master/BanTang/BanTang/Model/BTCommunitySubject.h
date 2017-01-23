//
//  ESSubject.h
//  BWDApp
//
//  Created by Ryan on 15/11/27
//  Copyright (c) Flinkinfo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BTSubjectDynamic,BTSubjectAuthor;

@interface BTCommunitySubject : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *pic1;
/** header图片 */
@property (nonatomic, copy) NSString *pic2;

@property (nonatomic, strong) BTSubjectAuthor *author;

@property (nonatomic, strong) BTSubjectDynamic *dynamic;

@property (nonatomic, copy) NSString *datestr;

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, copy) NSString *startTime;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *rankShareUrl;

@property (nonatomic, copy) NSString *authorId;

@property (nonatomic, copy) NSString *shareUrl;

@property (nonatomic, copy) NSString *isRecommend;

@end