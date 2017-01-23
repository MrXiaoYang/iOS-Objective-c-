//
//  BTBannerBottom.m
//  BanTang
//
//  Created by Ryan on 16/3/15.
//  Copyright © 2016年 Ryan. All rights reserved.
//

#import "BTBannerBottom.h"

@implementation BTBannerBottom
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
	if ([propertyName isEqualToString:@"ID"]) {
		propertyName = @"id";
	}
	
	return [propertyName mj_underlineFromCamel];
}
@end
