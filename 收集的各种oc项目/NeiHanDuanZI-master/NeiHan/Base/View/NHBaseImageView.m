//
//  NHBaseImageView.m
//  NeiHan
//
//  Created by Charles on 16/9/8.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseImageView.h"
#import "YYWebImage.h"
#import "YYWebImageManager.h"
#import "UIImage+Addition.h"
#import "NHDownloadImageManager.h"

@implementation NHBaseImageView

- (void)setImageWithUrl:(NSString *)url {
    [self setImageWithUrl:url placeHolder:nil];
}
- (void)setImageWithURL:(NSURL *)URL {
    [self setImageWithURL:URL placeHolder:nil];
}

- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image {
    [self setImageWithUrl:url placeHolder:image finishHandle:nil];
}
- (void)setImageWithURL:(NSURL *)URL placeHolder:(UIImage *)image {
    [self setImageWithURL:URL placeHolder:image finishHandle:nil];
}

- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle {
    [self setImageWithUrl:url placeHolder:image progressHandle:nil finishHandle:finishHandle];
}
- (void)setImageWithURL:(NSURL *)URL placeHolder:(UIImage *)image finishHandle:(void (^)(BOOL, UIImage *))finishHandle {
    [self setImageWithURL:URL placeHolder:image progressHandle:nil finishHandle:finishHandle];
}

- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image progressHandle:(void(^)(CGFloat progress))progressHandle finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle {
    [self setImageWithURL:[NSURL URLWithString:url] placeHolder:image progressHandle:progressHandle finishHandle:finishHandle];
}
- (void)setImageWithURL:(NSURL *)URL placeHolder:(UIImage *)image progressHandle:(void(^)(CGFloat progress))progressHandle finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle {

    [self yy_setImageWithURL:URL placeholder:image options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progressHandle) {
            progressHandle(receivedSize * 1.0 / expectedSize);
        }
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (finishHandle) {
            finishHandle(error == nil, image);
        }
    }];
}
@end
