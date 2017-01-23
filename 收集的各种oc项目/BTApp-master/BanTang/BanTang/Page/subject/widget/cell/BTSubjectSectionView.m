//
//  BTSubjectSectionView.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/27.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTSubjectSectionView.h"
#import <Masonry.h>
@interface BTSubjectSectionView()

@property (weak, nonatomic) IBOutlet UIView *selectedStatuView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedViewWidth;
@property (nonatomic, strong) UIButton *selectedButton;

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (nonatomic, copy) NSString *leftTitle;
@property (nonatomic, copy) NSString *rightTitle;

@end

@implementation BTSubjectSectionView

- (void)awakeFromNib
{
	CGFloat constant = kScreen_Width * 1 / 4;
	self.selectedViewWidth.constant = constant;
	
}

+ (instancetype)sectionView
{
    return [NSBundle rx_loadXibNameWith:@"BTSubjectSectionView"];
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;

    [self.leftButton setTitle:self.titleArray[0] forState:UIControlStateNormal];
    [self.rightButton setTitle:self.titleArray[1] forState:UIControlStateNormal];
}

- (IBAction)buttonDidClick:(UIButton *)sender
{
    if (sender == self.selectedButton) return;
 
    if ([self.delegate respondsToSelector:@selector(sectionView:didClickIndexButton:)]){
        [self.delegate sectionView:self didClickIndexButton:sender.tag];
    }
    
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
	
	CGFloat detlaWidth = kScreen_Width * 0.5 + 3;
	
    [UIView animateWithDuration:0.25 animations:^{
        if (sender.tag == 100) {
            self.selectedStatuView.transform = CGAffineTransformIdentity;
        }else{
            self.selectedStatuView.transform = CGAffineTransformMakeTranslation(detlaWidth, 0);
        }
    }];
}

- (void)setCurrentSelctedNum:(NSInteger)currentSelctedNum
{
    _currentSelctedNum = currentSelctedNum;
	
	CGFloat detlaWidth = kScreen_Width * 0.5 + 3;
	
    [UIView animateWithDuration:0.25 animations:^{
        if (currentSelctedNum == 0) {
            self.selectedStatuView.transform = CGAffineTransformIdentity;
        }else{
            self.selectedStatuView.transform = CGAffineTransformMakeTranslation(detlaWidth, 0);
        }
    }];
}


@end
