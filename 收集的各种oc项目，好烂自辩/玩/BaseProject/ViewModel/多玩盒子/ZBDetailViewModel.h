//
//  ZBDetailViewModel.h
//  BaseProject
//
//  Created by 廖文博 on 15/11/12.
//  Copyright © 2015年 wenbo. All rights reserved.
//

#import "BaseViewModel.h"
#import "DuoWanNetManager.h"
@interface ZBDetailViewModel : BaseViewModel
/**
  {
 "id": "3004",
 "name": "魔宗",
 "description": "+25攻击力，+250法力值，+25%基础法力回复/秒，唯一被动—敬畏：提供攻击力，相当于你最大法力值的2%。唯一被动—法力积攒：你的英雄每进行一次普通攻击，使用技能或花费法力时，你的最大法力值都会提高4（每8秒最多触发2次）。法力值加成上限为750。一旦法力值加成到达750时，这个物品就会变成【魔切】。（同名的唯一被动效果不叠加。）",
 "price": 605,
 "allPrice": 2200,
 "sellPrice": 1540,
 "tags": " ",
 "extAttrs": {
 "FlatMPPoolMod": 250,
 "FlatPhysicalDamageMod": 25,
 "PercentBaseMPRegenMod": 0.25
 },
 "need": "3070,1037",
 "compose": "3042",
 "extDesc": "+25%基础法力回复/秒，唯一被动—敬畏：提供攻击力，相当于你最大法力值的2%。唯一被动—法力积攒：你的英雄每进行一次普通攻击，使用技能或花费法力时，你的最大法力值都会提高4（每8秒最多触发2次）。法力值加成上限为750。一旦法力值加成到达750时，这个物品就会变成【魔切】。（同名的唯一被动效果不叠加）。"
 }
 */
@property (nonatomic,strong) ItemDetailModel *model;
-(NSString *)nameFromModel;
-(NSString *)descFromModel;
-(NSString *)priceFromModel;
-(NSArray *)needArrayFromModel;
-(NSArray *)composeArrayFromModel;

@property (nonatomic,assign)NSInteger equipId;
-(id)initWithEquipId:(NSInteger)equipId;

@end
