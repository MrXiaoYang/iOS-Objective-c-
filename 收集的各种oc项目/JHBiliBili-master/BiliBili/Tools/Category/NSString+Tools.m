//
//  NSString+Tools.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/5.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "NSString+Tools.h"
#import "NSDictionary+Tools.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Tools)
+ (NSString*)stringWithFormatNum:(NSInteger)num{
    if (num >= 10000) {
        return [NSString stringWithFormat:@"%.1lf万",num * 1.0 / 10000];
    }
    return [NSString stringWithFormat:@"%ld", (long)num];
}

- (NSArray<NSString *>*)subStringsWithRegularExpression:(NSString*)regularExpression{
    NSRegularExpression* regu = [[NSRegularExpression alloc] initWithPattern:regularExpression options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray* objArr = [regu matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    if (objArr.count > 0) {
        NSMutableArray* returnArr = [NSMutableArray array];
        for (NSTextCheckingResult* rs in objArr) {
            [returnArr addObject:[self substringWithRange:rs.range]];
        }
        return [returnArr copy];
    }
    return nil;
}

+ (NSString*)signStringWithDic:(NSDictionary*)dic{
    //将字典键降序排列后转成md5
    return [self signStringWithString: [dic appendGetSortParameterWithBasePath:@""]];
}

+ (NSString*)signStringWithString:(NSString*)str{
    //开始md5转换
    const char *cStr = [[str stringByAppendingString: APPSEC] UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    
    NSMutableString *hash = [NSMutableString string];
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++)
    {
        [hash appendFormat:@"%02X",result[i]];
    }
    return [hash lowercaseString];
}

@end
