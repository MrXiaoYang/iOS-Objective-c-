//
//  BTFirstpageElement.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/26.
//  Copyright © 2015年 Ryan. All rights reserved.
/**
 *  
 index	Integer	2
 title	String	剁手剁脚战「黑五」
 extend	String	http://m.bantangapp.com/appview/productList/blackFriday.html?f=idList1
 type	String	webview
 photo	String	http://7xiwnz.com2.z0.glb.qiniucdn.com/element1/201511/53535248.jpg?v=1448359845
 */

#import <Foundation/Foundation.h>

@interface BTFirstpageElement : NSObject

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *extend;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *photo;

@end
