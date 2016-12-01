//
//  BTPlatformInfo.h
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTPlatformInfo : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *channel;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger isDefault;

@property (nonatomic, copy) NSString *icon;

@end
