//
//  NHDownloadImageManager.h
//  NeiHan
//
//  Created by Charles on 16/9/8.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NHDownloadImageManager : NSObject

+ (void)downLoadImageWithURL:(NSURL *)URL finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle;
+ (void)downLoadImageWithURL:(NSURL *)URL finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle
              progressHandle:(void(^)(CGFloat progres))progressHandle;

+ (void)downLoadImageWithUrl:(NSString *)url finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle;
+ (void)downLoadImageWithUrl:(NSString *)url finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle
              progressHandle:(void(^)(CGFloat progres))progressHandle;

+ (UIImage *)cacheImageWithUrl:(NSString *)url;
+ (UIImage *)cacheImageWithURL:(NSURL *)URL;
@end
