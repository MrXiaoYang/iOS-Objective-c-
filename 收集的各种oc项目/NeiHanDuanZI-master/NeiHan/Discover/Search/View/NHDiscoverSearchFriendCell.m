//
//  NHDiscoverSearchFriendCell.m
//  NeiHan
//
//  Created by Charles on 16/9/2.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDiscoverSearchFriendCell.h"
#import "NHCustomTopImageButton.h"
#import "UIView+Layer.h"
#import "NHNeiHanUserInfoModel.h"
#import "UIButton+WebCache.h"
#import "UIView+Layer.h"
#import "UIView+Tap.h"

@interface NHDiscoverSearchFriendCommonView : UIView
@property (nonatomic, weak) NHBaseImageView *iconImg;
@property (nonatomic, weak) UILabel *nameL;
@property (nonatomic, copy) NSString *iconname;
@property (nonatomic, strong) UIImage *image;
- (void)setName:(NSString *)name keyWord:(NSString *)keyWord;
@end

@implementation NHDiscoverSearchFriendCommonView

- (void)setImage:(UIImage *)image {
    _image = image;
    self.iconImg.image = image;
}

- (void)setIconname:(NSString *)iconname {
    _iconname = iconname;
    [self.iconImg setImageWithURL:[NSURL URLWithString:iconname]];
}

- (void)setName:(NSString *)name keyWord:(NSString *)keyWord {
    NSMutableAttributedString *string = [NHUtils attStringWithString:name keyWord:keyWord font:kFont(11) highlightedColor:kRedColor textColor:kBlackColor].mutableCopy;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    [string addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
    self.nameL.attributedText = string.copy;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat nameH = 15;
    CGFloat nameX = 10;
    CGFloat nameY = self.height - 20;
    CGFloat nameW = self.width - 20;
    self.nameL.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat iconX = 10;
    CGFloat iconY = 10;
    CGFloat iconW = 44;
    CGFloat iconH = iconW;
    self.iconImg.frame = CGRectMake(iconX, iconY, iconW, iconH);
    self.iconImg.layerCornerRadius = iconW / 2.0;
    self.iconImg.centerX = self.width / 2.0;
}

- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _nameL = label;
        label.font = kFont(14);
        label.textColor = kCommonBlackColor;
    }
    return _nameL;
}

- (NHBaseImageView *)iconImg {
    if (!_iconImg) {
        NHBaseImageView *img = [[NHBaseImageView alloc] init];
        [self addSubview:img];
        _iconImg = img;
    }
    return _iconImg;
}
@end

@interface NHDiscoverSearchFriendCell ()
@property (nonatomic, weak) NHBaseImageView *iconImg;
@property (nonatomic, weak) UILabel *nameL;
@property (nonatomic, weak) UILabel *contentL;
@property (nonatomic, weak) CALayer *line;
@end

@implementation NHDiscoverSearchFriendCell

- (void)setModels:(NSArray <NHNeiHanUserInfoModel *>*)models {
    _models = models;
    
    // 移除所有的子视图
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    NSInteger count = 0;
    if (models.count > 5) {
        count = 5;
    } else {
        count = models.count;
    }
    
    for (int i = 0 ; i < count; i++) {
        
        NHNeiHanUserInfoModel *model = models[i];
        if (i == 0) {
            
            NHBaseImageView *img = [[NHBaseImageView alloc] init];
            [self.contentView addSubview:img];
            _iconImg = img;
            img.contentMode = UIViewContentModeScaleAspectFill;
            img.clipsToBounds = YES;
            [img sd_setImageWithURL:[NSURL URLWithString:model.avatar_url]];
            img.tag = i + 1;
            img.userInteractionEnabled = YES;
            [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapGest:)]];
            
            UILabel *name = [[UILabel alloc] init];
            [self.contentView addSubview:name];
            _nameL = name;
            name.font = kFont(14);
            name.textColor = kBlackColor;
            name.attributedText = [NHUtils attStringWithString:model.name keyWord:self.keyWord font:kFont(13) highlightedColor:kRedColor textColor:kBlackColor];
            
            UILabel *content = [[UILabel alloc] init];
            [self.contentView addSubview:content];
            _contentL = content;
            content.font = kFont(13);
            content.textColor = kCommonBlackColor;
            content.text = model.desc;
            
            CALayer *line = [CALayer layer];
            [self.contentView.layer addSublayer:line];
            _line = line;
            line.backgroundColor = [kCommonBlackColor CGColor];
        } else {
            
            if (i == count - 1) {
                
                NHDiscoverSearchFriendCommonView *view = [[NHDiscoverSearchFriendCommonView alloc] init];
                [self.contentView addSubview:view];
                view.tag = i + 1;
                [view setName:@"更多段友" keyWord:nil];
                view.image = [UIImage imageNamed:@"morefriends"];
                WeakSelf(weakSelf);
                [view setTapActionWithBlock:^{
                    if (weakSelf.discoverSearchFriendCellMoreFriends) {
                        weakSelf.discoverSearchFriendCellMoreFriends();
                    }
                }];
            } else {
                NHDiscoverSearchFriendCommonView *view = [[NHDiscoverSearchFriendCommonView alloc] init];
                [self.contentView addSubview:view];
                view.tag = i + 1;
                view.userInteractionEnabled = YES;
                [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapGest:)]];
                view.iconname = model.avatar_url;
                [view setName:model.screen_name keyWord:self.keyWord];
            }
        }
    }
    
    [self setNeedsLayout];
}

- (void)imgTapGest:(UITapGestureRecognizer *)tapGest {
    NSInteger index = tapGest.view.tag - 1;
    NHNeiHanUserInfoModel *userInfo = self.models[index];
    if (self.discoverSearchFriendCellGotoPersonalCenter) {
        self.discoverSearchFriendCellGotoPersonalCenter(userInfo.user_id);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 头像
    self.iconImg.frame = CGRectMake(15, 15, 44, 44);
    self.iconImg.layerCornerRadius = self.iconImg.height / 2.0;
    
    // 名字
    self.nameL.frame = CGRectMake(self.iconImg.right + 10, 15, kScreenWidth - self.iconImg.right - 10, 15);
    
    // 文本
    self.contentL.frame = CGRectMake(self.nameL.left, self.nameL.bottom + 10, self.nameL.width, 15);
    
    self.line.frame = CGRectMake(0, self.iconImg.bottom + 10, kScreenWidth, kLineHeight);
    
    // 更多段友
    NSInteger count = 0;
    if (self.models.count > 5) {
        count = 5;
    } else {
        count = self.models.count;
    }
    for (int i = 0 ; i < count; i++) {
        if (i > 0) {
            NSInteger tag = i + 1;
            NHDiscoverSearchFriendCommonView *view = (NHDiscoverSearchFriendCommonView *)[self.contentView viewWithTag:tag];
            view.frame = CGRectMake((tag - 2) * kScreenWidth / 4.0, self.iconImg.bottom + 11, kScreenWidth / 4, self.contentView.height - self.line.frame.origin.y - self.line.frame.size.height);
            
        }
    }
}
@end
