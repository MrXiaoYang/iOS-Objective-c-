//
//  RecommendTableViewController.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/21.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "TakeHeadTableView.h"

@interface TakeHeadTableView ()

@end

@implementation TakeHeadTableView

- (instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) style:UITableViewStyleGrouped]) {
        UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowW / 2)];
        self.tableHeaderView = v;
        self.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (instancetype)initWithHeadHeight:(CGFloat)height{
    if (self = [super initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) style:UITableViewStyleGrouped]) {
        UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, height)];
        self.tableHeaderView = v;
        self.backgroundColor = [[ColorManager shareColorManager] colorWithString:@"backgroundColor"];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

@end
