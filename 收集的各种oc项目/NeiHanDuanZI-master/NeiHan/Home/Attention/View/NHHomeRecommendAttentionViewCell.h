//
//  NHHomeRecommendAttentionViewCell.h
//  NeiHan
//
//  Created by Charles on 16/9/2.
//  Copyright © 2016年 Charles. All rights reserved.
//  推荐关注

#import "NHBaseTableViewCell.h"

@interface NHHomeRecommendAttentionViewCell : NHBaseTableViewCell

/** 点击关注回调*/
@property (nonatomic, weak) void(^homeRecommendAttentionViewCellAttentionHandle)(NHHomeRecommendAttentionViewCell *cell);
@end
