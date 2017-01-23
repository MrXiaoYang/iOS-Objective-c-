//
//  BTMessageOptionCell.m
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTOptionCell.h"
#import <Masonry.h>
#import "BTOption.h"

@interface BTOptionCell ()
{
    UIImageView *_imageView;
    UILabel *_nameLabel;
    UILabel *_rightLabel;
    UIView *_diverLine;
}
@end

@implementation BTOptionCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const reuseId = @"optionCell";
    BTOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[BTOptionCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(self.contentView);
            make.width.mas_equalTo(48);
        }];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = kUIColorFromRGB(0xFF666666);
        _nameLabel.font = BTFont(14);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_imageView.mas_right);
            make.top.bottom.mas_equalTo(self.contentView);
            make.width.mas_equalTo(150);
        }];
        
        UIImageView *arrowIcon = [[UIImageView alloc] init];
        arrowIcon.contentMode = UIViewContentModeCenter;
        arrowIcon.image = [UIImage imageNamed:@"arrow_add_friend"];
        [self.contentView addSubview:arrowIcon];
        [arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
            make.size.mas_equalTo(CGSizeMake(7, 13));
        }];
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = kUIColorFromRGB(0xFF777777);
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.font = BTFont(12);
        [self.contentView addSubview:_rightLabel];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(14);
        }];
        
        _diverLine = [UIView new];
        _diverLine.backgroundColor = kUIColorFromRGB(0xFFEEEEEE);
        [self.contentView addSubview:_diverLine];
        [_diverLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(rx_SINGLE_LINE_WIDTH);
        }];
    }
    return self;
}

- (void)setOption:(BTOption *)option
{
    _option = option;
    
    _imageView.image = [UIImage imageNamed:option.icon];
    
    _nameLabel.text = option.name;
    
    [_rightLabel setHidden:!option.detailValue.length > 0];
    
    CGFloat detailValueW = [option.detailValue titleSizeWithfontSize:12
                                                             maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    [_rightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(detailValueW);
    }];
}

- (void)hideSpeatorLine:(BOOL)boolean
{
    [_diverLine setHidden:boolean];
}
@end
