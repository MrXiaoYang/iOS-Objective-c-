//
//  BTRedSopt.h
//  BanTang
//
//  Created by 沈文涛 on 15/12/6.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BTBadgeNotice;

@interface BTRedSpot : NSObject

@property (nonatomic, strong, readonly) NSArray *element;

@property (nonatomic, strong, readonly) BTBadgeNotice *badgeNotice;

@property (nonatomic, strong, readonly) BTBadgeNotice *systemNotice;

@property (nonatomic, strong, readonly) BTBadgeNotice *commentNotice;

@property (nonatomic, strong, readonly) BTBadgeNotice *rewardsNotice;

@property (nonatomic, strong, readonly) BTBadgeNotice *atNotice;

@property (nonatomic, strong, readonly) BTBadgeNotice *fansNotice;

@property (nonatomic, strong, readonly) BTBadgeNotice *likesNotice;
@end

@interface BTBadgeNotice : NSObject

@property (nonatomic, assign, readonly) NSInteger status;

@property (nonatomic, assign, readonly) NSInteger number;

@end