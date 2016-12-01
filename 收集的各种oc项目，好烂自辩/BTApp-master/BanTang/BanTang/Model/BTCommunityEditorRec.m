//
//  BTCommunityEditorRec.m
//  BanTang
//
//  Created by 沈文涛 on 15/12/6.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTCommunityEditorRec.h"
#import "BTCommunityElement.h"
#import "BTListPost.h"
@implementation BTCommunityEditorRec

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"element":[BTCommunityElement class],
             @"list": [BTListPost class]
             };
}

@end
