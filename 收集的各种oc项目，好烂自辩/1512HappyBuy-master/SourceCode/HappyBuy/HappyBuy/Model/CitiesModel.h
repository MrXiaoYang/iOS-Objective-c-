//
//  CitiesModel.h
//  HappyBuy
//
//  Created by jiyingxin on 16/3/30.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CitiesRegionsModel;
@interface CitiesModel : NSObject

@property (nonatomic, copy) NSString *pinYin;

@property (nonatomic, copy) NSString *pinYinHead;

@property (nonatomic, strong) NSArray<CitiesRegionsModel *> *regions;

@property (nonatomic, copy) NSString *name;

@end

@interface CitiesRegionsModel : NSObject

@property (nonatomic, copy) NSString *name;

@end

