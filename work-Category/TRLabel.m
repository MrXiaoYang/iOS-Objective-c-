//
//  TRLabel.m

//

#import "TRLabel.h"

@implementation TRLabel

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    //上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //起点
    CGContextMoveToPoint(context, 0, rect.size.height*0.5);
    //终点
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height*0.5);
    //渲染(画线)
    CGContextStrokePath(context);
}


@end
