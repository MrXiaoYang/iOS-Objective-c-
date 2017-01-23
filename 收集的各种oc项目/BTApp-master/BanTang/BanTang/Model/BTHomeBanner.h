//
//  BTHomeBanner.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
//
/**
 *  
 index	Integer	91
 title	String	让这个冬天绿意盎然
 extend	String	1533,1241,773,767,561,359
 type	String	topic_list
 photo	String	http://7xiwnz.com2.z0.glb.qiniucdn.com/element1/201511/54100481.jpg?v=1448527206
 */
/**
 *  
 @property (nonatomic, strong, readonly) NSNumber *index;
 @property (nonatomic, copy, readonly) NSString *title;
 @property (nonatomic, copy, readonly) NSString *extend;
 @property (nonatomic, copy, readonly) NSString *type;
 @property (nonatomic, copy, readonly) NSString *photo;
 */
#import <Foundation/Foundation.h>

@interface BTHomeBanner : NSObject


@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *extend;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) NSInteger index;


@end
