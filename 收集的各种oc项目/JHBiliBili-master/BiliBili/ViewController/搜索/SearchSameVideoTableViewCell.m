//
//  SearchSameVideoTableViewCell.m
//  BiliBili
//
//  Created by JimHuang on 15/12/14.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "SearchSameVideoTableViewCell.h"
@interface SearchSameVideoTableViewCell()
@property (nonatomic, strong) UIImageView* coverImageView;
@property (nonatomic, strong) UIImageView* playIcon;
@property (nonatomic, strong) UIImageView* danMuIcon;
@property (nonatomic, strong) UIView* blackView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* UPLabel;
@property (nonatomic, strong) UILabel* playLabel;
@property (nonatomic, strong) UILabel* danMuLabel;
@end

@implementation SearchSameVideoTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel.text = @"";
        self.blackView.hidden = NO;
        self.playLabel.text = @"";
        self.danMuLabel.text = @"";
        self.UPLabel.text = @"";
        self.contentView.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"lightBackGroundColor"];
    }
    return self;
}

- (void)setWithDic:(NSDictionary*)dic{
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString: @"coverImageView"]) {
            [self.coverImageView setImageWithURL: obj];
        }else{
            [self setValue:obj forKeyPath:key];
        }
    }];
}

#pragma mark - 懒加载
- (UIImageView*)coverImageView{
    if (_coverImageView== nil) {
        _coverImageView = [[UIImageView alloc] init];
        [self addSubview: _coverImageView];
        [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(106);
            make.height.mas_equalTo(66);
            make.top.left.mas_offset(10);
            make.bottom.mas_offset(-10);
        }];
    }
    return _coverImageView;
}

- (UILabel*)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        _titleLabel.lineBreakMode = NSLineBreakByClipping;
        _titleLabel.font = [UIFont systemFontOfSize: 13];
        [self addSubview: _titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.coverImageView.mas_top).mas_offset(5);
            make.left.mas_equalTo(self.coverImageView.mas_right).mas_offset(10);
            make.right.mas_offset(-10);
        }];
    }
    return _titleLabel;
}

- (UIView*)blackView{
    if (_blackView == nil) {
        _blackView = [[UIView alloc] init];
        _blackView.backgroundColor = kRGBAColor(0, 0, 0, 0.5);
        [self addSubview: _blackView];
        [_blackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.coverImageView);
            make.height.mas_equalTo(20);
        }];
    }
    return _blackView;
}

- (UILabel*)UPLabel{
    if (_UPLabel == nil) {
        _UPLabel = [[UILabel alloc] init];
        _UPLabel.font = [UIFont systemFontOfSize: 13];
        _UPLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"assistantTextColor"];
        [self addSubview: _UPLabel];
        [_UPLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(5);
            make.left.equalTo(self.titleLabel);
            make.right.mas_offset(-10);
        }];
    }
    return _UPLabel;
}

- (UIImageView*)playIcon{
    if (_playIcon == nil) {
        _playIcon = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"list_playnumb_icon"]];
        [self.blackView addSubview: _playIcon];
        [_playIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(13);
            make.height.mas_equalTo(10);
            make.centerY.mas_offset(0);
            make.left.mas_offset(2);
        }];
    }
    return _playIcon;
}

- (UILabel*)playLabel{
    if (_playLabel == nil) {
        _playLabel = [UILabel new];
        [self.blackView addSubview: _playLabel];
        _playLabel.font = [UIFont systemFontOfSize: 10];
        _playLabel.textColor = [UIColor whiteColor];
        [_playLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_offset(0);
            make.left.mas_equalTo(self.playIcon.mas_right).mas_offset(2);
        }];
    }
    return _playLabel;
}

- (UIImageView*)danMuIcon{
    if (_danMuIcon == nil) {
        _danMuIcon = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"list_danmaku_icon"]];
        [self.blackView addSubview: _danMuIcon];
        [_danMuIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.centerY.equalTo(self.playIcon);
            make.right.mas_offset(-2);
        }];
    }
    return _danMuIcon;
}

- (UILabel*)danMuLabel{
    if (_danMuLabel == nil) {
        _danMuLabel = [UILabel new];
        _danMuLabel.textColor = [UIColor whiteColor];
        _danMuLabel.textAlignment = NSTextAlignmentRight;
        _danMuLabel.font = [UIFont systemFontOfSize: 10];
        [self.blackView addSubview: _danMuLabel];
        [_danMuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.danMuIcon.mas_left).mas_offset(-2);
            make.centerY.mas_offset(0);
            make.width.equalTo(self.playLabel);
        }];
    }
    return _danMuLabel;
}
@end
