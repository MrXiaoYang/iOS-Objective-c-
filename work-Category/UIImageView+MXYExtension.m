//
//  UIImageView+XMGExtension.m
//  http://www.jianshu.com/users/f60047bf604f/latest_articles
//  依赖SDWebImage第三方，需pod 'SDWebImage'

#import "UIImageView+MXYExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (MXYEExtension)
- (void)setHeader:(NSString *)url
{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
}
@end
