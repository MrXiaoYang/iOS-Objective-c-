//
//  SpecialViewModel.m
//  BiliBili
//
//  Created by apple-jd24 on 15/12/15.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SearchModel.h"
#import "SpecialModel.h"

#import "SpecialViewModel.h"

#import "SearchNetManager.h"

@interface SpecialViewModel()
@property (nonatomic, strong)NSArray<SpecialDateModel*>* list;
@property (nonatomic, strong)SearchSpecialModel* model;
@end

@implementation SpecialViewModel
#pragma mark - 专题部分
/**
 *  专题封面
 *
 */
- (NSURL*)specialCover{
    return [NSURL URLWithString: self.model.pic];
}
/**
 *  专题标题
 *
 */
- (NSString*)specialTitle{
    return self.model.title;
}
/**
 *  专题浏览数
 *
 */
- (NSString*)specialBrowse{
    return [@"浏览：" stringByAppendingString: self.model.click];
}
/**
 *  专题订阅
 *
 */
- (NSString*)specialFaverite{
    return [@"订阅：" stringByAppendingString:self.model.favourite];
}
/**
 *  专题描述
 *
 */
- (NSString*)specialDetail{
    return self.model.desc;
}

/**
 *  专题总集数
 *
 */
- (NSInteger)specialcount{
    return self.list.count;
}


#pragma mark - 专题剧集部分
/**
 *  分集
 *
 */
- (NSURL*)episodeCoverWithIndex:(NSInteger)index{
    return [NSURL URLWithString:[self episodeWithIndex: index].cover];
}
/**
 *  标题
 *
 */
- (NSString*)episodeTitleWithIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"第%@话", [self episodeWithIndex: index].episode];
}
/**
 *  描述
 *
 */
- (NSString*)episodeDetailWithIndex:(NSInteger)index{
    return [self episodeWithIndex: index].title;
}
/**
 *  模型
 *
 */
- (SpecialDateModel*)episodeWithIndex:(NSInteger)index{
    return self.list[index];
}


#pragma mark - 其他方法
- (void)refreshDataCompleteHandle:(void(^)(NSError *error))complete{
    [SearchNetManager getSpecialParameters:self.model.spid CompletionHandler:^(SpecialModel* responseObj, NSError *error) {
        self.list = responseObj.list;
        complete(error);
    }];
}

- (instancetype)initWithModel:(SearchSpecialModel*)model{
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}
@end
