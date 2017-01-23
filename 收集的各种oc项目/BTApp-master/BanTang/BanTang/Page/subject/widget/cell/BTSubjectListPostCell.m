//
//  BTSubjectListPostCell.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/28.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTSubjectListPostCell.h"
#import "BTNoHLbutton.h"
#import <Masonry.h>
#import <UIButton+WebCache.h>
#import <UIImageView+WebCache.h>
#import "BTListPost.h"
#import "BTSubjectAuthor.h"
#import "BTListPostPics.h"
#import "BTTag.h"
#import "BTSubjectListPostBottomView.h"
#import "BTListPostDynamic.h"

static CGFloat const tagsViewHeight = 45.0f;
//水平 (左右之间的间距)
static CGFloat const horizontalPading = 10.0f;
//垂直 (上下之间的间距)
static CGFloat const verticalPading = 15.0f;

static CGFloat const listPostHeight = 377.0f;

@interface BTSubjectListPostCell()

/** 上面容器-> 最底端到图片(包含图片) */
@property (nonatomic, weak) UIView *topView;
/** 底部容器-> 内容Label、标签View、toolView*/
@property (nonatomic, weak) UIView *bottomView;
/** 最底部的toolView */
@property (nonatomic, weak) BTSubjectListPostBottomView *toolView;

@property (nonatomic, weak) BTNoHLbutton *iconButton;

@property (nonatomic, weak) UILabel *nickNameLabel;

@property (nonatomic, weak) UILabel *publishTimeLabel;

@property (nonatomic, weak) UIButton *concernButton;

@property (nonatomic, weak) UIImageView *listPostImageView;

@property (nonatomic, weak) UILabel *contentLabel;

@property (nonatomic, weak) UIImageView *goodStampsView;


@property (nonatomic, strong) UIView *tagsView;

@property (nonatomic, strong) NSMutableArray *tagsButtonArray;

@end

@implementation BTSubjectListPostCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const reuseId = @"subjectListPostCell";
    BTSubjectListPostCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[BTSubjectListPostCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        [self setupTopView];
        [self setuptoolView];
    }
    return self;
}

- (void)prepareForReuse
{
	[super prepareForReuse];

#warning 在这里需要清除按钮的数组,已经清除按钮,以防重叠.这里挖了的坑,好久才修复!!
	[self.tagsButtonArray removeAllObjects];
	
	for (UIView *subView in self.tagsView.subviews) {
		if ([subView isKindOfClass:[BTNoHLbutton class]]) {
			[subView removeFromSuperview];
		}
	}
}

- (void)setupTopView
{
    UIView *topView = [UIView new];
    [self.contentView addSubview:topView];
    self.topView = topView;
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
    }];
    
    UIView *bottomView = [UIView new];
    [self.contentView addSubview:bottomView];
    self.bottomView = bottomView;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(topView.mas_bottom);
    }];
    
    BTNoHLbutton *iconButton = [[BTNoHLbutton alloc] init];
    [iconButton addTarget:self action:@selector(iconButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:iconButton];
    [iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.left.mas_equalTo(horizontalPading);
        make.top.mas_equalTo(verticalPading);
    }];
    self.iconButton = iconButton;

    UILabel *nickNameLabel = [[UILabel alloc] init];
    nickNameLabel.font = BTFont(14);
    nickNameLabel.textColor = kUIColorFromRGB(0x8c8c8c);
    [self.topView addSubview:nickNameLabel];
    [nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconButton.mas_right).offset(10);
        make.top.mas_equalTo(verticalPading);
        make.height.mas_equalTo(verticalPading);
        make.width.mas_equalTo(200);
    }];
    self.nickNameLabel = nickNameLabel;
    
    UILabel *publishTimeLabel = [[UILabel alloc] init];
    publishTimeLabel.font = BTFont(13);
    publishTimeLabel.textColor = kUIColorFromRGB(0xdddddd);
    [self.topView addSubview:publishTimeLabel];
    [publishTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconButton.mas_right).offset(horizontalPading);
        make.top.mas_equalTo(self.nickNameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(verticalPading);
        make.width.mas_equalTo(200);
    }];
    self.publishTimeLabel = publishTimeLabel;
    
    UIButton *concernButton = [[UIButton alloc] init];
    [concernButton addTarget:self
                      action:@selector(attentionButtonDidClick)
            forControlEvents:UIControlEventTouchUpInside];
    
    [concernButton setImage:[UIImage imageNamed:@"attetion_icon"]
                   forState:UIControlStateNormal];
    [self.topView addSubview:concernButton];
    [concernButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75, 25));
        make.right.mas_equalTo(-horizontalPading);
        make.top.mas_equalTo(verticalPading);
    }];
    self.concernButton = concernButton;
    
    UIImageView *goodStapmsView = [[UIImageView alloc] init];
    goodStapmsView.image = [UIImage imageNamed:@"community_good_stamps"];
    [self.topView addSubview:goodStapmsView];
    [goodStapmsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(27, 27));
        make.top.mas_equalTo(verticalPading);
        make.right.mas_equalTo(self.concernButton.mas_left).offset(-5);
    }];
    self.goodStampsView = goodStapmsView;
    
    UIImageView *listPostImageView = [[UIImageView alloc] init];
    listPostImageView.contentMode = UIViewContentModeScaleToFill;
    [self.topView addSubview:listPostImageView];
    [listPostImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconButton.mas_bottom).offset(14);
        make.left.right.mas_equalTo(self.topView);
		make.height.mas_equalTo(listPostHeight);
    }];
    self.listPostImageView = listPostImageView;
    [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(listPostImageView.mas_bottom);
    }];
}

