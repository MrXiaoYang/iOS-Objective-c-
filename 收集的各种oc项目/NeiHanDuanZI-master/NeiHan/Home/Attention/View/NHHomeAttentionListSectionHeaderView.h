//
//  NHHomeAttentionListSectionHeaderView.h
//  NeiHan
//
//  Created by Charles on 16/8/31.
//  Copyright © 2016年 Charles. All rights reserved.
//  组头

#import "NHBaseTableHeaderFooterView.h"

@interface NHHomeAttentionListSectionHeaderView : NHBaseTableHeaderFooterView
/** 提示文字*/
@property (nonatomic, weak) NSString *tipText;
/** 文字颜色*/
@property (nonatomic, strong) UIColor *textColor;
/** 提示文字标签*/
@property (nonatomic, weak) UILabel *tipL;
@end
