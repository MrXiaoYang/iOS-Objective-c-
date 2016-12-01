//
//  BTProductListCellBottomView.m
//  BanTang
//
//  Created by Ryan on 15/12/4.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTProductListCellBottomView.h"
#import "BTProduct.h"
#import "BTNoHLbutton.h"
#import <Masonry.h>
#import <UIButton+WebCache.h>

static const CGFloat kLeftPadding = 10.0;
static const CGFloat kRightPadding = kLeftPadding;
static const CGFloat kLikesIconWH = 25.0;
static const CGFloat kBottomBtnH = 50.0;

@interface BTProductListCellBottomView()

// bottomView
@property (nonatomic, strong) UIView *likesView;
@property (nonatomic, strong) UIView *toolView;

@property (nonatomic, strong) UILabel *likesNumLabel;
@property (nonatomic, strong) BTNoHLbutton *arrowIcon;

// toolView
@property (nonatomic, strong) BTNoHLbutton *commentBtn;
@property (nonatomic, strong) BTNoHLbutton *likeBtn;
@property (nonatomic, strong) BTNoHLbutton *buyBtn;

@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSMutableArray *circlePhotoArray;

@property (nonatomic, strong) NSMutableDictionary *cacheDictionary;

@end

@implementation BTProductListCellBottomView

+ (instancetype)bottomView
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupBottomView];
    }
    return self;
}

- (void)setupBottomView
{
    [self addSubview:self.likesView];
    
    [self addSubview:self.toolView];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.likesView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width,kBottomBtnH));
    }];
    
    CGFloat kBottomViewW = kScreen_Width / 3;
	
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.likesView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kBottomViewW, kBottomBtnH));
    }];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.commentBtn.mas_right);
        make.top.mas_equalTo(self.likesView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kBottomViewW, kBottomBtnH));
    }];
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.likeBtn.mas_right).offset(10);
        make.top.mas_equalTo(self.likesView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kBottomViewW - 20, kBottomBtnH));
    }];
    
    UIView *sepeatorView = [UIView new];
    sepeatorView.backgroundColor = kUIColorFromRGB(0xf8f9fa);
    [self addSubview:sepeatorView];
    [sepeatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.toolView.mas_bottom);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}

- (void)setupBottomViewData
{
    self.likesNumLabel.text = [NSString stringWithFormat:@"%@人喜欢",self.product.likes];
    
    [self.commentBtn setTitle:self.product.comments forState:UIControlStateNormal];
    
    if (self.product.islike) {
        [self.likeBtn setImage:[UIImage imageNamed:@"product_item_likeicon"] forState:UIControlStateNormal];
        [self.likeBtn setTitle:@"收入心愿单" forState:UIControlStateNormal];
    }else{
        [self.likeBtn setImage:[UIImage imageNamed:@"product_item_not_likeicon"] forState:UIControlStateNormal];
        [self.likeBtn setTitle:self.product.likes forState:UIControlStateNormal];
    }
    
    NSInteger maxNum = (kScreen_Width - 57) / 37;
    maxNum++;
    
    BOOL object = [self.cacheDictionary objectForKey:self.product.ID];
    
    if (object)  return;
    
    NSInteger count = self.product.likesList.count > maxNum ? maxNum : self.product.likesList.count;
    
    UIImage *placeholderImage = [[UIImage imageNamed:@"default_icon_placehodler"] rx_circleImage];
    
    for (NSInteger index = 0; index < count; index++) {
        BTNoHLbutton *iconBtn = self.imagesArray[index];
        BTProductLiker *liker = self.product.likesList[index];
        NSURL *likerURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",self.userAvatrHost,liker.a]];
		
        void (^completionBlock)(UIImage *,NSError *,SDImageCacheType, NSURL *) = ^(UIImage *image,
                                                                                   NSError *error,
                                                                                   SDImageCacheType
                                                                                   cacheType,
                                                                                   NSURL *imageURL)
        {
            if (image == nil) {
                [iconBtn setImage:placeholderImage forState:UIControlStateNormal];
                return ;
            }
            
            [iconBtn setImage:[image rx_circleImage] forState:UIControlStateNormal];
        };
        
        [iconBtn sd_setImageWithURL:likerURL
                           forState:UIControlStateNormal
                   placeholderImage:placeholderImage
                          completed:completionBlock];
    }
    [self.cacheDictionary setObject:@(YES) forKey:self.product.ID];
}

- (void)setProduct:(BTProduct *)product
{
    _product = product;
    
    [self setupBottomViewData];
}

- (void)commentBtnDidClick
{
    if ([self.delegate respondsToSelector:@selector(bottomView:didClickComment:)]) {
        [self.delegate bottomView:self didClickComment:self.product];
    }
}

- (void)likeBtnDidClick
{
    if ([self.delegate respondsToSelector:@selector(bottomView:didClickLike:)]) {
        [self.delegate bottomView:self didClickLike:self.product];
    }
}

- (void)buyBtnDidClick
{
    if ([self.delegate respondsToSelector:@selector(bottomView:didClickBuy:)]) {
        [self.delegate bottomView:self didClickBuy:self.product];
    }
}

- (void)userIconDidClick:(BTNoHLbutton *)btn
{
    if ([self.delegate respondsToSelector:@selector(bottomView:didClickLikerUserIcon:)]) {
        [self.delegate bottomView:self didClickLikerUserIcon:self.product.likesList[btn.tag]];
    }
}

- (void)arrowIconDidClick
{
    if ([self.delegate respondsToSelector:@selector(bottomView:didClickArrowIcon:)]) {
        [self.delegate bottomView:self didClickArrowIcon:self.product];
    }
}

