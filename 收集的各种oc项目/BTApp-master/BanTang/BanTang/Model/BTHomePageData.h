//
//  BTHomePageData.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTHomePageData : NSObject

@property (nonatomic, strong) NSArray *topic;
@property (nonatomic, strong) NSArray *categoryElement;
@property (nonatomic, strong) NSArray *firstpageElement;
@property (nonatomic, copy) NSString *today;
@property (nonatomic, strong) NSArray *entryList;
@property (nonatomic, copy) NSString *dateline;
@property (nonatomic, strong) NSNumber *signEntry;
@property (nonatomic, assign) BOOL isBaichuan;
@property (nonatomic, strong) NSArray *banner;

@end
