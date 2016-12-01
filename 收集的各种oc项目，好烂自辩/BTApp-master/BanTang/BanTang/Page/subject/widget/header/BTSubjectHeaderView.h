//
//  BTSubjectHeaderView.h
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTCommunitySubject;

typedef void(^RankListDidClickBlock)();

@interface BTSubjectHeaderView : UIView

+ (instancetype)headerView;

@property (nonatomic, strong) BTCommunitySubject  *subject;

@property (nonatomic, copy) RankListDidClickBlock rankListDidClickBlock;

@end
