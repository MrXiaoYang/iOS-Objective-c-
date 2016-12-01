//
//  BTListPostProductCell.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/29.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTListPostProductCell.h"
#import "BTProduct.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@interface BTListPostProductCell()

/** product 图片 */
@property (nonatomic, weak) UIImageView *productImageView;
/** 产品名字label */
@property (nonatomic, weak) UILabel *productNameLabel;
/** 产品来源label */
@property (nonatomic, weak) UILabel *productPlatform;
/** 价格label */
@property (nonatomic, weak) UILabel *priceLabel;
/** 来源logo */
@property (nonatomic, weak) UIImageView *platformLogo;
/** 包含上面控件的view */
@property (nonatomic, weak) UIView *innerView;

@end

@implementation BTListPostProductCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *const reuseId = @"productCell";
    BTListPostProductCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[BTListPostProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    // 里面白色的View
    UIView *innerView = [[UIView alloc] init];
    innerView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:innerView];
    self.innerView = innerView;
    [innerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    UIImageView *lianjieLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"community_lianjie"]];
    lianjieLogo.contentMode = UIViewContentModeCenter;
    [innerView addSubview:lianjieLogo];
    [lianjieLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(innerView.mas_left).offset(10);
        make.top.mas_equalTo(innerView.mas_top).offset(8);
        make.size.mas_equalTo(CGSizeMake(11, 11));
    }];
    
    UILabel *lianjieLabel = [[UILabel alloc] init];
    lianjieLabel.text = @"相关链接";
    CGFloat lianjieW = [lianjieLabel.text titleSizeWithfontSize:14 maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    lianjieLabel.font = BTFont(14);
    lianjieLabel.textColor = kUIColorFromRGB(0x757575);
    [innerView addSubview:lianjieLabel];
    [lianjieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lianjieLogo.mas_right).offset(8);
        make.top.mas_equalTo(innerView.mas_top);
        make.height.mas_equalTo(27);
        make.width.mas_equalTo(lianjieW);
    }];
    
    UIView *diverLine = [UIView new];
    diverLine.backgroundColor = kUIColorFromRGB(0xeeeeee);
    [innerView addSubview:diverLine];
    [diverLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(innerView.mas_left);
        make.top.mas_equalTo(innerView.mas_top).offset(27);
        make.right.mas_equalTo(innerView.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *productImageView =[[UIImageView alloc] init];
    [innerView addSubview:productImageView];
    self.productImageView = productImageView;
    [productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(innerView.mas_left).offset(8);
        make.top.mas_equalTo(diverLine.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(55, 55));
    }];
    
    UIImageView *buyLogo = [[UIImageView alloc] init];
    buyLogo.image = [UIImage imageNamed:@"community_goumai"];
    [innerView addSubview:buyLogo];
    [buyLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(innerView.mas_right).offset(-10);
        make.top.mas_equalTo(diverLine.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    UILabel *productNameLabel = [[UILabel alloc] init];
    productNameLabel.font = BTFont(14);
    [innerView addSubview:productNameLabel];
    productNameLabel.textColor = kUIColorFromRGB(0x919191);
    self.productNameLabel = productNameLabel;
    [productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(productImageView.mas_right).offset(10);
        make.top.mas_equalTo(diverLine.mas_bottom).offset(10);
        make.height.mas_equalTo(17);
        make.right.mas_equalTo(buyLogo.mas_left).offset(-10);
    }];
    
    UIImageView *platformLogo = [[UIImageView alloc] init];
    [innerView addSubview:platformLogo];
    self.platformLogo = platformLogo;
    [platformLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(productImageView.mas_right).offset(10);
        make.top.mas_equalTo(productNameLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(15, 13));
    }];
    
    UILabel *productPlatform = [[UILabel alloc] init];
    productPlatform.font = BTFont(14);
    productPlatform.textColor = kUIColorFromRGB(0xc9c9c9);
    [innerView addSubview:productPlatform];
    self.productPlatform = productPlatform;
    [productPlatform mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(platformLogo.mas_right).offset(8);
        make.top.mas_equalTo(productNameLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 17));
    }];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    [innerView addSubview:priceLabel];
    priceLabel.font = BTFont(14);
    priceLabel.textColor = kUIColorFromRGB(0xf29393);
    self.priceLabel = priceLabel;
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(productPlatform.mas_right).offset(25);
        make.top.mas_equalTo(productNameLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 17));
    }];
}

- (void)setProduct:(BTProduct *)product
{
    _product = product;
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:product.pic]
                             placeholderImage:[UIImage imageNamed:@"default_product_web_confirm"]];
    
    self.productNameLabel.text = product.title;
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",product.price];
    CGFloat priceLabelWidth = [self.priceLabel.text titleSizeWithfontSize:14 maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    [self.priceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(priceLabelWidth);
    }];
    
    if ([product.platform integerValue] == 1) {
        self.platformLogo.image = [UIImage imageNamed:@"community_taobao"];
        self.productPlatform.text = @"来自淘宝";
    }else if ([product.platform integerValue] == 2) {
        self.platformLogo.image = [UIImage imageNamed:@"community_tianmao"];
        self.productPlatform.text = @"来自天猫";
    }else if ([product.platform integerValue] == 3){
        self.platformLogo.image = [UIImage imageNamed:@"community_jingdong"];
        self.productPlatform.text = @"来自京东";
    }
    CGFloat platformWidth = [self.productPlatform.text titleSizeWithfontSize:14 maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    [self.productPlatform mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(platformWidth);
    }];
}

@end
