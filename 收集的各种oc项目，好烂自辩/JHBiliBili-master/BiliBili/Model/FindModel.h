//
//  FindModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/3.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseModel.h"
//发现页热搜排行模型
@interface FindModel : BaseModel
@property (nonatomic, strong) NSArray* list;
@end

@interface FindDataModel : BaseModel
@property (nonatomic, strong)NSString* keyword;
@property (nonatomic, strong)NSString* status;
@end

//发现页两个热搜图
@interface FindImgModel : BaseModel
@property (nonatomic, strong) NSArray* recommend;
@end

@interface FindImgDataModel : BaseModel
//@property (nonatomic, assign)CGFloat width;
//@property (nonatomic, assign)CGFloat height;
@property (nonatomic, strong)NSString* cover;
@property (nonatomic, strong)NSString* keyword;
@end