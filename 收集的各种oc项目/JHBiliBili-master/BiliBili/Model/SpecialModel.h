//
//  SpecialModel.h
//  BiliBili
//
//  Created by apple-jd24 on 15/12/13.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseModel.h"
/**
 *  专题模型
 */
@interface SpecialModel : BaseModel
@property (nonatomic, strong)NSArray* list;
@end

@interface SpecialDateModel : BaseModel
//@property (nonatomic, strong)NSString* from;
/**
 *  标题
 */
@property (nonatomic, strong)NSString* title;
/**
 *  aid
 */
@property (nonatomic, strong)NSString* aid;
/**
 *  集数
 */
@property (nonatomic, strong)NSString* episode;
/**
 *  封面
 */
@property (nonatomic, strong)NSString* cover;
/**
 *  点击数
 */
@property (nonatomic, strong)NSString* click;
/**
 *  分页
 */
@property (nonatomic, strong)NSString* page;
/**
 *  cid
 */
@property (nonatomic, strong)NSString* cid;
@end