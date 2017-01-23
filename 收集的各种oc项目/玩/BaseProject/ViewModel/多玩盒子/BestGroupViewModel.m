//
//  BestGroupViewModel.m
//  BaseProject
//
//  Created by jiyingxin on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BestGroupViewModel.h"
#import "DuoWanNetManager.h"

@implementation BestGroupViewModel

- (NSInteger)rowNumber{
    return self.dataArr.count;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    self.dataTask = [DuoWanNetManager getHeroBestGroupCompletionHandle:^(id model, NSError *error) {
        if (!error) {
            self.dataArr = model;
        }
        completionHandle(error);
    }];
}

- (BestGroupModel *)modelForRow:(NSInteger)row{
    return self.dataArr[row];
}

/** 英雄头像URL数组 */
- (NSArray *)iconURLsForRow:(NSInteger)row{
    return @[kIconPathWithEnName([self modelForRow:row].hero1),
             kIconPathWithEnName([self modelForRow:row].hero2),
             kIconPathWithEnName([self modelForRow:row].hero3),
             kIconPathWithEnName([self modelForRow:row].hero4),
             kIconPathWithEnName([self modelForRow:row].hero5)];
}

- (NSString *)titleForRow:(NSInteger)row{
    return [self modelForRow:row].title;
}
- (NSString *)descForRow:(NSInteger)row{
    return [self modelForRow:row].des;
}

/** 英雄描述数组 */
- (NSArray *)descsForRow:(NSInteger)row{
    return @[[self modelForRow:row].des1,
             [self modelForRow:row].des2,
             [self modelForRow:row].des3,
             [self modelForRow:row].des4,
             [self modelForRow:row].des5];
}

@end










