//
//  RCDataBaseManager.h
//  RCloudMessage
//
//  Created by 杜立召 on 15/6/3.
//  Copyright (c) 2015年 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BTHomePageData,BTHomeBanner;
@interface BTDataBaseManager : NSObject

+ (BTDataBaseManager*)shareInstance;

/** 插入homePageData */
- (void)insertHomePageDataToDB:(BTHomePageData *)pageData page:(NSInteger)page;
/** 获取homePageData */
- (BTHomePageData *)getPageDataWithPage:(NSInteger)page;

/** 插入bannerData */
- (void)inserthomeBannerDataToDB:(NSArray *)pageDataArray;
/** 获取bannerData */
- (NSArray *)getbannerData;

@end
