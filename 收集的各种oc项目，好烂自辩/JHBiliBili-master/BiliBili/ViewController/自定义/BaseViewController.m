//
//  CustomViewController.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/20.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic, strong) ColorManager* cm;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self colorSetting];
    [self addObserver:self forKeyPath:@"cm.themeStyle" options:NSKeyValueObservingOptionNew context:nil];
}

- (ColorManager *)cm{
    return [ColorManager shareColorManager];
}

- (void)colorSetting{
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    [self colorSetting];
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"cm.themeStyle"];
}

@end
