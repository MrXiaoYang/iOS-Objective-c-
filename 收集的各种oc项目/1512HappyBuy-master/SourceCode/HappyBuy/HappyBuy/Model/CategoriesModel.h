//
//  CategoriesModel.h
//  HappyBuy
//
//  Created by tarena on 16/3/30.
//  Copyright © 2016年 tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoriesModel : NSObject
//map_icon -> mapIcon
@property (nonatomic, copy) NSString *mapIcon;
//highlighted_icon -> highlightedIcon
@property (nonatomic, copy) NSString *highlightedIcon;
//small_highlighted_icon -> smallHighlightedIcon
@property (nonatomic, copy) NSString *smallHighlightedIcon;
@property (nonatomic, strong) NSArray<NSString *> *subcategories;
//small_icon -> smallIcon
@property (nonatomic, copy) NSString *smallIcon;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;

@end










