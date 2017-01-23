//
//  BTCommunityHeaderView.m
//  BanTang
//
//  Created by 沈文涛 on 15/12/6.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTCommunityHeaderView.h"
#import "BTCommunityElement.h"
#import "BTNoHLbutton.h"
#import <UIButton+WebCache.h>
@interface BTCommunityHeaderView ()

@property (nonatomic, strong) NSArray *elementArray;

@end

@implementation BTCommunityHeaderView

- (instancetype)initWithElementArray:(NSArray *)elementArray
{
    _elementArray = elementArray;
    
    self = [super init];
    if (self) {
        
        CGFloat padding = 3;
        CGFloat btnX = 0;
        CGFloat btnY = 0;
        CGFloat btnW = 0;
        CGFloat btnH = 0;
        
        for (NSInteger index = 0; index<elementArray.count; index++) {
            BTCommunityElement *element = elementArray[index];
            BTNoHLbutton *btn = [[BTNoHLbutton alloc] init];
            [btn sd_setImageWithURL:[NSURL URLWithString:element.pic1]
                           forState:UIControlStateNormal
                   placeholderImage:[UIImage imageNamed:@"default_image"]];
            btn.tag = index;
            [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (index==0) {
                btnW = kScreen_Width * 0.6;
                btnH = btnW;
            }else if (index == 1){
                btnW = kScreen_Width * 0.4 - padding;
                btnH = btnW;
                btnX = kScreen_Width - btnW;
            }else if (index == 2){
                btnW = kScreen_Width * 0.4 * 0.5 - padding;
                btnH = btnW;
                btnX = kScreen_Width - 2 * btnW - padding;
                btnY = kScreen_Width * 0.4 + padding;
                
            }else if (index == 3){
                btnW = kScreen_Width * 0.4 * 0.5 - padding;
                btnH = btnW;
                btnY = kScreen_Width * 0.4 + padding;
                btnX = kScreen_Width - btnW;
            }
            
             btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        }
    }
    return self;
}

- (void)btnDidClick:(BTNoHLbutton *)btn
{
    
}


@end
