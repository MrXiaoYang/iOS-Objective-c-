//
//  GiftModel.h
//  BaseProject
//  天赋
//  Created by jiyingxin on 15/11/2.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class GiftAModel;
@interface GiftModel : BaseModel

@property (nonatomic, strong) NSArray<GiftAModel *> *a;

@property (nonatomic, strong) NSArray<GiftAModel *> *d;

@property (nonatomic, strong) NSArray<GiftAModel *> *g;

@end
@interface GiftAModel : BaseModel

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<NSString *> *level;

@end


