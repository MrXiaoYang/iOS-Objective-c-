//
//  BTSubjectListPostBottomView.h
//  BanTang
//
//  Created by 沈文涛 on 15/11/28.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTListPostDynamic;
typedef void(^BugBtnDidClickBlock)();
typedef void(^CommentBtnDidClickBlock)();
typedef void(^LikeBtnDidClickBlock)();

@interface BTSubjectListPostBottomView : UIView

+ (instancetype)bottomView;

@property (nonatomic, copy) NSString *commentCount;

@property (nonatomic, copy) NSString *likersCount;

@property (nonatomic, copy) BugBtnDidClickBlock buyBlock;

@property (nonatomic, copy) CommentBtnDidClickBlock commentBlock;

@property (nonatomic, copy) LikeBtnDidClickBlock likeBlock;

@property (nonatomic, strong) BTListPostDynamic *dynamic;

@property (nonatomic, assign) BOOL collect;

@property (nonatomic, strong) NSArray *productArray;

@end
