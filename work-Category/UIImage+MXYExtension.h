//
//  UIImage+XMGExtension.h
//  http://www.jianshu.com/users/f60047bf604f/latest_articles
//

#import <UIKit/UIKit.h>

@interface UIImage (MXYExtension)
/**
 * 圆形图片
 */
- (UIImage *)circleImage;

+ (UIImage*) resizableImageWithName:(NSString *)imageName;
- (UIImage*) scaleImageWithSize:(CGSize)size;
@end
