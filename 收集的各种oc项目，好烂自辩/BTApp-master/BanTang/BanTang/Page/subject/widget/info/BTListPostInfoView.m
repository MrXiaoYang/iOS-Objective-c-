//
//  BTself.listPostInfoView.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/29.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTListPostInfoView.h"
#import "BTListPost.h"
#import "BTNoHLbutton.h"
#import <Masonry.h>
#import <UIButton+WebCache.h>
#import <UIImageView+WebCache.h>
#import "BTSubjectAuthor.h"
#import "BTListPostPics.h"
#import "BTTag.h"
#import "BTSubjectListPostBottomView.h"
#import "BTListPostDynamic.h"

@interface BTListPostInfoView()
/** 头像 */
@property (nonatomic, weak) BTNoHLbutton *iconButton;
/** 昵称 */
@property (nonatomic, weak) UILabel *nickNameLabel;
/** 发布时间 */
@property (nonatomic, weak) UILabel *publishTimeLabel;
/** 关注按钮 */
@property (nonatomic, weak) UIButton *concernButton;
/** 大图 */
@property (nonatomic, weak) UIImageView *listPostImageView;
/** 内容 */
@property (nonatomic, weak) UILabel *contentLabel;
/** 标签View */
@property (nonatomic, weak) UIView *tagsView;
/** goodStampView */
@property (nonatomic, weak) UIImageView *goodStampsView;
/** tagsButton数组 */
@property (nonatomic, strong) NSMutableArray *tagsButtonArray;
/** 标签imageView */
@property (nonatomic, weak) UIImageView *tagView;

@end

@implementation BTListPostInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTopView];
        [self setupBottomView];
    }
    return self;
}

- (void)setupTopView
{
    BTNoHLbutton *iconButton = [[BTNoHLbutton alloc] init];
    iconButton.backgroundColor = [UIColor redColor];
    iconButton.layer.cornerRadius = 16;
    iconButton.layer.masksToBounds = YES;
    [iconButton addTarget:self
                   action:@selector(iconButtonDidClick)
         forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:iconButton];
    self.iconButton = iconButton;
    
    UILabel *nickNameLabel = [[UILabel alloc] init];
    nickNameLabel.font = BTFont(14);
    nickNameLabel.textColor = kUIColorFromRGB(0x8c8c8c);
    [self addSubview:nickNameLabel];
    self.nickNameLabel = nickNameLabel;
    
    UILabel *publishTimeLabel = [[UILabel alloc] init];
    publishTimeLabel.font = BTFont(13);
    publishTimeLabel.textColor = kUIColorFromRGB(0xdddddd);
    [self addSubview:publishTimeLabel];
    self.publishTimeLabel = publishTimeLabel;
    
    UIButton *concernButton = [[UIButton alloc] init];
    [concernButton addTarget:self
                      action:@selector(attentionButtonDidClick)
            forControlEvents:UIControlEventTouchUpInside];
    [concernButton setImage:[UIImage imageNamed:@"attetion_icon"]
                   forState:UIControlStateNormal];
    [self addSubview:concernButton];
    self.concernButton = concernButton;
    
    UIImageView *goodStapmsView = [[UIImageView alloc] init];
    goodStapmsView.image = [UIImage imageNamed:@"community_good_stamps"];
    [self addSubview:goodStapmsView];
    self.goodStampsView = goodStapmsView;
    
    UIImageView *listPostImageView = [[UIImageView alloc] init];
    self.listPostImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:listPostImageView];
    self.listPostImageView = listPostImageView;
}

- (void)setupBottomView
{
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = BTFont(14);
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = kUIColorFromRGB(0x8c8c8c);
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UIView *tagsView = [UIView new];
    [self addSubview:tagsView];
    self.tagsView = tagsView;
    
    UIImageView *tag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"community_tag"]];
    [self.tagsView addSubview:tag];
    self.tagView = tag;
}

