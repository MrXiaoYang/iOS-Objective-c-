//
//  UIImage+Scale.m
//  HonghePatriarch
//
//  Created by honey on 15/8/15.
//  Copyright (c) 2015年 HH. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
@end
