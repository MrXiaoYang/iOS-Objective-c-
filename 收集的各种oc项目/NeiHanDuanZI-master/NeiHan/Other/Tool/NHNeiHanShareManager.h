//
//  NHNeiHanShareManager.h
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  三方类型
 */
typedef NS_ENUM(NSUInteger, NHNeiHanShareType) {
    /** QQ*/
    NHNeiHanShareTypeQQ = 1,
    /** QQ空间*/
    NHNeiHanShareTypeQZone,
    /** 微信会话*/
    NHNeiHanShareTypeWechatSession,
    /** 微信朋友圈*/
    NHNeiHanShareTypeWechat,
    /** 微博*/
    NHNeiHanShareTypeWeibo,
};
@interface NHNeiHanShareManager : NSObject

+ (instancetype)sharedManager;

- (void)shareWithSharedType:(NHNeiHanShareType)shareType
                      image:(UIImage *)image
                        url:(NSString *)url
                    content:(NSString *)content
                 controller:(UIViewController *)controller;

- (void)registerAllPlatForms;

@end
