//
//  VideoViewModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/13.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseViewModel.h"
#import "VideoNetManager.h"
@interface VideoViewModel : BaseViewModel


- (instancetype)initWithAid:(NSString*)aid;

- (NSDictionary*)videoDanMu;
- (NSURL*)videoURL;
- (NSString*)videoTitle;

- (void)refreshDataCompleteHandle:(void(^)(NSError *error))complete;
@end
