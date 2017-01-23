//
//  BTMessageListCell.m
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTMessageListCell.h"
#import "BTNoHLbutton.h"
#import <Masonry.h>
#import <UIButton+WebCache.h>
#import "BTMessageNotice.h"
@implementation BTMessageListCell
{
    BTNoHLbutton *_iconBtn;
    UILabel *_nameLabel;
    UILabel *_datestringLabel;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const reuseId = @"messageListCell";
    BTMessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[BTMessageListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _iconBtn = [[BTNoHLbutton alloc] init];
        [self.contentView addSubview:_iconBtn];
        [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.contentView).offset(15);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = kUIColorFromRGB(0xFF5D9CBC);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = BTFont(12);
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconBtn.mas_right).offset(5);
            make.top.mas_equalTo(self.contentView).offset(20);
            make.size.mas_equalTo(CGSizeMake(177, 15));
        }];
        
        _datestringLabel = [[UILabel alloc] init];
        _datestringLabel.textColor = kUIColorFromRGB(0xFF919191);
        _datestringLabel.textAlignment = NSTextAlignmentLeft;
        _datestringLabel.font = BTFont(10);
        [self.contentView addSubview:_datestringLabel];
        [_datestringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLabel);
            make.top.mas_equalTo(_nameLabel.mas_bottom).offset(8);
            make.size.mas_equalTo(CGSizeMake(177, 12));
        }];

    }
    return self;
}

- (void)setNotice:(BTMessageNotice *)notice
{
    _notice = notice;
    
    UIImage *placeHolderImage = [[UIImage imageNamed:@"default_user_icon"] rx_circleImage];
    NSURL *avaterURL = [NSURL URLWithString:notice.srcUserAvatar];
    [_iconBtn sd_setImageWithURL:avaterURL
                        forState:UIControlStateNormal
                placeholderImage:placeHolderImage
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) [_iconBtn setImage:placeHolderImage forState:UIControlStateNormal];
        [_iconBtn setImage:[image rx_circleImage] forState:UIControlStateNormal];
    }];
    
    _nameLabel.text = notice.srcUserName;
    
    _datestringLabel.text = notice.datestr;
}


@end
