//
//  BTSignSuccessPopView.m
//  BanTang
//
//  Created by Ryan on 15/12/7.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTSignSuccessPopView.h"
#import <UIImageView+WebCache.h>
@interface BTSignSuccessPopView()

@property (weak, nonatomic) IBOutlet UIView *blackView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, copy) NSString *url;

@end

@implementation BTSignSuccessPopView

+ (instancetype)popViewWithURLString:(NSString *)urlString
{
    BTSignSuccessPopView *popView = [NSBundle rx_loadXibNameWith:@"BTSignSuccessPopView"];
    popView.url = urlString;
    [popView.imageView fadeImageWithUrl:urlString];
    return popView;
}

- (void)awakeFromNib
{
    self.blackView.backgroundColor = kUIColorFromRGB(0xBF000000);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(cancelBtnClick:)];
    [self.blackView addGestureRecognizer:tap];
}

- (IBAction)cancelBtnClick:(id)sender
{
    self.alpha = 0.0;
    [self removeFromSuperview];
}

- (IBAction)shareBtnClick:(id)sender
{
    
}

- (void)hide
{
    [self removeFromSuperview];
}

@end
