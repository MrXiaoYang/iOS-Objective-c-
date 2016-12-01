//
//  UserDefaultDictionary.h
//  BiliBili
//
//  Created by apple-jd44 on 15/12/6.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  UserDefault的下载部分对应的字典类 
 */
@interface UserDefaultDownLoadManager: NSObject
@property (nonatomic, strong) NSMutableDictionary* downLoadDic;
+ (instancetype)shareDownLoadManager;
- (void)updateDownLoadDicWithKey:(NSString*)key Obj:(id)obj;
- (void)updateDownLoadDicWithKeyPath:(NSString*)keyPath Obj:(id)obj;
- (void)updateDownLoadDicWithDic:(NSMutableDictionary*)dic;
- (NSMutableDictionary*)mutableDownLoadDicWithKey:(NSString*)key;
- (NSMutableDictionary*)mutableDownLoadDicWithIndex:(NSInteger)index;
@end
