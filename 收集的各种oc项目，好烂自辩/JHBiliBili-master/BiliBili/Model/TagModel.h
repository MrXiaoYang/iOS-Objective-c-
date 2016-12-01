//
//  TagModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/8.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseModel.h"

//tag模型@end
@interface TagModel : BaseModel
@property (nonatomic, strong) NSArray* result;
@end

@interface TagDataModel : BaseModel
@property (nonatomic, strong)NSString* name;
@end