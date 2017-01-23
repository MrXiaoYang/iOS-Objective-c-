//
//  BTEntryListCell.m
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTEntryListCell.h"
#import "BTEntryList.h"
#import <UIImageView+WebCache.h>
@interface BTEntryListCell()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation BTEntryListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

- (void)setEntryList:(BTEntryList *)entryList
{
    _entryList = entryList;
    
    [self.imageView fadeImageWithUrl:entryList.pic1];
}

@end
