//
//  ZBDetailViewModel.m
//  BaseProject
//
//  Created by 廖文博 on 15/11/12.
//  Copyright © 2015年 wenbo. All rights reserved.
//

#import "ZBDetailViewModel.h"

@implementation ZBDetailViewModel
-(id)initWithEquipId:(NSInteger)equipId
{
    if(self = [super init])
    {
        self.equipId = equipId;
    }
    return self;
}
-(void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle
{
    self.dataTask = [DuoWanNetManager getItemDetailWithItemId:self.equipId completionHandle:^(id model, NSError *error) {
        self.model = model;
        completionHandle(error);
    }];
}
-(NSString *)nameFromModel
{
    return self.model.name;
}
-(NSString *)descFromModel
{
    return self.model.desc;
}
-(NSString *)priceFromModel
{
    return [NSString stringWithFormat:@"升级价格:%ld 总价格:%ld 出售价格:%ld",self.model.price,self.model.allPrice,self.model.sellPrice];
}
-(NSArray *)needArrayFromModel
{
    NSArray *array = [self.model.need componentsSeparatedByString:@","];
    return array;
}
-(NSArray *)composeArrayFromModel
{
    NSArray *array = [self.model.compose componentsSeparatedByString:@","];
    return array;
}
@end
