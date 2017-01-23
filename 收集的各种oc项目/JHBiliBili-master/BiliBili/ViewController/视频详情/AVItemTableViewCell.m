//
//  AVItemTableViewCell.m
//  BiliBili
//
//  Created by apple-jd44 on 15/12/2.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "AVItemTableViewCell.h"

@implementation AVItemTableViewCell
- (void)setWithDic:(NSDictionary*)dic{
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
@end
