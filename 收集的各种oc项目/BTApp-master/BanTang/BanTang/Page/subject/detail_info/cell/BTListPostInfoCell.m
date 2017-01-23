//
//  BTListPostInfoCell.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/29.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTListPostInfoCell.h"
#import "BTListPostInfoView.h"

@interface BTListPostInfoCell() <BTListPostInfoViewDelegate>

@property (nonatomic, strong) BTListPostInfoView *infoView;

@end

@implementation BTListPostInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const reuseId = @"infoCell";
    BTListPostInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[BTListPostInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        BTListPostInfoView *infoView = [[BTListPostInfoView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 600)];
        infoView.delegate = self;
        [self addSubview:infoView];
        _infoView = infoView;
    }
    return self;
}

- (void)listInfoView:(BTListPostInfoView *)listInfoView didClickAttentionButtonWithListPost:(BTListPost *)listPost
{
    if ([self.delegate respondsToSelector:@selector(listPostInfoCell:didClickAttentionButtonWithListPost:)]) {
        [self.delegate listPostInfoCell:self didClickAttentionButtonWithListPost:listPost];
    }
}

- (void)listInfoView:(BTListPostInfoView *)listInfoView didClickIconButtonWithListPost:(BTListPost *)listPost
{
    if ([self.delegate respondsToSelector:@selector(listPostInfoCell:didClickIconButtonWithListPost:)]) {
        [self.delegate listPostInfoCell:self didClickIconButtonWithListPost:listPost];
    }
}

- (void)listInfoView:(BTListPostInfoView *)listInfoView didClickTag:(BTTag *)tag
{
    if ([self.delegate respondsToSelector:@selector(listPostInfoCell:didClickTag:)]) {
        [self.delegate listPostInfoCell:self didClickTag:tag];
    }
}

- (void)setListPost:(BTListPost *)listPost
{
    _listPost = listPost;
    
    self.infoView.listPost = listPost;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.infoView.frame = self.bounds;
}

@end
