//
//  BTSubjectHeaderView.m
//  BanTang
//
//  Created by Ryan on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTSubjectHeaderView.h"
#import <UIImageView+WebCache.h>
#import "BTCommunitySubject.h"
#import "BTSubjectDynamic.h"
#import "BTSubjectAuthor.h"
#import "BTSubjectRankAuthor.h"
@interface BTSubjectHeaderView()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIButton *joinNumBtn;
@property (weak, nonatomic) IBOutlet UIImageView *userAvaterIcon;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *noFirsAvaterImageView;
@property (weak, nonatomic) IBOutlet UIView *rankListView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation BTSubjectHeaderView

+ (instancetype)headerView
{
    return [NSBundle rx_loadXibNameWith:@"BTSubjectHeaderView"];
}

- (void)awakeFromNib
{
    self.joinNumBtn.layer.cornerRadius = 3.0f;
    self.joinNumBtn.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewDidClick)];
    [self.bottomView addGestureRecognizer:tap];
}

- (void)bottomViewDidClick
{
    if (self.rankListDidClickBlock) {
        self.rankListDidClickBlock();
    }
}

- (void)setSubject:(BTCommunitySubject *)subject
{
    _subject = subject;
    
    [self.topImageView fadeImageWithUrl:subject.pic2];
    
    NSString *title = [NSString stringWithFormat:@"%@人参加",subject.dynamic.partInNum];
    [self.joinNumBtn setTitle:title forState:UIControlStateNormal];
    
    [self.userAvaterIcon sd_setImageWithURL:[NSURL URLWithString:subject.author.avatar]
                           placeholderImage:[[UIImage imageNamed:@"default_user_icon"] rx_circleImage]
     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         if (image == nil) return;
         self.userAvaterIcon.image = [image rx_circleImage];
     }];
    
    self.userNameLabel.text = subject.author.nickname;
    self.publishTimeLabel.text = subject.datestr;
    self.contentLabel.text = subject.desc;
    
    NSArray *rankList = subject.dynamic.rankList;
    if (rankList.count>0) {
        BTSubjectRankAuthor *rankAuthor = rankList[0];
        [self.noFirsAvaterImageView sd_setImageWithURL:[NSURL URLWithString:rankAuthor.avatar]
                                      placeholderImage:[[UIImage imageNamed:@"default_user_icon"] rx_circleImage]
                                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                 if (image == nil) return;
                                                 self.noFirsAvaterImageView.image = [image rx_circleImage];
                                         }];
    }
    
    [self addRankListIcon];
}

- (void)addRankListIcon
{
    NSArray *rankList = self.subject.dynamic.rankList;
    
    if (rankList.count > 6) {
        [self addImageViewWithBoolean:NO];
    }else{
        [self addImageViewWithBoolean:YES];
    }
}

- (void)addImageViewWithBoolean:(BOOL)boolean
{
    NSArray *rankList = self.subject.dynamic.rankList;
    NSInteger count = 5;
    if (boolean) {
        count = rankList.count;
    }
    for (NSInteger index = 0; index < count; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = 16.0f;
        imageView.layer.masksToBounds = YES;
        [self.rankListView addSubview:imageView];
    }
}

- (void)layoutSubviews
{
    CGFloat padding = 8;
    CGFloat imageViewWH = 32;
    CGFloat imageViewY = 17;
    
    for (NSInteger index = 0; index<self.rankListView.subviews.count; index++)
    {
        NSArray *rankList = self.subject.dynamic.rankList;
        if (index+1 >=rankList.count) {
            return;
        }else{
            BTSubjectRankAuthor *author = rankList[index + 1];
            UIImageView *imageView = self.rankListView.subviews[index];
            NSURL *url = [NSURL URLWithString:author.avatar];
            UIImage *placeholderImage = [[UIImage imageNamed:@"default_user_icon"] rx_circleImage];
            [imageView sd_setImageWithURL:url
                         placeholderImage:placeholderImage
             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                 if (image == nil) return ;
                imageView.image = [image rx_circleImage];
             }];
            
            CGFloat imageViewX = index * (imageViewWH + padding);
            imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWH, imageViewWH);
        }
    }
}


@end
