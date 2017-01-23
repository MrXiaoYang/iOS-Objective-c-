//
//  BTHomeTopic.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
/**
 *  
 tags	String	支架,数码
 id	String	1565
 title	String	数码产品支架升级指南
 update_time	String	1448542801
 islike	Boolean	false
 likes	String	1428
 pic	String	http://bt.img.17gwx.com/topic/0/15/c1RYYQ/730x280
 type	String	0
 */

#import <Foundation/Foundation.h>

@interface BTHomeTopic : NSObject
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, assign) NSInteger tid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, assign) BOOL islike;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *type;
@end
