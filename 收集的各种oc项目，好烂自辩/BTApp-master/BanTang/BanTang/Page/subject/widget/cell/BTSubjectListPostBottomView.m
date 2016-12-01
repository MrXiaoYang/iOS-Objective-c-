//
//  BTSubjectListPostBottomView.m
//  BanTang
//
//  Created by 沈文涛 on 15/11/28.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "BTSubjectListPostBottomView.h"
#import "BTListPostDynamic.h"
@interface BTSubjectListPostBottomView()

@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIButton *likerButton;

@end

@implementation BTSubjectListPostBottomView

+ (instancetype)bottomView
{
    return [NSBundle rx_loadXibNameWith:@"BTSubjectListPostBottomView"];
}

- (void)awakeFromNib
{
    [self.commentButton setTitleColor:kUIColorFromRGB(0xFF676767) forState:UIControlStateNormal];
    [self.buyButton setTitleColor:kUIColorFromRGB(0xFF676767) forState:UIControlStateNormal];
    [self.likerButton setTitleColor:kUIColorFromRGB(0xFF676767) forState:UIControlStateNormal];
}

- (void)setLikersCount:(NSString *)likersCount 
{
    NSInteger count = [likersCount integerValue];
    if (count > 0) {
        [self.likerButton setTitle:likersCount forState:UIControlStateNormal];
    }else{
        [self.likerButton setTitle:@"赞" forState:UIControlStateNormal];
    }
}

- (void)setCommentCount:(NSString *)commentCount
{
    NSInteger count = [commentCount integerValue];
    if (count >0) {
        [self.commentButton setTitle:commentCount forState:UIControlStateNormal];
    }else{
        [self.commentButton setTitle:@"评论" forState:UIControlStateNormal];
    }

}

- (IBAction)buyButtonDidClick:(UIButton *)sender
{
    if (self.buyBlock) {
        self.buyBlock();
    }
}

- (IBAction)commentButtonDidClick:(UIButton *)sender
{
    if (self.commentBlock) {
        self.commentBlock();
    }
}

- (void)setProductArray:(NSArray *)productArray
{
    _productArray = productArray;
    if (productArray.count==0) {
        [self.buyButton setTitle:@"暂无购买链接" forState:UIControlStateNormal];
        [self.buyButton setImage:nil  forState:UIControlStateNormal];
        [self.buyButton setUserInteractionEnabled:NO];
    }else{
        [self.buyButton setImage:[UIImage imageNamed:@"community_cart"] forState:UIControlStateNormal];
        [self.buyButton setTitle:@"购买" forState:UIControlStateNormal];
        [self.buyButton setUserInteractionEnabled:YES];
    }
}

- (IBAction)likerButtonDidClick:(UIButton *)sender
{
    if (self.likeBlock) {
        self.likeBlock();
    }
}

- (void)setDynamic:(BTListPostDynamic *)dynamic
{
    _dynamic = dynamic;
    if (dynamic.isCollect) {
        [self.likerButton setImage:[UIImage imageNamed:@"community_like"] forState:UIControlStateNormal];
    }else{
        [self.likerButton setImage:[UIImage imageNamed:@"community_un_like"] forState:UIControlStateNormal];
    }
}

- (void)setCollect:(BOOL)collect
{
    if (collect) {
        [self.likerButton setImage:[UIImage imageNamed:@"community_like"] forState:UIControlStateNormal];
    }else{
        [self.likerButton setImage:[UIImage imageNamed:@"community_un_like"] forState:UIControlStateNormal];
    }
}

@end
