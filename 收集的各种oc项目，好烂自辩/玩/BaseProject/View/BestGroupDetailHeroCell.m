//
//  BestGroupDetailHeroCell.m
//  BaseProject
//
//  Created by jiyingxin on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BestGroupDetailHeroCell.h"

@implementation BestGroupDetailHeroCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)introLb {
    if(_introLb == nil) {
        _introLb = [[UILabel alloc] init];
        [self.contentView addSubview:_introLb];
        [_introLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(self.iconView.mas_right).mas_equalTo(10);
        }];
        _introLb.numberOfLines = 0;
        _introLb.font =[UIFont systemFontOfSize:16];
    }
    return _introLb;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *yelloView=[UIView new];
        yelloView.backgroundColor=kRGBColor(254, 249, 236);
        self.selectedBackgroundView=yelloView;
    }
    return self;
}


- (TRImageView *)iconView {
    if(_iconView == nil) {
        _iconView = [[TRImageView alloc] init];
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(52, 52));
            make.top.left.mas_equalTo(10);
        }];
    }
    return _iconView;
}

@end
