//
//  BTProduct.h
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BTProductPic,BTProductLiker;

@interface BTProduct : NSObject

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *categoryId;

@property (nonatomic, copy) NSString *platform;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *itemId;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) BOOL islike;

@property (nonatomic, assign) BOOL iscomments;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, strong) NSArray *picArray;

@property (nonatomic, strong) NSArray *likesList;

@property (nonatomic, copy) NSString *comments;

@property (nonatomic, copy) NSString *likes;

@end

@interface BTProductPic : NSObject
/** 宽 */
@property (nonatomic, assign) NSInteger w;
/** 高 */
@property (nonatomic, assign) NSInteger h;
/** url地址 */
@property (nonatomic, copy) NSString *p;
@end

@interface BTProductLiker : NSObject
/** userId */
@property (nonatomic, assign) NSInteger u;
/** 头像url */
@property (nonatomic, copy) NSString *a;
@end
