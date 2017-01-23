//
//  BTLikesUserCell.m
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTLikesUserCell.h"
#import "BTSubjectAuthor.h"
#import <UIButton+WebCache.h>
#import "BTNoHLbutton.h"
#import <Masonry.h>
#import "BTProduct.h"

@interface BTLikesUserCell()

@property (nonatomic, weak) BTNoHLbutton *iconButton;

@property (nonatomic, weak) UILabel *nameLabel;

@end

@implementation BTLikesUserCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const reuseId = @"likesUserCell";
    BTLikesUserCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[BTLikesUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        BTNoHLbutton *iconButton = [[BTNoHLbutton alloc] init];
        iconButton.layer.cornerRadius = 15.0f;
        iconButton.layer.masksToBounds = YES;
        [self.contentView addSubview:iconButton];
        [iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        self.iconButton = iconButton;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = kUIColorFromRGB(0x757575);
        nameLabel.font = BTFont(14);
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconButton.mas_right).offset(10);
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        self.nameLabel = nameLabel;
    }
    return self;
}

- (void)setAuthor:(BTSubjectAuthor *)author
{
    _author = author;
    
    [self.iconButton sd_setImageWithURL:[NSURL URLWithString:author.avatar]
                               forState:UIControlStateNormal
                       placeholderImage:[UIImage imageNamed:@"default_icon_placehodler"]];
    
    self.nameLabel.text = author.nickname;
}
@end
