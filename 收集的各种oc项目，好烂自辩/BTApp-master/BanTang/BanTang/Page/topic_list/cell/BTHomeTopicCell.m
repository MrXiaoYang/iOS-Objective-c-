//
//  BTHomeTopicCell.m
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTHomeTopicCell.h"
#import "BTHomeTopic.h"
#import <UIImageView+WebCache.h>
#import "BTNoHLbutton.h"
#import <Masonry.h>
@interface BTHomeTopicCell()

@property (weak, nonatomic)  BTNoHLbutton *likeButton;

@property (weak, nonatomic)  UILabel *titleLabel;

@end

@implementation BTHomeTopicCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *reuseId = @"topicCell";
    BTHomeTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[BTHomeTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self.contentView);
            make.height.mas_equalTo(200);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = BTFont(16);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = kUIColorFromRGB(0x777777);
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.iconView.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(kScreen_Width, 36));
        }];
        
        BTNoHLbutton *likeButton = [[BTNoHLbutton alloc] init];
        likeButton.titleLabel.font = BTFont(13);
        [likeButton setImage:[UIImage imageNamed:@"home_likes_icon"] forState:UIControlStateNormal];
        [likeButton setTitleColor:kUIColorFromRGB(0xc9c9c9) forState:UIControlStateNormal];
        [self.contentView addSubview:likeButton];
        self.likeButton = likeButton;
        [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(kScreen_Width, 28));
        }];
    }
    return self;
}

- (void)setTopic:(BTHomeTopic *)topic
{
    _topic = topic;
    
    [self.iconView fadeImageWithUrl:topic.pic];
    
    self.titleLabel.text = topic.title;
 
    [self.likeButton setTitle:topic.likes forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    

}
@end
