//
//  JFSelectAddressView.m
//  JF团购
//
//  Created by 保修一站通 on 15/8/31.
//  Copyright (c) 2015年 JF团购. All rights reserved.
//

#import "JFSelectAddressView.h"
#import "JFAddressScrollView.h"

@implementation JFSelectAddressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    
    UIView *maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    maskView.tag =99;
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.6;
    [self addSubview:maskView];
    
   
    
    self.addressScrollView = [JFAddressScrollView scrollView];
//    view.backgroundColor = RGB(239, 239, 244);
    self.addressScrollView.frame = CGRectMake(0, 0, self.frame.size.width, SCREENHEIGHT/2);
    [self addSubview:self.addressScrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskViewClick)];
    tap.numberOfTapsRequired = 1;
    [maskView addGestureRecognizer:tap];

}

-(void)maskViewClick{
    if ([self.delegate respondsToSelector:@selector(removeMaskView)]) {
        [self.delegate removeMaskView];
    }
    

    
}

@end
