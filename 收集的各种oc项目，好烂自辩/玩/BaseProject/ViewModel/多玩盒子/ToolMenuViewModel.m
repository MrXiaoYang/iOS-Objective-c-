//
//  ToolMenuViewModel.m
//  BaseProject
//
//  Created by jiyingxin on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ToolMenuViewModel.h"

@implementation ToolMenuViewModel

/** 不是分页，只实现getData方法即可 */
- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    self.dataTask = [DuoWanNetManager getToolMenuCompletionHandle:^(id model, NSError *error) {
        self.dataArr = model;
        completionHandle(error);
    }];
}
- (NSInteger)rowNumber{
    return self.dataArr.count;
}

- (ToolMenuModel *)modelForRow:(NSInteger)row{
    return self.dataArr[row];
}

- (NSString *)titleForRow:(NSInteger)row{
    return [self modelForRow:row].name;
}
- (NSURL *)iconURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].icon];
}
- (NSString *)tagForRow:(NSInteger)row{
    return [self modelForRow:row].tag;
}

- (NSURL *)webURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[self modelForRow:row].url];
}

- (ToolMenuItemType)itemTypeForRow:(NSInteger)row{
    NSString *type = [self modelForRow:row].type;
    if ([type isEqualToString:@"native"]) {
        return ToolMenuItemTypeNative;
    }
    if ([type isEqualToString:@"web"]) {
        return ToolMenuItemTypeWeb;
    }
    return 0;
}

@end













