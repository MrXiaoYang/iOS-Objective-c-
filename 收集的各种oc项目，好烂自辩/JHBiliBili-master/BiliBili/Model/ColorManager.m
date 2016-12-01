//
//  ColorManager.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/20.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ColorManager.h"
#import "UIColor+Art.h"
//用于保存写好的plist文件
static ColorManager* colorManager = nil;
@implementation ColorManager
- (NSString *)themeStyle{
    //利用userdefault存模式 少女粉 夜间模式
    if (_themeStyle == nil) {
        _themeStyle = [[NSUserDefaults standardUserDefaults] valueForKey:@"themeStyle"];
        if (_themeStyle == nil) {
            _themeStyle = @"少女粉";
        }
    }
    return _themeStyle;
}
- (NSDictionary *)colorDic{
    if (_colorDic == nil) {
        _colorDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"]];
    }
    return _colorDic;
}

/**
 *  str的格式为xx.xx.xx
 */
- (UIColor*)colorWithString:(NSString*)str{
    return [self theme:self.themeStyle colorWithString:str alpha:1];
}

- (UIColor*)theme:(NSString*)theme colorWithString:(NSString*)str{
    return [self theme:theme colorWithString:str alpha: 1];
}

- (UIColor*)colorWithString:(NSString*)str alpha:(CGFloat)alpha{
    return [self theme:self.themeStyle colorWithString:str alpha: alpha];
}

- (UIColor*)theme:(NSString*)theme colorWithString:(NSString*)str alpha:(CGFloat)alpha{
    return [UIColor colorWithHex:[[self.colorDic[theme] valueForKeyPath:str] integerValue] andAlpha: alpha];
}

+ (instancetype)shareColorManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colorManager = [[ColorManager alloc] init];
    });
    return colorManager;
}
@end
