//
//  NHDiscoverTableViewCell.m
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDiscoverTableViewCell.h"
#import "NHDiscoverModel.h"
#import "NSAttributedString+Size.h"
#import "UIView+Layer.h"
#import "NSString+Size.h"

#define kDiscoverTextColor [UIColor colorWithRed:0.63f green:0.63f blue:0.63f alpha:1.00f]

@interface NHDiscoverTableViewCell ()

/** 头像*/
@property (nonatomic, weak) UIImageView *iconImg;
/** 名字*/
@property (nonatomic, weak) UILabel *nameL;
/** 内容*/
@property (nonatomic, weak) UILabel *contentL;
/** 订阅数*/
@property (nonatomic, weak) UILabel *orderCountL;
/** 总贴数*/
@property (nonatomic, weak) UILabel *totalCountL;
/** 订阅*/
@property (nonatomic, weak) UIButton *orderBtn;

/** 分割线*/
@property (nonatomic, weak) CALayer *lineLayer;
/** 关键字*/
@property (nonatomic, copy) NSString *keyWord;
@end

@implementation NHDiscoverTableViewCell

- (void)setElementModel:(NHDiscoverCategoryElement *)elementModel {
    _elementModel = elementModel;
    if (elementModel.intro) {
        self.contentL.attributedText = [NHUtils attStringWithString:elementModel.intro keyWord:self.keyWord font:kFont(12) highlightedColor:kCommonHighLightRedColor textColor:kDiscoverTextColor];
    }
    if (elementModel.name) {
        self.nameL.attributedText = [NHUtils attStringWithString:elementModel.name keyWord:self.keyWord font:kFont(15) highlightedColor:kCommonHighLightRedColor textColor:kBlackColor];
    }
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:elementModel.icon_url]];
    self.orderCountL.text = [NSString stringWithFormat:@"%ld 订阅", elementModel.subscribe_count];
    NSString *totalText =  [NSString stringWithFormat:@"总贴数 %ld", elementModel.today_updates];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:totalText];
    NSRange range = [totalText rangeOfString:@"总贴数 "];
    if (range.location != NSNotFound) {
        NSRange countRange = NSMakeRange(range.length, totalText.length - range.length);
        [string addAttribute:NSFontAttributeName value:kFont(12) range:NSMakeRange(0, string.length)];
        [string addAttribute:NSForegroundColorAttributeName value:kDiscoverTextColor range:range];
        [string addAttribute:NSForegroundColorAttributeName value:kCommonHighLightRedColor range:countRange];
        self.totalCountL.attributedText = string;
        
    }
    
}

- (void)setElementModel:(NHDiscoverCategoryElement *)elementModel keyWord:(NSString *)keyWord {
    _keyWord = keyWord;
    self.elementModel = elementModel;
}

- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _nameL = label;
        label.font = kFont(16);
        label.textColor = kBlackColor;
    }
    return _nameL;
}

- (UILabel *)orderCountL {
    if (!_orderCountL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _orderCountL = label;
        label.font = kFont(12);
        label.textColor = kDiscoverTextColor;
    }
    return _orderCountL;
}

- (UILabel *)contentL {
    if (!_contentL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _contentL = label;
    }
    return _contentL;
}

- (UILabel *)totalCountL {
    if (!_totalCountL) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _totalCountL = label;
        label.font = kFont(12);
    }
    return _totalCountL;
}

- (UIImageView *)iconImg {
    if (!_iconImg) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.contentView addSubview:img];
        _iconImg = img;
        img.layer.masksToBounds = YES; 
        img.layerCornerRadius = 3.0;
    }
    return _iconImg;
}

- (UIButton *)orderBtn {
    if (!_orderBtn) {
        UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:orderBtn];
        _orderBtn = orderBtn;
        [orderBtn addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        orderBtn.backgroundColor = [UIColor clearColor];
        orderBtn.layer.cornerRadius = 2.0;
        orderBtn.layer.borderColor = kDiscoverTextColor.CGColor;
        orderBtn.layer.borderWidth = kLineHeight;
        [orderBtn setTitle:@"订阅" forState:UIControlStateNormal];
        [orderBtn setTitleColor:kDiscoverTextColor forState:UIControlStateNormal];
        orderBtn.titleLabel.font = kFont(13);
        [orderBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    }
    return _orderBtn;
}

- (CALayer *)lineLayer {
    if (!_lineLayer) {
        CALayer *line = [CALayer layer];
        [self.contentView.layer addSublayer:line];
        _lineLayer = line;
        line.backgroundColor = kDiscoverTextColor.CGColor;
    }
    return _lineLayer;
}

- (void)orderBtnClick:(UIButton *)btn {
    [btn setTitle:@"已订阅" forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat orderBtnW = 50;
    CGFloat orderBtnX = self.contentView.width - orderBtnW - 15;
    CGFloat orderBtnH = 24;
    CGFloat orderBtnY = self.contentView.height / 2.0 - orderBtnH / 2.0;
    self.orderBtn.frame = CGRectMake(orderBtnX, orderBtnY, orderBtnW, orderBtnH);
    
    CGFloat iconX = 15;
    CGFloat iconY = 15;
    CGFloat iconH = self.contentView.height - iconY * 2;
    CGFloat iconW = iconH;
    self.iconImg.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat nameW = self.contentView.width - self.iconImg.right - 15 - orderBtnW - 15 - 10;
    CGFloat nameX = self.iconImg.right + 15;
    CGFloat nameY = 15;
    CGFloat nameH = 15;
    self.nameL.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat contentX = nameX;
    CGFloat contentY = self.nameL.bottom + 8;
    CGFloat contentW = nameW;
    CGFloat contentH = nameH;
    self.contentL.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
    CGFloat orderX = nameX;
    CGFloat orderY = self.contentL.bottom + 5;
    CGFloat orderH = nameH;
    CGFloat orderW = [self.orderCountL.text widthWithFont:self.orderCountL.font constrainedToHeight:orderH];
    self.orderCountL.frame = CGRectMake(orderX, orderY, orderW, orderH);
    
    CGFloat lineX = self.orderCountL.right + 5;
    CGFloat lineY = orderY + 3;
    CGFloat lineW = 1;
    CGFloat lineH = orderH - 6;
    self.lineLayer.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
    CGFloat totalX = self.orderCountL.right + 11;
    CGFloat totalY = orderY;
    CGFloat totalH = nameH;
    CGFloat totalW = self.contentView.width - totalX;
    self.totalCountL.frame = CGRectMake(totalX, totalY, totalW, totalH);
    
    
}
@end
