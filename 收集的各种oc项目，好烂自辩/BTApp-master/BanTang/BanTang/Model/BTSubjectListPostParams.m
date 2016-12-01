//
//  BTSubjectListPostParams.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/29.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTSubjectListPostParams.h"

@implementation BTSubjectListPostParams

+ (instancetype)paramsWithTypeId:(NSString *)typeId
                        sujectId:(NSString *)subjectId
                          lastId:(NSString *)lastId
                            page:(NSInteger)page
                        pagesize:(NSInteger)pagesize
{
    BTSubjectListPostParams *params = [[BTSubjectListPostParams alloc] init];
    params.type_id = typeId;
    params.subject_id = subjectId;
    params.last_id = lastId;
    params.page = page;
    params.pagesize = pagesize;
    return params;
}
@end
