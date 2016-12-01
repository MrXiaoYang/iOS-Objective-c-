//
//  UserDefaultDictionary.m
//  BiliBili
//
//  Created by apple-jd44 on 15/12/6.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "UserDefaultDownLoadManager.h"
static UserDefaultDownLoadManager* downLoadManager = nil;
@interface UserDefaultDownLoadManager()
//下标缓存字典
@property (nonatomic, strong) NSMutableDictionary* cacheLoadDic;
@end

@implementation UserDefaultDownLoadManager
+ (instancetype)shareDownLoadManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downLoadManager = [[UserDefaultDownLoadManager alloc] init];
    });
    return downLoadManager;
}
/**
 *  更新字典
 *
 *  @param key 键值
 *  @param obj 对象
 */
- (void)updateDownLoadDicWithKey:(NSString*)key Obj:(id)obj{
    self.cacheLoadDic[obj[@"index"]] = obj;
    self.downLoadDic[key] = obj;
    [self synchronizeDownLoadDic];
}

- (void)updateDownLoadDicWithKeyPath:(NSString*)keyPath Obj:(id)obj{
    [self.downLoadDic setValue:obj forKeyPath: keyPath];
    [self synchronizeDownLoadDic];
}

- (void)updateDownLoadDicWithDic:(NSMutableDictionary*)dic{
    [self.downLoadDic setValuesForKeysWithDictionary: dic];
    [self synchronizeDownLoadDic];
}

/**
 *  自动把取出的键值转成可变对象
 *
 *  @param key 键值
 */
- (NSMutableDictionary*)mutableDownLoadDicWithKey:(NSString*)key{
    return [self.downLoadDic[key] mutableCopy];
}

/**
 *  把下标对应对象转成转成可变对象
 *
 *  @param Index 下标
 *
 *  @return 可变字典
 */
- (NSMutableDictionary*)mutableDownLoadDicWithIndex:(NSInteger)index{
    //没有缓存字典则创建
    if (_cacheLoadDic == nil) {
        [self.downLoadDic enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, NSDictionary*  _Nonnull obj, BOOL * _Nonnull stop) {
            self.cacheLoadDic[obj[@"index"]] = obj;
        }];
    }
    return [self.cacheLoadDic[@(index)] mutableCopy];
}

#pragma mark - 私有方法

- (void)synchronizeDownLoadDic{
    [[NSUserDefaults standardUserDefaults] setObject:self.downLoadDic forKey:@"downLoad"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 懒加载
- (NSMutableDictionary *)downLoadDic{
    if(_downLoadDic == nil) {
        _downLoadDic = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"downLoad"] mutableCopy];
        if (_downLoadDic == nil) {
            _downLoadDic = [NSMutableDictionary new];
        }
    }
    return _downLoadDic;
}
- (NSMutableDictionary *)cacheLoadDic{
	if(_cacheLoadDic == nil) {
		_cacheLoadDic = [[NSMutableDictionary alloc] init];
	}
	return _cacheLoadDic;
}

@end
