//
//  BTListPostBottomView.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/29.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTListPostBottomView.h"
#import "BTListPostDynamic.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "BTNoHLbutton.h"
#import "BTUserInfo.h"

@interface BTListPostBottomView()

@property (nonatomic, weak) UIButton *likeButton;

@end

@implementation BTListPostBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(32, 32));
        }];
        BTUserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:kUserInfoPath];
        
        NSURL *avatarURL = [NSURL URLWithString:userInfo.avatar];
        UIImage *placeholderImage = [[UIImage imageNamed:@"default_user_icon"] rx_circleImage];
        
        [iconView sd_setImageWithURL:avatarURL
                    placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                        if (image == nil) return;
                        
                        // 获得上下文中的图片
                        iconView.image = [image rx_circleImage];
                    }];
        
        UIButton *likeButton = [[UIButton alloc] init];
        [likeButton setImage:[UIImage imageNamed:@"community_detail_like_btn"]
                    forState:UIControlStateNormal];
        [likeButton setImage:[UIImage imageNamed:@"community_detail_like"]
                    forState:UIControlStateSelected];
        [likeButton addTarget:self action:@selector(likeButtonDidClick:)
             forControlEvents:UIControlEventTouchDown];
        [self addSubview:likeButton];
        [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.right.mas_equalTo(self.mas_right).offset(-10);
        }];
        self.likeButton = likeButton;
        
        UIView *diverLine = [UIView new];
        diverLine.backgroundColor = kUIColorFromRGB(0xeeeeee);
        [self addSubview:diverLine];
        [diverLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(16);
            make.right.mas_equalTo(likeButton.mas_left).offset(-14);
        }];
        
        UIImage *image = [UIImage rx_captureImageWithImageName:@"community_commnetinput_bg"];
        BTNoHLbutton *btn = [[BTNoHLbutton alloc] init];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"      我来说两句" forState:UIControlStateNormal];
        btn.titleLabel.font = BTFont(11);
        [btn setTitleColor:kUIColorFromRGB(0xc0c0c6) forState:UIControlStateNormal];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconView.mas_right).offset(9);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(32);
            make.right.mas_equalTo(diverLine.mas_left).offset(-13);
        }];
    }
    return self;
}

- (void)likeButtonDidClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(listPostBottomViewDidClickLikeButton:)]) {
        [self.delegate listPostBottomViewDidClickLikeButton:self];
    }
}

- (void)setCollect:(BOOL)isCollect
{
    _collect = isCollect;
    
    self.dynamic.isCollect = isCollect;
    NSInteger newCount = [self.dynamic.likes integerValue];
    newCount = isCollect? newCount + 1 : newCount - 1;
    if (newCount <0) newCount = 0;
    if (isCollect && newCount < 1)  newCount = 1;
    
    // 更新数据源
    self.dynamic.likes = [NSString stringWithFormat:@"%zd",newCount];
    [self.likeButton setSelected:isCollect];
}

- (void)setDynamic:(BTListPostDynamic *)dynamic
{
    _dynamic = dynamic;
    
    [self.likeButton setSelected:dynamic.isCollect];
}

- (void)btnClick
{
    if ([self.delegate respondsToSelector:@selector(listPostBottomViewDidClickCommentButton:)]) {
        [self.delegate listPostBottomViewDidClickCommentButton:self];
    }
}


@end
