//
//  DuoWanNetManager.m
//  BaseProject
//
//  Created by jiyingxin on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "DuoWanNetManager.h"
//很多具有共同点的东西，可以统一宏定义, 凡是自己写的宏定义 都需要用k开头，这是编码习惯

//如果宏命令超长需要换行，只需要在换行位置添加 \ 即可， 最后一行不用加
#define kOSType       @"OSType": [@"iOS" stringByAppendingString\
:[UIDevice currentDevice].systemVersion] //获取当前系统版本号

#define kVersionName    @"versionName": @"2.4.0"
#define kV              @"v": @140

#define kChangeKey(key)    [dic setObject:[dic objectForKey:[enName stringByAppendingString:key]]\
forKey:[@"desc" stringByAppendingString:key]];\
[dic removeObjectForKey:[enName stringByAppendingString:key]]

//把path写到文件头部，使用宏定义形势。 方便后期维护
//把所有路径宏定义封装到DuoWanRequestPath.h文件中,太多东西放在文件头部,好乱的说😊
#import "DuoWanRequestPath.h"

@implementation DuoWanNetManager

+ (id)getHeroWithType:(HeroType)type completionHandle:(void (^)(id, NSError *))completionHandle{
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{kOSType, kV}];
    switch (type) {
        case HeroTypeFree: {
            [params setObject:@"free" forKey:@"type"];
            break;
        }
        case HeroTypeAll: {
            [params setObject:@"all" forKey:@"type"];
            break;
        }
        default: {
            NSAssert1(NO, @"%s:type类型不正确", __func__);
            break;
        }
    }
    
    return [self GET:kHeroPath parameters:params completionHandler:^(id responseObj, NSError *error) {
        switch (type) {
            case HeroTypeFree: {
                completionHandle([FreeHeroModel mj_objectWithKeyValues:responseObj], error);
                break;
            }
            case HeroTypeAll: {
                completionHandle([AllHeroModel mj_objectWithKeyValues:responseObj], error);
                break;
            }
            default: {
                completionHandle(nil, error);
                break;
            }
        }
    }];
}


+ (id)getHeroSkinsWithHeroName:(NSString *)heroName completionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kHeroSkinPath parameters:@{kOSType, kV, kVersionName, @"hero": heroName} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroSkinModel mj_objectArrayWithKeyValuesArray:responseObj], error);
    }];
}

+ (id)getHeroSoundWithHeroName:(NSString *)heroName completionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kHeroSoundPath parameters:@{kOSType, kV, kVersionName, @"hero": heroName} completionHandler:^(id responseObj, NSError *error) {
//Json数据就是标准数组，不需要解析
        completionHandle(responseObj, error);
    }];
}

+ (id)getHeroVideosWithPage:(NSInteger)page tag:(NSString *)enName completionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kHeroVideoPath parameters:@{kVersionName, kOSType, @"action": @"l", @"p": @(page), @"src": @"letv", @"tag": enName} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroVideoModel mj_objectArrayWithKeyValuesArray:responseObj], error);
    }];
}

+ (id)getHeroCZWithHeroName:(NSString *)enName completionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kHeroCZPath parameters:@{kV, kOSType, @"limit": @7, @"championName": enName} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroCZModel mj_objectArrayWithKeyValuesArray:responseObj], error);
    }];
}

+ (id)getHeroDetailWithHeroName:(NSString *)enName completionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kHeroDetailPath parameters:@{kV, kOSType, @"heroName": enName} completionHandler:^(NSDictionary * responseObj, NSError *error) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:responseObj];
        kChangeKey(@"_Q");
        kChangeKey(@"_R");
        kChangeKey(@"_W");
        kChangeKey(@"_B");
        kChangeKey(@"_E");
        completionHandle([HeroDetailModel mj_objectWithKeyValues:dic], error);
    }];
}

+ (id)getHeroGiftAndRun:(NSString *)enName completionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kGiftAndRunPath parameters:@{kV, kOSType, @"hero": enName} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroGiftModel mj_objectArrayWithKeyValuesArray:responseObj], error);
    }];
}

+ (id)getHeroInfoWithHeroName:(NSString *)enName completionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kHeroInfoPath parameters:@{kV, kOSType, @"name": enName} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroChangeModel mj_objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getWeekDataWithHeroId:(NSInteger)heroId completionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kHeroWeekDataPath parameters:@{@"heroId": @(heroId)} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([HeroWeekDataModel mj_objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getToolMenuCompletionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kToolMenuPath parameters:@{kV, kVersionName, kOSType, @"category": @"database"} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ToolMenuModel mj_objectArrayWithKeyValuesArray:responseObj], error);
    }];
}

+ (id)getZBCategoryCompletionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kZBCategoryPath parameters:@{} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ZBCategoryModel mj_objectArrayWithKeyValuesArray:responseObj], error);
    }];
}

+ (id)getZBItemListWithTag:(NSString *)tag completionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kZBItemListPath parameters:@{@"tag": tag, kV, kOSType, kVersionName} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ZBItemModel mj_objectArrayWithKeyValuesArray:responseObj], error);
    }];
}

+ (id)getItemDetailWithItemId:(NSInteger)itemId completionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kItemDetailPath parameters:@{kV, kOSType, @"id": @(itemId)} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([ItemDetailModel mj_objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getGIftCompletionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kGiftPath parameters:@{kV, kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([GiftModel mj_objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getRunesCompletionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kRunesPath parameters:@{kV, kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([RuneModel mj_objectWithKeyValues:responseObj], error);
    }];
}

+ (id)getSumAbilityCompletionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kSumAbilityPath parameters:@{kV, kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([SumAbilityModel mj_objectArrayWithKeyValuesArray:responseObj], error);
    }];
}

+ (id)getHeroBestGroupCompletionHandle:(void (^)(id, NSError *))completionHandle{
    return [self GET:kBestGroupPath parameters:@{kV, kOSType} completionHandler:^(id responseObj, NSError *error) {
        completionHandle([BestGroupModel mj_objectArrayWithKeyValuesArray:responseObj], error);
    }];
}
@end

























