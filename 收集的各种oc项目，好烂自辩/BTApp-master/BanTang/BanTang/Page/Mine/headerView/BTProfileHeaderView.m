//
//  BTProfileHeaderView.m
//  BanTang
//
//  Created by Ryan on 15/12/9.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTProfileHeaderView.h"
#import "BTNoHLbutton.h"
#import "BTIconLabelView.h"
#import "BTDoubleTitleLabel.h"
#import "BTUserInfo.h"
#import "UIImage+bt_extension.h"
#import <UIButton+WebCache.h>
#import <Masonry.h>

@implementation BTProfileHeaderView
{
    UIImageView  *_coverImageView;
    UIImageView  *_bottomBackgroudImageView;
    BTNoHLbutton *_iconBtn;
    BTIconLabelView *_getLikeView;
    BTIconLabelView *_jingxuanView;
    UILabel      *_titleNameLabel;
    UILabel      *_nameLabel;
    UILabel      *_signLabel;
    UIView       *_bottomView;
}

+ (instancetype)headerView
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // 背景图片
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_coverImageView];
        [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(260);
        }];
        // 底部背景图片
        _bottomBackgroudImageView = [[UIImageView alloc] init];
        _bottomBackgroudImageView.contentMode = UIViewContentModeScaleToFill;
        UIImage *image = [UIImage rx_captureImageWithImageName:@"蒙版"];
        _bottomBackgroudImageView.image = image;
        [self addSubview:_bottomBackgroudImageView];
        [_bottomBackgroudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.height.mas_equalTo(80);
        }];
        // 头像
        _iconBtn = [[BTNoHLbutton alloc] init];
        _iconBtn.imageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_iconBtn];
        [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(72);
            make.centerX.mas_equalTo(self.centerX);
            make.size.mas_equalTo(CGSizeMake(64, 64));
        }];
        
        // 名字label
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.centerX);
            make.top.mas_equalTo(_iconBtn.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(200, 18));
        }];
        // 签名label
        _signLabel = [[UILabel alloc] init];
        _signLabel.font = BTFont(12);
        _signLabel.textAlignment= NSTextAlignmentCenter;
        _signLabel.textColor = kUIColorFromRGB(0xFFF6F6F6);
        [self addSubview:_signLabel];
        [_signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLabel.mas_bottom).offset(7);
            make.centerX.mas_equalTo(self.centerX);
            make.size.mas_equalTo(CGSizeMake(200, 14));
        }];
        // 获得的赞View
        _getLikeView = [[BTIconLabelView alloc] init];
        _getLikeView.iconImageName = @"center_head_like_icon";
        [self addSubview:_getLikeView];
        [_getLikeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.right.mas_equalTo(_iconBtn.mas_left).offset(-44);
            make.centerY.mas_equalTo(_iconBtn.centerY).offset(-10);
        }];
        // 获得的精选View
        _jingxuanView = [[BTIconLabelView alloc] init];
        _jingxuanView.iconImageName = @"center_head_recommend_icon";
        [self addSubview:_jingxuanView];
        [_jingxuanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.left.mas_equalTo(_iconBtn.mas_right).offset(44);
            make.centerY.mas_equalTo(_iconBtn.centerY).offset(-10);
        }];
        // 推到上面显示在navbar上面的名字Label
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.font = BTFont(15);
        [self addSubview:_titleNameLabel];
        [_titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.centerX);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
            make.size.mas_equalTo(CGSizeMake(200, 17.5));
        }];
        [_titleNameLabel setHidden:YES];
        
        [self setupBottomView];
    }
    return self;
}

- (void)setupBottomView
{
    _bottomView = [UIView new];
    _bottomView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(35);
        make.bottom.mas_equalTo(self).offset(-15);
    }];
    CGFloat doubleLabelX = 0;
    CGFloat doubleLabelY = 0;
    CGFloat doubleLabelW = kScreen_Width / 4;
    CGFloat doubleLabelH = 35;
    
    NSArray *titleArray = @[@"积分",@"关注",@"粉丝",@"成就"];
    for (NSInteger index = 0; index<4; index++) {
        BTDoubleTitleLabel *doubleLabel = [[BTDoubleTitleLabel alloc] init];
        doubleLabel.title = titleArray[index];
        doubleLabelX = index * doubleLabelW;
        doubleLabel.frame = CGRectMake(doubleLabelX, doubleLabelY, doubleLabelW, doubleLabelH);
        [_bottomView addSubview:doubleLabel];
    }
}

- (void)setUserInfo:(BTUserInfo *)userInfo
{
    NSURL *iconURL = [NSURL URLWithString:userInfo.avatar];
    UIImage *placeholderImage = [[UIImage imageNamed:@"default_user_icon"] rx_circleImage];
    [_iconBtn sd_setImageWithURL:iconURL forState:UIControlStateNormal
                placeholderImage:placeholderImage
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
                           UIImage *borderImage = [image circleBorderWidth:5 borderColor:[UIColor whiteColor]];
                           
                           [_iconBtn setImage:borderImage forState:UIControlStateNormal];
                       }];    
    [_coverImageView fadeImageWithUrl:userInfo.userCover];

    _nameLabel.text = userInfo.nickname;
    _signLabel.text = userInfo.userSign;
    _getLikeView.num = userInfo.postLike;
    _jingxuanView.num = userInfo.postRec;
    NSArray *numArray = @[userInfo.credits,userInfo.attentions,userInfo.fans,userInfo.badges];
    NSInteger index = 0;
    
    for (BTDoubleTitleLabel *doubleLabel in _bottomView.subviews) {
        doubleLabel.num = numArray[index];
        index++;
    }
}
@end


