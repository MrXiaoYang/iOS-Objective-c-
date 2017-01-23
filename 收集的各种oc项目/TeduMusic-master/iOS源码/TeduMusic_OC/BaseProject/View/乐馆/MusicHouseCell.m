//
//  MusicHouseCell.m
//  BaseProject
//
//  Created by jiyingxin on 15/12/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MusicHouseCell.h"

@implementation MusicHouseCell

- (IBAction)clickChoose:(id)sender {
    [_delegate musicHouseCell:self selectedItem:MusicItemTypeChoose];//1
}

- (IBAction)clickRank:(id)sender {
    [_delegate musicHouseCell:self selectedItem:MusicItemTypeRank];//2
}

- (IBAction)clickMedia:(id)sender {
    [_delegate musicHouseCell:self selectedItem:MusicItemTypeMedia];//3
}

- (IBAction)clickCommunity:(id)sender {
    [_delegate musicHouseCell:self selectedItem:MusicItemTypeCommunity];//4
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
