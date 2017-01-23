//
//  BTSubjectRankCell.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/28.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTSubjectRankCell.h"
#import "BTSubjectRankAuthor.h"
#import <UIImageView+WebCache.h>
@interface BTSubjectRankCell()
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIImageView *rankImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@end

@implementation BTSubjectRankCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const reuseId = @"cell";
    BTSubjectRankCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [NSBundle rx_loadXibNameWith:@"BTSubjectRankCell"];
    }
    return cell;
}

- (IBAction)concernBtnDidClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(subjectRankCell:didClickAttentionButtonWithAuthor:)]) {
        [self.delegate subjectRankCell:self didClickAttentionButtonWithAuthor:self.rankAuthor];
    }
}

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setRankAuthor:(BTSubjectRankAuthor *)rankAuthor
{
    _rankAuthor = rankAuthor;
    
    NSURL *avatarURL = [NSURL URLWithString:rankAuthor.avatar];
    UIImage *placeholderImage = [[UIImage imageNamed:@"default_icon_placehodler"] rx_circleImage];
    
    [self.iconImageView sd_setImageWithURL:avatarURL
                          placeholderImage:placeholderImage
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                              // 如果图片下载失败，就不做任何处理，按照默认的做法：显示占位图片
                              // 下面这句代码的意义是很大的
                              if (image == nil) return;
                              
                              // 获得上下文中的图片
                              self.iconImageView.image = [image rx_circleImage];
                              
                          }];
    
    self.nickNameLabel.text = rankAuthor.nickname;
    self.rateLabel.text = [NSString stringWithFormat:@"好物热度:%zd",rankAuthor.partInRate];
    NSString *imageName = [NSString stringWithFormat:@"rank_%zd",rankAuthor.partInRankNo];
    [self.rankImageView setImage:[UIImage imageNamed:imageName]];
    
    if (rankAuthor.attentionType == 0) {
        [self.attentionBtn setImage:[UIImage imageNamed:@"attetion_icon"] forState:UIControlStateNormal];
    }else if (rankAuthor.attentionType == 1){
        [self.attentionBtn setImage:[UIImage imageNamed:@"attetion_0_icon"] forState:UIControlStateNormal];
    }else{
        [self.attentionBtn setImage:[UIImage imageNamed:@"attetion_0_0_icon"] forState:UIControlStateNormal];
    }
}

- (void)setAttention:(BOOL)attention
{
    if (attention) {
         [self.attentionBtn setImage:[UIImage imageNamed:@"attetion_0_icon"] forState:UIControlStateNormal];
    }else{
        [self.attentionBtn setImage:[UIImage imageNamed:@"attetion_icon"] forState:UIControlStateNormal];
    }
}

@end
