//
//  AppDelegate.m
//  HappyBuy
//
//  Created by jiyingxin on 16/3/28.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "AppDelegate.h"
//必须引入到.m文件中
#import "PlistDataManager.h"

@interface AppDelegate ()
@end
@implementation AppDelegate
#pragma mark - UIApplication Delegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //调用分类中的定位相关方法
    [self setupLocation];
    [self setupGlobalConfig];
    return YES;
}

@end


/*
 [PlistDataManager getCategories:^(NSArray<CategoriesModel *> *categories, NSError *error) {
 NSLog(@"");
 }];
 
 [PlistDataManager getSorts:^(NSArray<SortsModel *> *sorts, NSError *error) {
 NSLog(@"");
 }];
 
 [PlistDataManager getPortalSettings:^(PortalSettingsModel *portalSettings, NSError *error) {
 NSLog(@"");
 }];
 
 [PlistDataManager getMineInfomationData:^(NSArray<MineInformationDataModel *> *mineInformationData, NSError *error) {
 NSLog(@"");
 }];
 
 [PlistDataManager getCityGroups:^(NSArray<CityGroupsModel *> *cityGroups, NSError *error) {
 NSLog(@"");
 }];
 
 [PlistDataManager getCityData:^(NSArray<CityDataModel *> *cityData, NSError *error) {
 NSLog(@"");
 }];
 
 [PlistDataManager getCity:^(NSArray<CityModel *> *cityList, NSError *error) {
 NSLog(@"");
 }];
 
 [PlistDataManager getCityDict:^(CityDictModel *cityDict, NSError *error) {
 NSLog(@"");
 }];
 
 [PlistDataManager getMenuData:^(NSArray<MenuDataModel *> *menuData, NSError *error) {
 NSLog(@"");
 }];
 
 //    NSArray *cities = [NSArray arrayWithContentsOfFile:[self pathForPlist:@"sorts"]];
 //    NSArray *ddd = [SortsModel parseJSON:cities];
 //    NSLog(@"%@", [cities jsonStringEncoded]);
 //    NSLog(@"");
 /*
 //解析categories.plist
 //目的:生成解析类 缺少JSON字符串
 //有:plist文件 -> 读出NSArray ->?->JSON
 //1: 使用NSArray读出plist文件内容
 NSString *categoriesPlistPath = [[NSBundle mainBundle] pathForResource:@"categories" ofType:@"plist"];
 NSArray *categories = [NSArray arrayWithContentsOfFile:categoriesPlistPath];
 //NSLog(@"%@", [categories jsonStringEncoded]);
 //JSON的根类型是数组的
 //NSArray *modelList = [NSArray modelArrayWithClass:[CategoriesModel class] json: [categories jsonStringEncoded]];
 NSArray *modelList = [CategoriesModel parseJSON:categories];
 NSLog(@"%@", modelList);
 */

/*
 NSString *adSlotURL = @"http://www.quanmin.tv/json/page/ad-slot/info.json";
 [NSObject GET:adSlotURL parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
 SlotModel *model = [SlotModel modelWithJSON:responseObj];
 NSLog(@"%@", model);
 }];
 */
/* 搜索团购制作完毕
 NSString *dealURL = @"http://api.dianping.com/v1/deal/find_deals?appkey=4123794720&sign=7C37F212429FE883374285F7E57FC0584558D784&city=%E4%B8%8A%E6%B5%B7&region=%E9%95%BF%E5%AE%81%E5%8C%BA&category=%E7%BE%8E%E9%A3%9F&limit=3&page=1";
 [NSObject GET:dealURL parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
 DealModel *model = [DealModel modelWithJSON:responseObj];
 NSLog(@"");
 }];
 */

/* 搜索商户制作完毕
 NSString *businessURL = @"http://api.dianping.com/v1/business/find_businesses?appkey=4123794720&sign=073057A978DF3B8A83B2B97AF1FD1C1BA65D82CB&category=%E7%BE%8E%E9%A3%9F&city=%E4%B8%8A%E6%B5%B7&latitude=31.18268013000488&longitude=121.42769622802734&sort=1&limit=20&offset_type=1&out_offset_type=1&platform=2";
 [NSObject GET:businessURL parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
 BusinessModel *model = [BusinessModel modelWithJSON:responseObj];
 NSLog(@"");
 }];
 */



/*
 NSString *path = @"http://c.m.163.com/nc/video/home/1-10.html";
 [NSObject GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError *error) {
 NSLog(@"%@", responseObj);
 }];
 */


/*
 AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
 //请求:向服务器传数据, 服务器返回数据
 //GET POST(上传的数据可以更大一些)
 [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 NSLog(@"%@", responseObject);
 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
 NSLog(@"error %@", error);
 }]; */



