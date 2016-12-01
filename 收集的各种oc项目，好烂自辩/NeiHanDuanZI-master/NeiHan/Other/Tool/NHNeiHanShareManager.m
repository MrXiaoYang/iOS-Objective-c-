//
//  NHNeiHanShareManager.m
//  NeiHan
//
//  Created by Charles on 16/9/7.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHNeiHanShareManager.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentApiInterface.h>

static NHNeiHanShareManager *_singleton = nil;

@implementation NHNeiHanShareManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[self alloc] init];
    });
    return _singleton;
}

- (void)registerAllPlatForms {
    
    [UMSocialData setAppKey:@"57cfeda567e58e275c00102d"];
    //设置微信AppId、appSecret，分享url
    [UMSocialData openLog:YES];
    [UMSocialWechatHandler setWXAppId:@"wxc01464912319f82e" appSecret:@"a899820621ce623d835c4caf9381762d" url:@"http://www.jianshu.com/users/3930920b505b/latest_articles"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.jianshu.com/users/3930920b505b/latest_articles"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                              secret:@"04b48b094faeb16683c32669824ebdad"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

- (void)shareWithSharedType:(NHNeiHanShareType)shareType
                      image:(UIImage *)image
                        url:(NSString *)url
                    content:(NSString *)content
                 controller:(UIViewController *)controller {
    switch (shareType) {
        case NHNeiHanShareTypeWechatSession: {
            if (![WXApi isWXAppInstalled]) {
//                [MBProgressHUD showMessage:@"微信没有安装,请先安装微信" toView:controller.view];
                return ;
            }
//            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
            UMSocialUrlResource *resource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:@"http://www.jianshu.com/users/3930920b505b/latest_articles"];
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:content image:[UIImage imageNamed:@"digupicon_review_press_1"] location:nil urlResource:resource presentedController:controller completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    [self shareSucceed];
                    NSLog(@"分享成功！");
                }
            }];
        } break;
        case NHNeiHanShareTypeWechat: {
            if (![WXApi isWXAppInstalled]) {
//                [MBProgressHUD showMessage:@"微信没有安装,请先安装微信" toView:controller.view];
                return ;
            }
            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
            UMSocialUrlResource *resource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:url];
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:content image:image location:nil urlResource:resource presentedController:controller completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    [self shareSucceed];
                    NSLog(@"分享成功！");
                }
            }];
        }  break;
        case NHNeiHanShareTypeWeibo: {
            if (![WeiboSDK isWeiboAppInstalled]) {
//                [MBProgressHUD showMessage:@"微博没有安装,请先安装微博" toView:controller.view];
                return ;
            }
            UMSocialUrlResource *resource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:url];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:content image:image location:nil urlResource:resource presentedController:controller completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                    [self shareSucceed];
                    NSLog(@"分享成功！");
                }
            }];
        } break;
        case NHNeiHanShareTypeQQ: {
            if (![TencentApiInterface isTencentAppInstall:kIphoneQQ]) {
//                [MBProgressHUD showMessage:@"QQ没有安装,请先安装QQ" toView:controller.view];
                return ;
            }
            [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
            UMSocialUrlResource *resource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:url];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:content image:image location:nil urlResource:resource presentedController:controller completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    [self shareSucceed];
                    NSLog(@"分享成功！");
                }
            }];
        } break;
        case NHNeiHanShareTypeQZone: {
            if (![TencentApiInterface isTencentAppInstall:kIphoneQQ]) {
//                [MBProgressHUD showMessage:@"QQ没有安装,请先安装QQ" toView:controller.view];
                return ;
            }
            [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
            UMSocialUrlResource *resource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:url];
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQzone] content:content image:image location:nil urlResource:resource presentedController:controller completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    [self shareSucceed];
                    NSLog(@"分享成功！");
                }
            }];
        } break;
        default:
            break;
    }
    image = nil;
}

- (void)shareSucceed {
    
}

@end
