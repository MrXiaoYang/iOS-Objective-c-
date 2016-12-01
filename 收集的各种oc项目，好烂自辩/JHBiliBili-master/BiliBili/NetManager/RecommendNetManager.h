//
//  RecommendNetManager.h
//  BiliBili
//
//  Created by apple-jd44 on 15/10/21.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseNetManager.h"

@interface RecommendNetManager : BaseNetManager
+ (id)getSection:(NSString *)section completionHandler:(void(^)(id responseObj, NSError *error))complete;
+ (id)getHeadImgCompletionHandler:(void(^)(id responseObj, NSError *error))complete;
@end
