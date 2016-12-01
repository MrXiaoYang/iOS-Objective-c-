//
//  MusicHouseCell.h
//  BaseProject
//
//  Created by jiyingxin on 15/12/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MusicItemType) {
    MusicItemTypeChoose,        //精选
    MusicItemTypeRank,          //排行
    MusicItemTypeMedia,         //视频
    MusicItemTypeCommunity,     //社区
};

@class MusicHouseCell;

@protocol MusicHouseCellDelegate <NSObject>
- (void)musicHouseCell:(UITableViewCell *)musicHouseCell selectedItem:(MusicItemType)itemType;

@end

@interface MusicHouseCell : UITableViewCell
@property(nonatomic,weak) id<MusicHouseCellDelegate> delegate;
@end
