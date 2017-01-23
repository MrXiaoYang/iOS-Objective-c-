//
//  AppDelegate.m
//  LXZEALER
//
//  Created by Lonely Stone on 15/11/1.
//  Copyright © 2015年 LonelyStone. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchAnimationViewController.h"
#import "LoginViewController.h"
#import "WXApi.h"

#define kAppKey @"1726018880"
#define kRedirectURL @"https://api.weibo.com/oauth2/default.html"
#define kSecretKey @"4709a60e7d0c272f7a517c40fb238b4b"

@interface AppDelegate ()<WXApiDelegate>

@end


static AppDelegate *appdelegate;

@implementation AppDelegate


+ (AppDelegate*)sharedAppdelegate {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        appdelegate = [[AppDelegate alloc] init];
    });
    return appdelegate;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    LaunchAnimationViewController *launchVC = [[LaunchAnimationViewController alloc] init];
    self.window.rootViewController = launchVC;
    
    //输出调试信息
   // [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
    [WXApi registerApp:@"wx8011e108b672eee2" withDescription:@"云石管家"];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if ([response isKindOfClass:[WBSendMessageToWeiboResponse class]]) {
        NSLog(@"返回状态%ld  %@   %@",response.statusCode,response.userInfo,response.requestUserInfo);
    }else if([response isKindOfClass:[WBAuthorizeResponse class]]){
        self.userID = [(WBAuthorizeResponse *)response userID];
        self.access_token = [(WBAuthorizeResponse *)response accessToken];
        self.refresh_token = [(WBAuthorizeResponse *)response refreshToken];
        self.expirationDate = [(WBAuthorizeResponse *)response expirationDate];
        [self refreshUserInfo];
    }
}

- (void)refreshUserInfo{
    NSString * urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@" ,self.access_token,self.userID];
    
    NSData *userInfoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
    
    NSDictionary *userInfoDict = [NSJSONSerialization JSONObjectWithData:userInfoData options:NSJSONReadingAllowFragments error:nil];
    
    NSLog(@"%@",userInfoDict);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WBAuthorSuccessfulNotification" object:nil userInfo:userInfoDict];
    
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp{
    
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *temp=(SendAuthResp*)resp;
        //根据code获取
        [self getAccess_token:temp.code];
    }
}

-(void)getWXCodeStringWithController:(id)vc
{
    //构造SendAuthReq结构体
    SendAuthReq * req =[[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo,snsapi_base,snsapi_contact" ;
    req.state = @"owner";
    
    //第三方向微信终端发送一个SendAuthReq消息结构
    LoginViewController *controller = (LoginViewController*)vc;
    
    [WXApi sendAuthReq:req viewController:controller delegate:self];
}

/**
 *  根据code获取access_token
 *
 *  @param code code
 */
-(void)getAccess_token:(NSString*)code{
    
    NSString *urlStr =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",@"wx8011e108b672eee2",@"52b79fcca9ca43fcc7cd37358c7f3feb",code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if (dic) {
            
            NSString *access_token = [dic objectForKey:@"access_token"];
            NSString *openId = [dic objectForKey:@"openid"];
            
            [self getUserInfoWithAccess_token:access_token andOpenId:openId];
        }
    });
    
}

/**
 *  根据得到的access_token和openid得到用户个人信息
 *
 *  @param access_token_ access_token
 *  @param openId_       openid
 */
-(void)getUserInfoWithAccess_token:(NSString*)access_token_ andOpenId:(NSString*)openId_{
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token_, openId_];
    
    NSURL *zoneUrl=[NSURL URLWithString:url];
    
    //微信第三方登录时必须异步加载
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:zoneUrl];
        
        NSDictionary *userInfoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WXAuthorSuccessfulNotification" object:nil userInfo:userInfoDic];
    });
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    [WXApi handleOpenURL:url delegate:self];
    return [WeiboSDK handleOpenURL:url delegate:self];

}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    [WXApi handleOpenURL:url delegate:self];
    return [WeiboSDK handleOpenURL:url delegate:self];

}
@end
