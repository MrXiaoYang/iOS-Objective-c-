//
//  BTProductListHeaderView.m
//  BanTang
//
//  Created by Ryan on 15/12/2.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTProductListHeaderView.h"
#import <Masonry.h>
#import "BTTopicNewInfo.h"
#import <UIImageView+WebCache.h>
#define imageViewH 200
#define padding 10
#define titleLabelH 20

@interface BTProductListHeaderView ()



@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *contentLabel;

@property (nonatomic, assign) CGFloat contentH;

@end

@implementation BTProductListHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.alpha = 0.0;
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = BTFont(18);
        titleLabel.textColor = kUIColorFromRGB(0x787878);
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;
        contentLabel.font = BTFont(15);
        contentLabel.textColor = kUIColorFromRGB(0x969696);
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
    }
    return self;
}

- (void)setInfo:(BTTopicNewInfo *)info
{
    _info = info;
        
    [self.imageView fadeImageWithUrl:info.pic];
    
    self.titleLabel.text = info.title;
    
    CGFloat textWidth = kScreen_Width - 24;

    CGFloat pargarphH = [self.contentLabel paragraphLabelHeightWithText:info.desc maxWidth:textWidth lineSpacing:padding];
    
    self.imageView.frame = CGRectMake(0, 0, kScreen_Width, imageViewH);
    
    self.titleLabel.frame = CGRectMake(10,
                                       imageViewH +padding,
                                       kScreen_Width - 20,
                                       titleLabelH);
    
    self.contentLabel.frame = CGRectMake(self.titleLabel.left,
                                         self.titleLabel.bottom + padding,
                                         self.titleLabel.width,
                                         pargarphH + padding);
    
    self.headerHeight = pargarphH + 2 * padding + titleLabelH + padding + imageViewH;
}

- (void)show
{
//    self.imageView.alpha = 1.0;
}
@end