- (UIView *)likesView
{
    if (!_likesView) {
        UIView *likesView = [[UIView alloc] init];
        [self addSubview:likesView];
        [likesView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(75);
        }];
        _likesView = likesView;
        
        UIView *diverLineOne = [UIView new];
        diverLineOne.backgroundColor = kUIColorFromRGB(0xFFEEEEEE);
        [_likesView addSubview:diverLineOne];
        [diverLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *diverLineTwo = [UIView new];
        diverLineTwo.backgroundColor = kUIColorFromRGB(0xFFEEEEEE);
        [_likesView addSubview:diverLineTwo];
        [diverLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(74.5);
            make.height.mas_equalTo(0.5);
        }];
        
        UILabel *likesNumLabel = [[UILabel alloc] init];
        likesNumLabel.numberOfLines = 1;
        likesNumLabel.textAlignment= NSTextAlignmentLeft;
        likesNumLabel.textColor = kUIColorFromRGB(0xFFBFBFBF);
        likesNumLabel.font = [UIFont systemFontOfSize:10];
        [likesView addSubview:likesNumLabel];
        [likesNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kLeftPadding);
            make.right.mas_equalTo(-kRightPadding);
            make.top.mas_equalTo(kLeftPadding);
            make.height.mas_equalTo(12);
        }];
        self.likesNumLabel = likesNumLabel;
        
        BTNoHLbutton *arrowIcon = [[BTNoHLbutton alloc] init];
        [arrowIcon addTarget:self action:@selector(arrowIconDidClick) forControlEvents:UIControlEventTouchUpInside];
        arrowIcon.imageView.contentMode = UIViewContentModeCenter;
        [arrowIcon setImage:[UIImage imageNamed:@"subject_arrow_right"] forState:UIControlStateNormal];
        [likesView addSubview:arrowIcon];
        [arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(likesNumLabel.mas_bottom).offset(5);
            make.right.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(27, 33));
        }];
        self.arrowIcon = arrowIcon;
        
        NSInteger maxNum = (kScreen_Width - 57) / 37;
        maxNum++;
        
        for (NSInteger index = 0; index < maxNum; index++) {
            BTNoHLbutton *likesIcon = [[BTNoHLbutton alloc] init];
            likesIcon.tag = index;
            [likesIcon addTarget:self action:@selector(userIconDidClick:) forControlEvents:UIControlEventTouchUpInside];
            likesIcon.frame = CGRectMake(kLeftPadding +(kLeftPadding + kLikesIconWH) * index,
                                         32,
                                         kLikesIconWH,
                                         kLikesIconWH);
            [self.likesView addSubview:likesIcon];
            [self.imagesArray addObject:likesIcon];
        }
    }
    return _likesView;
}

- (UIView *)toolView
{
    if (!_toolView) {
        _toolView = [[UIView alloc] init];
        [_toolView addSubview:self.commentBtn];
        [_toolView addSubview:self.likeBtn];
        [_toolView addSubview:self.buyBtn];
    }
    return _toolView;
}

- (BTNoHLbutton *)commentBtn
{
    if (!_commentBtn) {
        _commentBtn = [[BTNoHLbutton alloc] init];
        _commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [_commentBtn setTitleColor:kUIColorFromRGB(0xFF727272) forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = BTFont(12);
        [_commentBtn addTarget:self action:@selector(commentBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [_commentBtn setImage:[UIImage imageNamed:@"product_not_commenticon"]
                     forState:UIControlStateNormal];
        
    }
    return _commentBtn;
}

- (BTNoHLbutton *)likeBtn
{
    if (!_likeBtn) {
        _likeBtn = [[BTNoHLbutton alloc] init];
        _likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [_likeBtn setTitleColor:kUIColorFromRGB(0xFF727272) forState:UIControlStateNormal];
        [_likeBtn addTarget:self action:@selector(likeBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        _likeBtn.titleLabel.font = BTFont(12);
        [_likeBtn setImage:[UIImage imageNamed:@"product_item_not_likeicon"]
                  forState:UIControlStateNormal];
    }
    return _likeBtn;
}

- (BTNoHLbutton *)buyBtn
{
    if (!_buyBtn) {
        _buyBtn = [[BTNoHLbutton alloc] init];
        [_buyBtn addTarget:self action:@selector(buyBtnDidClick) forControlEvents:UIControlEventTouchUpInside];

        [_buyBtn setImage:[UIImage imageNamed:@"tools_taobao"]
                 forState:UIControlStateNormal];
        [_buyBtn setImage:[UIImage imageNamed:@"tools_taobao_pressed"]
                 forState:UIControlStateHighlighted];
    }
    return _buyBtn;
}

- (NSMutableDictionary *)cacheDictionary
{
    if (!_cacheDictionary) {
        _cacheDictionary = [NSMutableDictionary dictionary];
    }
    return _cacheDictionary;
}

- (NSMutableArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

- (void)setLikesCount:(NSString *)likesCount
{
    NSInteger count = [likesCount integerValue];
    if (count > 0) {
        [self.likeBtn setTitle:likesCount forState:UIControlStateNormal];
    }else{
        [self.likeBtn setTitle:@"赞" forState:UIControlStateNormal];
    }
}

- (void)setLike:(BOOL)like
{
    _like = like;
    
    if (like) {
        [self.likeBtn setImage:[UIImage imageNamed:@"product_item_likeicon"] forState:UIControlStateNormal];
        [self.likeBtn setTitle:@"收入心愿单" forState:UIControlStateNormal];
    }else{
        [self.likeBtn setImage:[UIImage imageNamed:@"product_item_not_likeicon"] forState:UIControlStateNormal];
        [self.likeBtn setTitle:self.product.likes forState:UIControlStateNormal];
    }
}
@end
