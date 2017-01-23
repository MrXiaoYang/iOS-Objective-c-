//
//  DownLoadTableViewCell.h
//  BiliBili
//
//  Created by apple-jd44 on 15/12/4.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^buttonHandle)();
@interface DownLoadTableViewCell : UITableViewCell
@property (nonatomic, strong) buttonHandle block;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIButton *suspandButton;
@property (nonatomic, strong) NSString *aid;
- (void)updateBolock:(buttonHandle)buttonHandle;
- (void)updateProgress:(float)progress;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier taskIsPause:(BOOL)taskIsPause;
@end
