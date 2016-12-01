//
//  PortalSettingsModel.m
//  HappyBuy
//
//  Created by jiyingxin on 16/3/30.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "PortalSettingsModel.h"

@implementation PortalSettingsModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"maps": [PortalSettingsMapsModel class]};
}
@end
@implementation PortalSettingsMapsModel

@end


