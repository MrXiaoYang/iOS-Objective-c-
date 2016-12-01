//
//  IndexModel.h
//  BiliBili
//
//  Created by apple-jd44 on 15/10/23.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseModel.h"
/**
 *  推荐页模型
 */
@interface IndexModel : BaseModel
@property (nonatomic, strong)NSArray* list;
@end

@interface IndexDataModel : BaseModel
@property (nonatomic, strong)NSString* title;
@property (nonatomic, strong)NSURL* img;
@property (nonatomic, strong)NSURL* link;
@end
