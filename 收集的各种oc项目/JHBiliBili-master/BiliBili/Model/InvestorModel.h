//
//  InvestorModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/11/6.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseModel.h"
/**
 *  承包商模型
 */
@interface InvestorModel : BaseModel
@property (nonatomic, strong) NSArray* list;
@end

@interface InvestorDataModel : BaseModel
// 头像
@property (nonatomic, strong)NSString* face;
// 回复内容
@property (nonatomic, strong)NSString* message;
//排行
@property (nonatomic, assign)NSInteger rank;
//名称
@property (nonatomic, strong)NSString* uname;
//@property (nonatomic, strong)NSString* uid;
//@property (nonatomic, strong)NSString* hidden;
@end
