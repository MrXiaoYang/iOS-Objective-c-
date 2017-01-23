//
//  BoPhotoGroupCell.m
//  PhotoPicker
//
//  Created by AlienJunX on 15/11/2.
//  Copyright © 2015年 com.alienjun.demo. All rights reserved.
//

#import "BoPhotoGroupCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

//rgb颜色转换（16进制->10进制）
#define mRGBToColor(rgb) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0]

@interface BoPhotoGroupCell()
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, weak) UIImageView *groupImageView;
@property (nonatomic, weak) UILabel *groupTextLabel;
@end


@implementation BoPhotoGroupCell

- (void)bind:(ALAssetsGroup *)assetsGroup{
    self.assetsGroup = assetsGroup;
    self.backgroundColor = mRGBToColor(0xebebeb);
    if (self.groupImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 5, 50, 50)];
        [self.contentView addSubview:imageView];
        self.groupImageView = imageView;
    }
    
    if (self.groupTextLabel == nil) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, self.bounds.size.height/2-10, [UIScreen mainScreen].bounds.size.width-70, 20)];
        textLabel.font = [UIFont systemFontOfSize:15];
        textLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:textLabel];
        self.groupTextLabel = textLabel;
    }
    
    CGImageRef posterImage = assetsGroup.posterImage;
    size_t height = CGImageGetHeight(posterImage);
    float scale = height / 78.0f;
    
    self.groupImageView.image = [UIImage imageWithCGImage:posterImage scale:scale orientation:UIImageOrientationUp];
    self.groupTextLabel.text = [NSString stringWithFormat:@"%@(%ld)",[assetsGroup valueForProperty:ALAssetsGroupPropertyName],(long)[assetsGroup numberOfAssets]];
}

@end