- (void)setListPost:(BTListPost *)listPost
{
    _listPost = listPost;
    
    [self.iconButton sd_setImageWithURL:[NSURL URLWithString:listPost.author.avatar]
                               forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_user_icon"]];
    
    [self.goodStampsView setHidden:![listPost.isRecommend isEqualToString:@"1"]];
    
    BTSubjectAuthor *author = listPost.author;
    if (author.attentionType == 0) {
        [self.concernButton setImage:[UIImage imageNamed:@"attetion_icon"] forState:UIControlStateNormal];
    }else if (author.attentionType == 1){
        [self.concernButton setImage:[UIImage imageNamed:@"attetion_0_icon"] forState:UIControlStateNormal];
    }else{
        [self.concernButton setImage:[UIImage imageNamed:@"attetion_0_0_icon"] forState:UIControlStateNormal];
    }
    
    self.nickNameLabel.text = listPost.author.nickname;
    
    self.publishTimeLabel.text = listPost.datestr;
    
    BTListPostPics *pic = listPost.pics[0];
    [self.listPostImageView fadeImageWithUrl:pic.url];
//    [self.listPostImageView sd_setImageWithURL:[NSURL URLWithString:pic.url]
//                              placeholderImage:[UIImage imageNamed:@"defaut_loading_icon"]];
    
    self.contentLabel.text = listPost.content;
    
    NSArray *tags = listPost.tags;
    
    if (self.tagsButtonArray.count>0) return;
    
    for (NSInteger index = 0; index<tags.count; index++)
    {
        BTTag *tag = tags[index];
        BTNoHLbutton *button = [[BTNoHLbutton alloc] init];
        button.tag = index;
        [button addTarget:self action:@selector(tagButtonDidClick:)
                     forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = BTFont(13);
        [button setTitle:tag.name forState:UIControlStateNormal];
        [button setTitleColor:kUIColorFromRGB(0xd18a8e) forState:UIControlStateNormal];
        [self.tagsView addSubview:button];
        [self.tagsButtonArray addObject:button];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconButton.frame = CGRectMake(10, 15, 32, 32);
    
    self.listPostImageView.frame = CGRectMake(0,
                                             CGRectGetMaxY(self.iconButton.frame) + 14,
                                             kScreen_Width,
                                             377);
    
    CGFloat btnW = 75;
    CGFloat btnX = (kScreen_Width - btnW - 10);
    self.concernButton.frame = CGRectMake(btnX, 17, btnW, 25);
    
    CGFloat goodStampWH = 27;
    self.goodStampsView.frame = CGRectMake(btnX - goodStampWH - 10, 17, goodStampWH, goodStampWH);
    
    self.nickNameLabel.frame =CGRectMake(self.iconButton.right + 5,
                                         self.iconButton.top,
                                         200,
                                         15);
    
    self.publishTimeLabel.frame = CGRectMake(self.nickNameLabel.left,
                                             CGRectGetMaxY(self.nickNameLabel.frame) + 5,
                                             200,
                                             15);
    
    CGFloat contentH = [self.listPost.content titleSizeWithfontSize:14
                                                            maxSize:CGSizeMake(kScreen_Width - 2 * 18, MAXFLOAT)].height;
    
    self.contentLabel.frame = CGRectMake(18,
                                         CGRectGetMaxY(self.listPostImageView.frame) + 15,
                                         kScreen_Width-2*18,
                                         contentH);
    
    self.tagsView.frame = CGRectMake(0,
                                     CGRectGetMaxY(self.contentLabel.frame) + 15,
                                     kScreen_Width,
                                     15);
    
    CGFloat btnH = 15;
    CGFloat padding = 10;
    NSInteger count = self.tagsButtonArray.count;
    
    for (NSInteger index = 0; index<count; index++)
    {
        if (count>=6) padding = 8;
        BTNoHLbutton *lastButton = nil;
        if (index>0) lastButton = self.tagsButtonArray[index - 1];
        BTNoHLbutton *btn = self.tagsButtonArray[index];
        CGFloat btnW = [btn.currentTitle titleSizeWithfontSize:13 maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
        CGFloat btnX = lastButton ? padding + CGRectGetMaxX(lastButton.frame) : padding;
        CGFloat btnY = 0;
        if (btnW + btnX > kScreen_Width) {
            btnY = btnH;
            btnX = 0;
        }
        btn.frame = CGRectMake(15 + btnX, btnY, btnW, btnH);
        NSArray *tags = self.listPost.tags;
        BTTag *tag = tags[index];
        NSLog(@"%@的farme%@",tag.name,NSStringFromCGRect(btn.frame));
    }
    
    self.tagView.frame = CGRectMake(padding, 2, padding, padding);
}

- (void)setAttention:(BOOL)attention
{
    if (attention) {
        [self.concernButton setImage:[UIImage imageNamed:@"attetion_0_icon"]
                            forState:UIControlStateNormal];
    }else{
        [self.concernButton setImage:[UIImage imageNamed:@"attetion_icon"]
                            forState:UIControlStateNormal];
    }
}

- (NSMutableArray *)tagsButtonArray
{
    if (!_tagsButtonArray) {
        _tagsButtonArray = [NSMutableArray array];
    }
    return _tagsButtonArray;
}

- (void)iconButtonDidClick
{
    if ([self.delegate respondsToSelector:@selector(listInfoView:didClickIconButtonWithListPost:)]) {
        [self.delegate listInfoView:self didClickIconButtonWithListPost:self.listPost];
    }
}

- (void)attentionButtonDidClick
{
    if ([self.delegate respondsToSelector:@selector(listInfoView:didClickAttentionButtonWithListPost:)]) {
        [self.delegate listInfoView:self didClickAttentionButtonWithListPost:self.listPost];
    }
}

- (void)tagButtonDidClick:(UIButton *)tagButton
{
    if ([self.delegate respondsToSelector:@selector(listInfoView:didClickTag:)]) {
        [self.delegate listInfoView:self didClickTag:self.listPost.tags[tagButton.tag]];
    }
}
@end
