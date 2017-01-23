//
//  CategoriesModel.m
//  HappyBuy
//
//  Created by tarena on 16/3/30.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import "CategoriesModel.h"

@implementation CategoriesModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"mapIcon": @"map_icon",
             @"highlightedIcon": @"highlighted_icon",
             @"smallHighlightedIcon": @"small_highlighted_icon",
             @"smallIcon": @"small_icon"};
}
@end









