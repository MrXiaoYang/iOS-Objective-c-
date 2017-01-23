//
//  BTUserInfo.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/29.
//  Copyright © 2015年 Ryan. All rights reserved.
/**
 *  
 user_sign	String	我想要的生活
 badge_url	String	http://m.bantangapp.com/users/badge/index?user_id=1607500
 attention_type	Integer	2
 nickname	String	〆 、囄卟開
 fans	    String	0
 post_like	String	2
 credits	String	15
 avatar	String	http://q.qlogo.cn/qqapp/1103754568/11F04CA6CEB185DD45A4E297AE93B4C6/100
 post_rec	String	0
 attentions	String	8
 badges	    String	4
 user_cover	String	http://7ximm9.com2.z0.glb.qiniucdn.com/user3/cover_ios_640.jpg?v=0
 user_id	String	1607500
 */

#import <Foundation/Foundation.h>

@interface BTUserInfo : NSObject

@property (nonatomic, copy) NSString *userSign;
@property (nonatomic, copy) NSString *badgeUrl;
@property (nonatomic, assign) NSInteger attentionType;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *fans;
@property (nonatomic, copy) NSString *postLike;
@property (nonatomic, copy) NSString *credits;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *postRec;
@property (nonatomic, copy) NSString *attentions;
@property (nonatomic, copy) NSString *badges;
@property (nonatomic, copy) NSString *userCover;
@property (nonatomic, copy) NSString *userId;

@end