- (void)setuptoolView
{
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 3;
    contentLabel.font = BTFont(14);
    contentLabel.textColor = kUIColorFromRGB(0xFF777777);
    [self.bottomView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomView.mas_left).offset(horizontalPading);
        make.top.mas_equalTo(self.bottomView.mas_top).offset(horizontalPading);
        make.right.mas_equalTo(self.bottomView.mas_right).offset(-horizontalPading);
        make.height.mas_equalTo(58.5);
    }];
    self.contentLabel = contentLabel;
    
    UIView *tagsView = [[UIView alloc] init];
    [self.bottomView addSubview:tagsView];
    [tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(horizontalPading);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(horizontalPading);
        make.right.mas_equalTo(self.contentView).offset(-horizontalPading);
        make.height.mas_equalTo(tagsViewHeight);
    }];
    self.tagsView = tagsView;
    
    UIImageView *tag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"community_tag"]];
    [self.tagsView addSubview:tag];
    [tag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(horizontalPading, horizontalPading));
        make.left.mas_equalTo(self.tagsView.mas_left);
		make.centerY.mas_equalTo(self.tagsView.centerY);
    }];
	
    BTSubjectListPostBottomView *toolView = [BTSubjectListPostBottomView bottomView];
    __weak typeof(self) weakSelf = self;
    toolView.buyBlock = ^(){
        [weakSelf buyButtonDidClick];
    };
    toolView.commentBlock = ^(){
        [weakSelf commentButtonDidClick];
    };
    toolView.likeBlock = ^(){
        [weakSelf likeButtonDidClick];
    };
    [self.bottomView addSubview:toolView];
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tagsView.mas_bottom);
        make.left.right.mas_equalTo(self.bottomView);
        make.height.mas_equalTo(tagsViewHeight);
    }];
    self.toolView = toolView;
    
    UIView *topDiverView = [UIView new];
    topDiverView.backgroundColor = kUIColorFromRGB(0xf8f9fa);
    UIImage *shadowImage = [UIImage rx_captureImageWithImageName:@"community_cell_shadow"];
    UIImageView *shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 3)];
    shadowImageView.image = shadowImage;
    [topDiverView addSubview:shadowImageView];
    [self.bottomView addSubview:topDiverView];
    
    [shadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(topDiverView);
        make.height.mas_equalTo(3);
    }];
    
    [topDiverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(toolView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.bottomView);
        make.height.mas_equalTo(horizontalPading);
    }];
}

