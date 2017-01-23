//
//  ShiBanTableViewCell.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/25.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ShiBanEpisodesTableViewCell.h"

#import "ShinBanInfoModel.h"

#import "VideoViewController.h"

@interface ShiBanEpisodesTableViewCell ()
@property (nonatomic, strong) UIViewController* vc;
@end

@implementation ShiBanEpisodesTableViewCell
{
    NSArray<episodesModel*>* _episodes;
}

- (void)setEpisodes:(NSArray *)episodes{
    _episodes = episodes;
    __block UIButton *preButton = nil;
    __weak typeof(self)weakSelf = self;
    [_episodes enumerateObjectsUsingBlock:^(episodesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * button = (UIButton* _Nullable)[weakSelf viewWithTag: 100 + idx];
        //没添加的情况
        if (button == nil) {
            button = [[UIButton alloc] init];
            //记录下标
            button.tag = 100 + idx;
            button.titleLabel.font = [UIFont systemFontOfSize: 13];
            [button setBackgroundImage:[UIImage imageNamed:@"bg_text_field_mono_light_gray_boarder"] forState:UIControlStateNormal];
            //通知更新按钮标题和播放
            [button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [weakSelf.vc.view addSubview: button];
            //第一个按钮
            if (preButton == nil) {
                CGFloat rr =  (kWindowW  - 50) / 4;
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(10);
                    make.top.mas_offset(10);
                    make.width.mas_equalTo(rr);
                }];
                //其它情况
            }else{
                //换行
                if (idx % 4 == 0) {
                    [button mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_offset(10);
                        make.width.height.equalTo(preButton);
                        make.top.mas_equalTo(preButton.mas_bottom).mas_offset(10);
                    }];
                }else{
                    [button mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(preButton.mas_right).mas_offset(10);
                        make.width.height.top.equalTo(preButton);
                    }];
                }
            }
            preButton = button;
        }
        //已经添加的情况
        [button setTitle: obj.index forState:UIControlStateNormal];
        [button setTitleColor:[[ColorManager shareColorManager] colorWithString:@"textColor"] forState:UIControlStateNormal];
    }];
   
    [preButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-10);
    }];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)touchButton:(UIButton *)button{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Update" object:nil userInfo:@{@"title":@(button.tag - 100)}];
}

#pragma mark - 懒加载
- (UIViewController *)vc{
    if(_vc == nil) {
        _vc = [[UIViewController alloc] init];
        [self addSubview: _vc.view];
        [_vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _vc;
}

@end
