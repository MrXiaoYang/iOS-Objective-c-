//
//  BTCommunityTitleView.m
//  BanTang
//
//  Created by Ryan on 15/12/7.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTCommunityTitleView.h"

@interface BTCommunityTitleView()

@property (weak, nonatomic) IBOutlet UIButton *jingxuanBtn;

@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;

@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation BTCommunityTitleView

- (void)awakeFromNib
{
    self.jingxuanBtn.titleLabel.font = BTFont(16);
    
    self.attentionBtn.titleLabel.font = BTFont(16);
    
    [self.jingxuanBtn setTitleColor:kUIColorFromRGB(0xFFFFFFFF)
                           forState:UIControlStateSelected];
    [self.jingxuanBtn setTitleColor:kUIColorFromRGB(0xFFFFB4B4)
                           forState:UIControlStateNormal];
    [self.attentionBtn setTitleColor:kUIColorFromRGB(0xFFFFFFFF)
                            forState:UIControlStateSelected];
    [self.attentionBtn setTitleColor:kUIColorFromRGB(0xFFFFB4B4)
                            forState:UIControlStateNormal];
}

+ (instancetype)titleView
{
    return [NSBundle rx_loadXibNameWith:@"BTCommunityTitleView"];
}

- (IBAction)btnClick:(UIButton *)sender
{
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
    
    if (self.didClickBlock) {
        self.didClickBlock(sender.tag);
    }
}


@end
