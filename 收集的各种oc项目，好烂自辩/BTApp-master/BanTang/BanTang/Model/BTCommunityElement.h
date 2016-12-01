//
//  BTCommunityElement.h
//  BanTang
//
//  Created by 沈文涛 on 15/12/6.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  
 {
 "title": "\u4e00\u5468\u4e4b\u661f",
 "pic1": "http:\/\/7xiwnz.com2.z0.glb.qiniucdn.com\/element1\/201512\/57102495.jpg?v=1449227369",
 "pic2": "",
 "type": "subject_detail",
 "extend": "117"
 }
 */
@interface BTCommunityElement : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *pic1;
@property (nonatomic, copy) NSString *pic2;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *extend;

@end
