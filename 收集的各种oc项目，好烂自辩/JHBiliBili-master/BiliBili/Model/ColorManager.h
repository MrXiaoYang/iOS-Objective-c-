//
//  ColorManager.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/20.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorManager : NSObject
@property (nonatomic, strong) NSString* themeStyle;
@property (nonatomic, strong) NSDictionary* colorDic;
+ (instancetype)shareColorManager;
- (UIColor*)colorWithString:(NSString*)str;
- (UIColor*)colorWithString:(NSString*)str alpha:(CGFloat)alpha;
- (UIColor*)theme:(NSString*)theme colorWithString:(NSString*)str alpha:(CGFloat)alpha;
- (UIColor*)theme:(NSString*)theme colorWithString:(NSString*)str;
@end
