//
//  HeroDetailModel.m
//  BaseProject
//
//  Created by jiyingxin on 15/11/2.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "HeroDetailModel.h"

@implementation HeroDetailModel


+ (NSDictionary *)objectClassInArray{
    return @{@"like" : [HeroDetailLikeModel class], @"hate" : [HeroDetailHateModel class]};
}



@end

@implementation HeroDetailBraumModel

@end

@implementation HeroDetailLikeModel

@end


@implementation HeroDetailHateModel

@end


