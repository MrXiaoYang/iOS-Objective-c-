//
//  ArchiverObj.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/18.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ArchiverObj.h"
static NSMutableDictionary* dic = nil;

@implementation ArchiverObj
#pragma mark - 归档
+ (void)archiveWithObj:(id)obj{
    [self archiveWithObj:obj key:[NSString stringWithCString:object_getClassName(obj) encoding:NSUTF8StringEncoding]];
}


+ (void)archiveWithObj:(id)obj key:(NSString*)key{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (dic == nil) {
            dic = [NSMutableDictionary dictionary];
        }
    });
    if ([key isEqualToString:@""] || key == nil || obj == nil) {
        return;
    }
    [dic setValue:obj forKey:key];
    [self archiveWithObj:dic path:kArchiverCachePath];
//    [NSKeyedArchiver archiveRootObject:dic toFile:kArchiverCachePath];
}

+ (void)archiveWithObj:(id)obj path:(NSString*)path{
    //path不存在 自动创建
    NSString* tempDirectory = [path stringByDeletingLastPathComponent];
    if (![[NSFileManager defaultManager] fileExistsAtPath: tempDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:tempDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [NSKeyedArchiver archiveRootObject:obj toFile: path];
}


#pragma mark - 解档
+ (id)UnArchiveWithKey:(NSString*)key{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = [NSKeyedUnarchiver unarchiveObjectWithFile:kArchiverCachePath];
        if (dic == nil) {
            dic = [NSMutableDictionary dictionary];
        }
    });
    if ([key isEqualToString:@""] || key == nil) {
        return nil;
    }
    return [dic valueForKey:key];
}

+ (id)UnArchiveWithClass:(Class)class{
    return [self UnArchiveWithKey:[NSString stringWithCString:object_getClassName(class) encoding:NSUTF8StringEncoding]];
}
@end
