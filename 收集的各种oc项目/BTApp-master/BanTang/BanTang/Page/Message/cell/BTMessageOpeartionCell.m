//
//  BTMessageOpeartionCell.m
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTMessageOpeartionCell.h"
#import <Masonry.h>
#import "BTFirstpageElement.h"

@implementation BTMessageOpeartionCell
{
    UIImageView *_imageView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const reuseId = @"messageOpeartionCell";
    BTMessageOpeartionCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[BTMessageOpeartionCell alloc] initWithStyle:UITableViewCellStyleDefault
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
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(10);
            make.right.mas_equalTo(self.contentView).offset(-10);
            make.height.mas_equalTo(143);
        }];
    }
    return self;
}

- (void)setElement:(BTFirstpageElement *)element
{
    _element = element;
    
    [_imageView fadeImageWithUrl:element.photo];
}

@end

@implementation BTMessageDiverLabelCell
{
    UILabel *_titleLabel;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const reuseId = @"messageDiverLabelCell";
    BTMessageDiverLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[BTMessageDiverLabelCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kUIColorFromRGB(0xFFF5F5F5);
        
        UIView *backgourndView = [UIView new];
        backgourndView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backgourndView];
        [backgourndView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 0, 0));
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kUIColorFromRGB(0xFF666666);
        _titleLabel.font = BTFont(15);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [backgourndView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 10, 0, 0));
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}


@end
