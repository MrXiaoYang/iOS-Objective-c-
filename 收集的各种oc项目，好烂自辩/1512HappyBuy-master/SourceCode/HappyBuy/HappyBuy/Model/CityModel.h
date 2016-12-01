//
//  CityModel.h
//  HappyBuy
//
//  Created by jiyingxin on 16/3/30.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

@property (nonatomic, assign) BOOL isOpen;

@property (nonatomic, copy) NSString *pinyin;
//id -> ID
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) CGFloat lat;

@property (nonatomic, assign) CGFloat lng;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *divisionStr;

@end
