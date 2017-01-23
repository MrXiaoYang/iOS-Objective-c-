//
//  TuWanNetManager.h
//  BaseProject
//
//  Created by jiyingxin on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "TuWanModel.h"
#import "TuWanVideoModel.h"
#import "TuWanPicModel.h"
//只要公用一个解析类的请求，就可以合起来写，只需要使用枚举变量，来决定不同的请求地址即可
//如果不会 可以参考汽车之家接口

typedef NS_ENUM(NSUInteger, InfoType) {
    InfoTypeTouTiao,        //头条
    InfoTypeDuJia,          //独家
    InfoTypeAnHei3,         //暗黑3
    InfoTypeMoShou,         //魔兽
    InfoTypeFengBao,        //风暴
    InfoTypeLuShi,          //炉石
    InfoTypeXingJi2,        //星际2
    InfoTypeShouWang,       //守望
    InfoTypeTuPian,         //图片
    InfoTypeShiPin,         //视频
    InfoTypeGongLue,        //攻略
    InfoTypeHuanHua,        //幻化
    InfoTypeQuWen,          //趣闻
    InfoTypeCos,            //COS
    InfoTypeMeiNv,          //美女
};

@interface TuWanNetManager : BaseNetManager

//下方注释是 VVDocumenter 插件生成的。 安装此插件，在任何需要注释的位置 写///   三个/ 就可以自动弹出注释模板了

/**
 *  获取某种类型的资讯
 *
 *  @param type  资讯类型
 *  @param start 当前资讯起始索引值，最小为0。 eg 0,11,22,33,44...
 *
 *  @return 请求所在任务
 */
+ (id)getTuWanInfoWithType:(InfoType)type start:(NSInteger)start kCompletionHandle;

/**
 *  获取视频类资讯的详情页
 *
 *  @param aid 资讯aid
 *
 *  @return 任务
 */
+ (id)getVideoDetailWithId:(NSString *)aid kCompletionHandle;

/**
 *  获取图片类资讯的详情页
 *
 *  @param aid 资讯aid
 *
 *  @return 任务
 */
+ (id)getPicDetailWithId:(NSString *)aid kCompletionHandle;

@end











