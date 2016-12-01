//
//  NHBaseRequest.h
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NHBaseRequestReponseDelegate <NSObject>
@required
/** 如果不用block返回数据的话，这个方法必须实现*/
- (void)requestSuccessReponse:(BOOL)success response:(id)response message:(NSString *)message;
@end

typedef void(^NHAPIDicCompletion)(id response, BOOL success, NSString *message);
@interface NHBaseRequest : NSObject

@property (nonatomic, weak) id <NHBaseRequestReponseDelegate> nh_delegate;
/** 链接*/
@property (nonatomic, copy) NSString *nh_url;
/** 默认GET*/
@property (nonatomic, assign) BOOL nh_isPost;
/** 图片数组*/
@property (nonatomic, strong) NSArray <UIImage *>*nh_imageArray;

/** 构造方法*/
+ (instancetype)nh_request;
+ (instancetype)nh_requestWithUrl:(NSString *)nh_url;
+ (instancetype)nh_requestWithUrl:(NSString *)nh_url isPost:(BOOL)nh_isPost;
+ (instancetype)nh_requestWithUrl:(NSString *)nh_url isPost:(BOOL)nh_isPost delegate:(id <NHBaseRequestReponseDelegate>)nh_delegate;

/** 开始请求，如果设置了代理，不需要block回调*/
- (void)nh_sendRequest;
/** 开始请求，没有设置代理，或者设置了代理，需要block回调，block回调优先级高于代理*/
- (void)nh_sendRequestWithCompletion:(NHAPIDicCompletion)completion;

@end
