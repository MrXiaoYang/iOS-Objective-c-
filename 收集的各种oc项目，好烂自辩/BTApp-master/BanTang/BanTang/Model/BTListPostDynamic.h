//
//  BTListPostDynamic.h
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTListPostDynamic : NSObject

@property (nonatomic, copy) NSString *comments;

@property (nonatomic, strong) NSArray *likesUsers;

@property (nonatomic, assign) BOOL isComment;

@property (nonatomic, copy) NSString *praises;

@property (nonatomic, copy) NSString *views;

@property (nonatomic, copy) NSString *likes;

@property (nonatomic, assign) BOOL isCollect;

@end
