//
//  NHDiscoverNearByFilterView.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NHDiscoverNearByFilterType) {
    /** 全部*/
    NHDiscoverNearByFilterTypeAll = 1,
    /** 男*/
    NHDiscoverNearByFilterTypeMale,
    /** 女*/
    NHDiscoverNearByFilterTypeFemale,
    /** 不明*/
    NHDiscoverNearByFilterTypeUnknown,
    /** 清除位置信息*/
    NHDiscoverNearByFilterTypeClearLoc,
};

@class NHDiscoverNearByFilterView;
@protocol NHDiscoverNearByFilterViewDelegate <NSObject>
/** 点击筛选回调*/
- (void)discoverNearByFilterView:(NHDiscoverNearByFilterView *)filterView didFilterWithType:(NHDiscoverNearByFilterType)filterType;
@end
@interface NHDiscoverNearByFilterView : UIView

@property (nonatomic, weak) id <NHDiscoverNearByFilterViewDelegate> delegate;

+ (instancetype)filterViewWithGender:(NSInteger)gender;

- (void)show;

- (void)dismiss;

@end
