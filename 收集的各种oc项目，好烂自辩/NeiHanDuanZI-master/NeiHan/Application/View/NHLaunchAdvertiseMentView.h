//
//  NHLaunchAdvertiseMentView.h
//  NeiHan
//
//  Created by Charles on 16/9/6.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NHLaunchAdvertiseMentViewCancelHandle)();
typedef void(^NHLaunchAdvertiseMentViewDownloadHandle)();

@interface NHLaunchAdvertiseMentView : UIView

@property (nonatomic, copy) NSString *imgUrl;

- (void)setUpLaunchAdvertiseMentViewCancelHandle:(NHLaunchAdvertiseMentViewCancelHandle)cancelHandle;

- (void)setUpLaunchAdvertiseMentViewDownloadHandle:(NHLaunchAdvertiseMentViewDownloadHandle)downloadHandle;
@end
