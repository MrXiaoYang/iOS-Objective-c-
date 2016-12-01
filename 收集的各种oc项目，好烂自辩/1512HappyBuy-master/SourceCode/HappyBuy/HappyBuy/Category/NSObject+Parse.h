//
//  NSObject+Parse.h
//  HappyBuy
//
//  Created by tarena on 16/3/30.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit.h>

/** 复制协议 */
#define kCopyZoneMethod \
- (id)copyWithZone:(NSZone *)zone { return [self modelCopy]; }

/** 归档解档协议 */
#define kCodingMethod \
- (void)encodeWithCoder:(NSCoder *)aCoder { [self modelEncodeWithCoder:aCoder]; } \
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super initWithCoder:aDecoder]; return [self modelInitWithCoder:aDecoder]; }

/** 判断对象相等方法 */
#define kEqualObjMethod \
- (BOOL)isEqual:(id)object {\
return [self modelIsEqual:object];\
}

/** 自动完成对象描述 */
#define kDescriptionMethod \
- (NSString *)description { return [self modelDescription]; }

/** 对象Hash */
#define kHashMethod \
- (NSUInteger)hash { return [self modelHash]; }

@interface NSObject (Parse)

+ (id)parseJSON:(id)json;

@end









