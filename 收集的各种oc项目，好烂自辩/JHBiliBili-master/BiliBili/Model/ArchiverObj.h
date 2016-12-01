//
//  ArchiverObj.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/18.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArchiverObj : NSObject
+ (void)archiveWithObj:(id)obj;
+ (void)archiveWithObj:(id)obj key:(NSString*)key;
+ (void)archiveWithObj:(id)obj path:(NSString*)path;

+ (id)UnArchiveWithKey:(NSString*)key;
+ (id)UnArchiveWithClass:(Class)class;
@end
