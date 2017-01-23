//
//  BTCategoryElement.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
/**
 *  
 index	Integer	100
 title	String	折扣大全
 extend	String	1298,1303,1306,1314,1308,1357,1339,1320,1323,1311,1307,1360,1295,1312,1319,1330,1300,1367,1348
 type	String	topic_list
 photo	String
 */

#import <Foundation/Foundation.h>

@interface BTCategoryElement : NSObject

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *extend;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *photo;

@end
