//
//  BTEntryList.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
/**
 *  
 tags	String	饮料
 dynamic	Object
 extend	String	100
 type	String	subject_detail
 rank_share_url	String	http://m.ibantang.com/post/subject/rank/100?userId=1607500
 id	String	100
 pic1	String	http://7xiwnz.com2.z0.glb.qiniucdn.com/subject1/201511/98975498.jpg?v=1448532331
 author	Object
 title	String	每日一晒：缤纷多彩的饮料
 datestr	String	11-26 17:57
 description	String
 share_url	String	http://m.ibantang.com/post/subject/100/
 start_time	String	1448531872
 author_id	String	1
 is_recommend	String	0
 pic2	String	http://7xiwnz.com2.z0.glb.qiniucdn.com/subject2/201511/98975499.jpg?v=1448532331
 */

#import <Foundation/Foundation.h>

@interface BTEntryList : NSObject

@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *extend;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *rankShareUrl;
@property (nonatomic, copy) NSString *idString;
@property (nonatomic, copy) NSString *pic1;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *datestr;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *authorId;
@property (nonatomic, copy) NSString *isRecommend;
@property (nonatomic, copy) NSString *pic2;

@end
