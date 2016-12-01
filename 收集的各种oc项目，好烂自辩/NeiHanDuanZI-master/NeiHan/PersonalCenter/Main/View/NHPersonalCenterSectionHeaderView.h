//
//  NHPersonalCenterSectionHeaderView.h
//  NeiHan
//
//  Created by Charles on 16/9/8.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHBaseTableHeaderFooterView.h"
#import "NHPersonalCenterHeaderConstant.h"

@class NHPersonalCenterSectionHeaderView;
@protocol NHPersonalCenterSectionHeaderViewDelegate <NSObject>
- (void)personalCenterSectionHeaderView:(NHPersonalCenterSectionHeaderView *)headerView didClickItemwithType:(NHPersonalCenterSectionHeaderViewItemType)type;
@end

@interface NHPersonalCenterSectionHeaderView : NHBaseTableHeaderFooterView

@property (nonatomic, weak) id <NHPersonalCenterSectionHeaderViewDelegate> delegate;

- (void)clickDefault; 
@end
