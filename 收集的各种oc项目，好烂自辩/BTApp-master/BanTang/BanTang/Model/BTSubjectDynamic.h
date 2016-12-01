//
//  BTSubjectDynamic.h
//  BWDApp
//
//  Created by Ryan on 15/11/27
//  Copyright (c) Flinkinfo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BTSubjectRankAuthor,BTSubjectAuthor;

@interface BTSubjectDynamic : NSObject

@property (nonatomic, copy) NSString *partInNum;

@property (nonatomic, strong) NSArray<BTSubjectRankAuthor *> *rankList;

@property (nonatomic, strong) BTSubjectAuthor *currentUser;

@end