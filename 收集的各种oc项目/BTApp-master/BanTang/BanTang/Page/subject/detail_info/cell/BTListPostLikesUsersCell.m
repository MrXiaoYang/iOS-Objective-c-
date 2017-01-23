//
//  BTListPostLikesUsersCell.m
//  BanTang
//
//  Created by Ryan on 15/11/30.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTListPostLikesUsersCell.h"
#import <Masonry.h>
#import <UIButton+WebCache.h>
#import "BTNoHLbutton.h"
#import "BTSubjectAuthor.h"
@interface BTListPostLikesUsersCell()

@property (nonatomic, weak) UILabel *likesCountLabel;

@property (nonatomic, weak) UIImageView *arrowImageView;

@property (nonatomic, assign,getter=isSetupDone) BOOL setupDone;

@property (nonatomic, weak) UIView *diverLine;

@end

@implementation BTListPostLikesUsersCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const reuseId = @"likesUsersCell";
    BTListPostLikesUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[BTListPostLikesUsersCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *diverLine = [UIView new];
        diverLine.backgroundColor = kUIColorFromRGB(0xeeeeee);
        [self.contentView addSubview:diverLine];
        self.diverLine = diverLine;
        [diverLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.contentView).offset(0);
            make.height.mas_equalTo(1);
        }];
        [self.diverLine setHidden:YES];
        
        UILabel *likesCountLabel = [[UILabel alloc] init];
        likesCountLabel.textColor = kUIColorFromRGB(0xd9d9d9);
        likesCountLabel.font = BTFont(10);
        [self.contentView addSubview:likesCountLabel];
        [likesCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.top.mas_equalTo(self.contentView.mas_top).offset(13);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(13);
        }];
        self.likesCountLabel = likesCountLabel;
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:
                                       [UIImage imageNamed:@"subject_arrow_right"]];
        arrowImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(40);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
            make.size.mas_equalTo(CGSizeMake(15, 24));
        }];
        self.arrowImageView = arrowImageView;
    }
    return self;
}

- (void)setLikesUsers:(NSArray *)likesUsers
{
    _likesUsers = likesUsers;
    
    self.likesCountLabel.text = [NSString stringWithFormat:@"%zd人喜欢",likesUsers.count];
    CGFloat width = [self.likesCountLabel.text titleSizeWithfontSize:10 maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    [self.likesCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
    
    CGFloat maxWidth = kScreen_Width - 30;
    CGFloat btnWH = 30;
    CGFloat padding = 10;
    if (self.setupDone)  return;
    for (NSInteger index = 0; index<likesUsers.count; index++)
    {
        BTNoHLbutton *btn =  [[BTNoHLbutton alloc] init];
        btn.layer.cornerRadius = 15.0f;
        btn.layer.masksToBounds = YES;
        btn.tag = index;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        BTSubjectAuthor *author = likesUsers[index];
        [btn sd_setImageWithURL:[NSURL URLWithString:author.avatar]
                       forState:UIControlStateNormal
               placeholderImage:[UIImage imageNamed:@"default_icon_placehodler"]];
        CGFloat btnX = padding + (btnWH + padding) * index;
        CGFloat btnY = 37;
        if (btnX + btnWH > maxWidth) break;
        btn.frame = CGRectMake(btnX, btnY, btnWH, btnWH);
        self.setupDone = YES;
    }
}

- (void)btnClick:(BTNoHLbutton *)button
{
    if (self.clickIconBlock) {
        self.clickIconBlock(button.tag);
    }
}

- (void)hideTopDiverLine:(BOOL)hide
{
    [self.diverLine setHidden:hide];
}

@end
