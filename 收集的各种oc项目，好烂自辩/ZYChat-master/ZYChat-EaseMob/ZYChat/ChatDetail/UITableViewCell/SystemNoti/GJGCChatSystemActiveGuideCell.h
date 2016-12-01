//
//  GJGCChatSystemActiveGuideCell.h
//  ZYChat
//
//  Created by ZYVincent QQ:1003081775 on 14-11-10.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import "GJGCChatSystemNotiBaseCell.h"
#import "GJCURoundCornerButton.h"

@interface GJGCChatSystemActiveGuideCell : GJGCChatSystemNotiBaseCell

@property (nonatomic,strong)GJCFCoreTextContentView *titleLabel;

@property (nonatomic,strong)GJCUAsyncImageView *activeImageView;

@property (nonatomic,strong)GJCURoundCornerButton *acceptButton;

@end
