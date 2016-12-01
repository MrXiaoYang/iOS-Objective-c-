//
//  BTProductListCellMiddleView.m
//  BanTang
//
//  Created by Ryan on 15/12/4.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTProductListCellMiddleView.h"
#import "BTProduct.h"
#import <Masonry.h>

static const CGFloat kLeftPadding = 10.0;
static const CGFloat kRightPadding = kLeftPadding;

@interface BTProductListCellMiddleView()

@property (nonatomic, strong) UIImageView *picImageOne;

@property (nonatomic, strong) UIImageView *picImageTwo;

@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation BTProductListCellMiddleView

+ (instancetype)middleView
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupMiddleView];
    }
    return self;
}

- (void)setupMiddleView
{
    UIImageView *picImageOne = [[UIImageView alloc] init];
    picImageOne.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:picImageOne];
    [picImageOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(kLeftPadding);
        make.right.mas_equalTo(-kRightPadding);
        make.height.mas_equalTo(300);
    }];
    self.picImageOne = picImageOne;
    
    UIImageView *picImageTwo = [[UIImageView alloc] init];
    picImageTwo.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:picImageTwo];
    [picImageTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.picImageOne.mas_bottom).offset(5);
        make.left.mas_equalTo(kLeftPadding);
        make.right.mas_equalTo(-kRightPadding);
        make.height.mas_equalTo(300);
    }];
    self.picImageTwo = picImageTwo;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = kUIColorFromRGB(0xFFFD6363);
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kLeftPadding);
        make.right.mas_equalTo(- kRightPadding);
        make.top.mas_equalTo(self.picImageTwo.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    self.priceLabel = priceLabel;
}

- (void)setProduct:(BTProduct *)product
{
    _product = product;
    
    [self setupMiddleViewData];
}

- (void)setupMiddleViewData
{
    if (self.product.picArray.count == 2) { // 2张图片
        
        BTProductPic *pic1 = self.product.picArray[0];
        BTProductPic *pic2 = self.product.picArray[1];
        
        NSString *pic1String = [NSString stringWithFormat:@"%@/%@",self.productPicHost,pic1.p];

        [self.picImageOne fadeImageWithUrl:pic1String];
        
        [self.picImageTwo fadeImageWithUrl:[NSString stringWithFormat:@"%@/%@",self.productPicHost,pic2.p]];
        
        [self.picImageTwo mas_updateConstraints:^(MASConstraintMaker *make) {
             make.height.mas_equalTo(300);
        }];
        
    }else if(self.product.picArray.count == 1){ // 一张图片
        BTProductPic *pic1 = self.product.picArray[0];

        [self.picImageOne fadeImageWithUrl:[NSString stringWithFormat:@"%@/%@",self.productPicHost,pic1.p]];
        
        [self.picImageTwo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"参考价: ￥%@",self.product.price];
}

@end