- (void)setListPost:(BTListPost *)listPost
{
    _listPost = listPost;
    
    NSURL *avatarURL = [NSURL URLWithString:listPost.author.avatar];
    UIImage *placeholderImage = [[UIImage imageNamed:@"default_user_icon"] rx_circleImage];
    
    [self.iconButton sd_setImageWithURL:avatarURL
                               forState:UIControlStateNormal
                       placeholderImage:placeholderImage
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   if (image == nil) return ;
                                  
                [self.iconButton setImage:[image rx_circleImage] forState:UIControlStateNormal];
                                  
                               }];
    
    
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
    
    self.contentLabel.text = listPost.content;
    CGFloat contentLabelH = [listPost.content titleSizeWithfontSize:14
                                                            maxSize:CGSizeMake(kScreen_Width - 2 * 10, 58.5)].height;
    if (contentLabelH < 58.5) {
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(contentLabelH);
        }];
    }
    
    self.toolView.dynamic = listPost.dynamic;
    self.toolView.likersCount = listPost.dynamic.likes;
    self.toolView.commentCount = listPost.dynamic.comments;
    self.toolView.productArray = listPost.product;
    
    [self setupTagViewFrame];
}

- (void)setupTagViewFrame
{
	NSArray *tags = self.listPost.tags;
    for (NSInteger index = 0; index< tags.count; index++)
    {
        BTTag *tag = tags[index];
        BTNoHLbutton *lastButton = nil;
		if (index >= 1) {
			lastButton = self.tagsButtonArray[index - 1];
		}
		
        BTNoHLbutton *button = [[BTNoHLbutton alloc] init];
        button.tag = index;
        [button addTarget:self action:@selector(tagButtonDidClick:)
					 forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = BTFont(13);
        [button setTitle:tag.name forState:UIControlStateNormal];
        [button setTitleColor:kUIColorFromRGB(0xd18a8e) forState:UIControlStateNormal];
		[self.tagsView addSubview:button];
		[self.tagsButtonArray addObject:button];
		
        CGFloat btnW = [button.currentTitle titleSizeWithfontSize:13].width;
		CGFloat btnH = [button.currentTitle titleSizeWithfontSize:13].height;
        CGFloat btnX = lastButton ?  CGRectGetMaxX(lastButton.frame) : 0;
        CGFloat btnY = (tagsViewHeight - btnH) * 0.5;
		
		if (btnW + btnX > kScreen_Width - 2 * horizontalPading) return;
		
		button.frame = CGRectMake(15 + btnX, btnY, btnW, btnH);
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
    if ([self.delegate respondsToSelector:@selector(listPostCell:didClickIconButtonWithIndex:)]) {
        [self.delegate listPostCell:self didClickIconButtonWithIndex:self.tag];
    }
}

- (void)attentionButtonDidClick
{
    if ([self.delegate respondsToSelector:@selector(listPostCell:didClickAttentionButtonWithIndex:)]) {
        [self.delegate listPostCell:self didClickAttentionButtonWithIndex:self.tag];
    }
}

- (void)tagButtonDidClick:(UIButton *)tagButton
{
    if ([self.delegate respondsToSelector:@selector(listPostCell:didClickTag:)]) {
        [self.delegate listPostCell:self didClickTag:self.listPost.tags[tagButton.tag]];
    }
}

- (void)buyButtonDidClick
{
    if ([self.delegate respondsToSelector:@selector(listPostCell:didClickBuyButtonWithIndex:)]) {
        [self.delegate listPostCell:self didClickBuyButtonWithIndex:self.tag];
    }
}

- (void)commentButtonDidClick
{
    if ([self.delegate respondsToSelector:@selector(listPostCell:didClickCommentButtonWithIndex:)]) {
        [self.delegate listPostCell:self didClickCommentButtonWithIndex:self.tag];
    }
}

- (void)likeButtonDidClick
{
    if ([self.delegate respondsToSelector:@selector(listPostCell:didClickLikeButtonWithIndex:)]) {
        [self.delegate listPostCell:self didClickLikeButtonWithIndex:self.tag];
    }
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

- (void)setCollect:(BOOL)isCollect
{
    _collect = isCollect;
    self.listPost.dynamic.isCollect = isCollect;
    NSInteger newCount = [self.listPost.dynamic.likes integerValue];
    newCount = isCollect? newCount + 1 : newCount - 1;
    if (newCount <0) newCount = 0;
    if (isCollect && newCount < 1)  newCount = 1;
    // 更新数据源
    self.listPost.dynamic.likes = [NSString stringWithFormat:@"%zd",newCount];
    self.toolView.likersCount = [NSString stringWithFormat:@"%zd",newCount];
    [self.toolView setCollect:isCollect];
}

@end
