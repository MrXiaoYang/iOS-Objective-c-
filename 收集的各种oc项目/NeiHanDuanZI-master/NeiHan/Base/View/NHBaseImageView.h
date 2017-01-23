//
//  NHBaseImageView.h
//  NeiHan
//
//  Created by Charles on 16/9/8.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYAnimatedImageView.h"

@interface NHBaseImageView : YYAnimatedImageView
/** 设置图片*/
- (void)setImageWithUrl:(NSString *)url;
- (void)setImageWithURL:(NSURL *)URL;

/** 设置图片*/
- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image;
- (void)setImageWithURL:(NSURL *)URL placeHolder:(UIImage *)image;

/** 设置图片*/
- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle;
- (void)setImageWithURL:(NSURL *)URL placeHolder:(UIImage *)image finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle;

/** 设置图片*/
- (void)setImageWithUrl:(NSString *)url placeHolder:(UIImage *)image progressHandle:(void(^)(CGFloat progress))progressHandle finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle;
- (void)setImageWithURL:(NSURL *)URL placeHolder:(UIImage *)image progressHandle:(void(^)(CGFloat progress))progressHandle finishHandle:(void(^)(BOOL finished, UIImage *image))finishHandle;
@end

