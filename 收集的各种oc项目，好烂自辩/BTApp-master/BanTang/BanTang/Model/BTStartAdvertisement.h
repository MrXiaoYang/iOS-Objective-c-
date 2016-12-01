//
//  BTStartAdvertisement.h
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTStartAdvertisement : NSObject

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, assign) BOOL skipShow;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, assign) NSInteger adTime;

@property (nonatomic, copy) NSString *adUrl;

@end
