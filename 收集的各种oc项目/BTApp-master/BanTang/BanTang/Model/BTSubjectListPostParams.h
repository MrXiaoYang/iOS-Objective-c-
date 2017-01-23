//
//  BTSubjectListPostParams.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/29.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTBaseRequestParmas.h"

@interface BTSubjectListPostParams : BTBaseRequestParmas

@property (nonatomic, copy) NSString *type_id;

@property (nonatomic, copy) NSString *subject_id;

@property (nonatomic, copy) NSString *last_id;

+ (instancetype)paramsWithTypeId:(NSString *)typeId
                        sujectId:(NSString *)subjectId
                          lastId:(NSString *)lastId
                            page:(NSInteger)page
                        pagesize:(NSInteger)pagesize;

@end
