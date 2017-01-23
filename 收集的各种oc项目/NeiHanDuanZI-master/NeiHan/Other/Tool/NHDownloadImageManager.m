//
//  NHDownloadImageManager.m
//  NeiHan
//
//  Created by Charles on 16/9/8.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDownloadImageManager.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"
#import "YYWebImage.h"
#import "UIImage+Addition.h"

@implementation NHDownloadImageManager

+ (void)downLoadImageWithURL:(NSURL *)URL finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle {
    [self downLoadImageWithURL:URL finishHandle:finishHandle progressHandle:nil];
}

+ (void)downLoadImageWithURL:(NSURL *)URL finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle
              progressHandle:(void(^)(CGFloat progres))progressHandle {
    
    if (URL == nil) {
        return ;
    }
    UIImage *image = [self cacheImageWithURL:URL];
    if (image) {
        if (finishHandle) {
            finishHandle(YES, image);
        }
         
        if (progressHandle) {
            progressHandle(1.0);
        }
        
        return ;
    }
    
//    [yy];
    
//        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:URL options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//    
//            // 处理下载进度
//            if (progressHandle) {
//                progressHandle(receivedSize * 1.0 / expectedSize);
//            }
//        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//            UIImage *newImage = image;
//            if (finishHandle) {
//                finishHandle(finished, newImage);
//            }
//    
//        }];

//    [[YYWebImageManager sharedManager] requestImageWithURL:URL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        if (progressHandle) {
//            progressHandle(receivedSize * 1.0 / expectedSize);
//        }
//    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//        if (finishHandle) {
////            if (([UIImageJPEGRepresentation(image, 1.0) length]) * 1.0 / 1024 / 1024 > 0.1) {
////                image = [image compressImageWithMaxLimit:0.1]; // MB
////            }
//            finishHandle(YES, image);
//        }
//    }];
////
    
}

+ (void)downLoadImageWithUrl:(NSString *)url finishHandle:(void (^)(BOOL, UIImage *finishedImage))finishHandle {
    [self downLoadImageWithUrl:url finishHandle:finishHandle progressHandle:nil];
}
+ (void)downLoadImageWithUrl:(NSString *)url finishHandle:(void(^)(BOOL finished, UIImage *finishedImage))finishHandle
              progressHandle:(void(^)(CGFloat progres))progressHandle {
    
    [self downLoadImageWithURL:[NSURL URLWithString:url] finishHandle:finishHandle progressHandle:progressHandle];
    
}

+ (UIImage *)cacheImageWithUrl:(NSString *)url {
//            SDWebImageManager *manager = [SDWebImageManager sharedManager];
//            NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:url]];
//            SDImageCache* cache = [SDImageCache sharedImageCache];
//            //此方法会先从memory中取。
//           UIImage * image = [cache imageFromDiskCacheForKey:key];
//            return image;
    return [self cacheImageWithURL:[NSURL URLWithString:url]];
}
+ (UIImage *)cacheImageWithURL:(NSURL *)URL {
    //
        if (URL == nil) {
            return nil;
        }
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        NSString* key = [manager cacheKeyForURL:URL];
        SDImageCache* cache = [SDImageCache sharedImageCache];
        //此方法会先从memory中取。
        UIImage * image = [cache imageFromDiskCacheForKey:key];
        return image;
    
//    return [[[YYWebImageManager sharedManager ] cache] getImageForKey:[[YYWebImageManager sharedManager] cacheKeyForURL:URL]];
    
}
@end
