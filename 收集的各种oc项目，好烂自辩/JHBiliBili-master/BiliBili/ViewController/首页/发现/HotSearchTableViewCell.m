//
//  HotSearchTableViewCell.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/23.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "HotSearchTableViewCell.h"

#import "UIImage+Tools.h"
@interface HotSearchTableViewCell ()
@property (nonatomic, strong) UIImage* upImg;
@property (nonatomic, strong) UIImage* downImg;
@property (nonatomic, strong) UIImage* keepImg;
@end

@implementation HotSearchTableViewCell

- (void)setWithRank:(NSIndexPath*)index keyWord:(NSString*)keyWord state:(NSString*)state{
//    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"fvcell"];
//
    //排行
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%ld", (long)(index.row + 1)]];
    //排行前三添加其它标识颜色
    [str setAttributes:@{NSForegroundColorAttributeName:[[ColorManager shareColorManager] colorWithString: index.row <= 2?@"FindViewController.hotTextColor":@"textColor"]} range:NSMakeRange(0, str.length)];
    //之后的关键词
    [str appendAttributedString: [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\t%@",keyWord] attributes:@{NSForegroundColorAttributeName:[[ColorManager shareColorManager] colorWithString:@"textColor"]}]];
    [self.textLabel setAttributedText: str];
//
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 10)];
    //设置排行榜图片
    [imgView setImage: @{@"keep":self.keepImg, @"up":self.upImg, @"down":self.downImg}[state]];
    self.accessoryView = imgView;
    

}

- (UIImage *)upImg{
    if (_upImg == nil) {
        _upImg = [[UIImage imageNamed:@"search_icon"] clipImageWithRect:CGRectMake(0, 0, 7, 10)];
    }
    return _upImg;
}

- (UIImage *)downImg{
    if (_downImg == nil) {
        _downImg = [[UIImage imageNamed:@"search_icon"] clipImageWithRect:CGRectMake(10, 0, 7, 10)];
    }
    return _downImg;
}

- (UIImage *)keepImg{
    if (_keepImg == nil) {
        _keepImg = [[UIImage imageNamed:@"search_icon"] clipImageWithRect:CGRectMake(20, 0, 7, 10)];
    }
    return _keepImg;
}

@end
