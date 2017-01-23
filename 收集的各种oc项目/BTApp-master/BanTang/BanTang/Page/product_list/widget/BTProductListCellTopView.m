//
//  BTProductListCellTopView.m
//  BanTang
//
//  Created by Ryan on 15/12/4.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTProductListCellTopView.h"
#import "BTProduct.h"
#import <Masonry.h>

static const CGFloat kTitleLabelH = 58.0;
static const CGFloat kLeftPadding = 10.0;

@interface BTProductListCellTopView()

@property (nonatomic, strong) UIImageView *rankImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation BTProductListCellTopView

+ (instancetype)topView
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupTopView];
    }
    return self;
}

- (void)setupTopView
{
    UIView *sepeatorView = [UIView new];
    sepeatorView.backgroundColor = kUIColorFromRGB(0xf8f9fa);
    [self addSubview:sepeatorView];
    [sepeatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top);
        make.height.mas_equalTo(15);
    }];
    
    UIImageView *rankImageView = [[UIImageView alloc] init];
    [self addSubview:rankImageView];
    [rankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeftPadding);
        make.top.mas_equalTo(sepeatorView.mas_bottom).offset(12.5);
        make.size.mas_equalTo(CGSizeMake(15, 23));
    }];
    self.rankImageView = rankImageView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 1;
    titleLabel.textColor = kUIColorFromRGB(0xFF666666);
    titleLabel.font = BTFont(18);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rankImageView.mas_right).offset(10);
        make.top.mas_equalTo(sepeatorView.mas_bottom).offset(-5);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(kTitleLabelH);
    }];
    self.titleLabel = titleLabel;
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.numberOfLines = 0;
    descLabel.textColor = kUIColorFromRGB(0xFF727272);
    descLabel.font = BTFont(15);
    descLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(100);
    }];
    self.descLabel = descLabel;
}

- (void)setProduct:(BTProduct *)product
{
    _product = product;
    
    [self setupTopViewData];
}

- (void)setupTopViewData
{
    self.rankImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"good%zd",self.tag + 1]];
    
    self.titleLabel.text = self.product.title;
    
    [self setupContentLabel];
}

- (void)setupContentLabel
{
    CGFloat textWidth = kScreen_Width - 2 * kLeftPadding;
    
    CGFloat paragraphLabelH = [self.descLabel  paragraphLabelHeightWithText:self.product.desc
                                                                   maxWidth:textWidth
                                                                lineSpacing:10];
    
    [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(paragraphLabelH);
    }];
    
    CGFloat height = kTitleLabelH + paragraphLabelH;
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}
@end
