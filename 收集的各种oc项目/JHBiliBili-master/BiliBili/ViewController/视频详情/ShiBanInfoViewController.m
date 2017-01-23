//
//  ShiBanInfoViewController.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/24.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

#import "ShiBanInfoViewController.h"
#import "VideoViewController.h"
#import "AVItemTableViewController.h"
#import "ShiBanEpisodeCollectionViewController.h"

#import "ShiBanInfoViewModel.h"
#import "ShinBanModel.h"

#import "TakeHeadTableView.h"

#import "ShiBanEpisodesTableViewCell.h"

@interface ShiBanInfoViewController ()
@property (nonatomic, strong) UIImageView *shiBanCoverImgView;
@property (nonatomic, strong) UILabel *shiBanLabel;
@property (nonatomic, strong) UIImageView *shiBanPlayIcon;
@property (nonatomic, strong) UIImageView *shiBandanMuIcon;
@property (nonatomic, strong) UILabel *shiBanPlayLabel;
@property (nonatomic, strong) UILabel *shiBanDanMuLabel;
@property (nonatomic, strong) UILabel *shiBanUpDateLabel;
@property (nonatomic, strong) UIButton *shiBanPlayButton;
@property (nonatomic, strong) ShiBanEpisodeCollectionViewController *sevc;
@end

@implementation ShiBanInfoViewController

#pragma mark - 方法

- (instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateButtonTitleAndPlay:) name:@"Update" object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化属性
    [self setProperty];
}

- (void)setWithModel:(RecommentShinBanDataModel*)model{
    self.vm = [[ShiBanInfoViewModel alloc] init];
    self.navigationItem.title = model.title;
    [self.vm setAVData:model];
}

- (void)setProperty{
    [self.shiBanCoverImgView setImageWithURL: [self.vm shiBanCover]];
    self.shiBanLabel.text = [self.vm shiBanTitle];
    self.shiBanPlayLabel.text = [self.vm shinBanInfoPlayNum];
    self.shiBanDanMuLabel.text = [self.vm shinBanInfodanMuNum];
    self.shiBanUpDateLabel.text = [self.vm shinBanInfoUpdateTime];
    [self.shiBanPlayButton setTitle:[self.vm indexToTitle] == nil?@"N/A":[NSString stringWithFormat:@"播放第%@话",[self.vm indexToTitle]] forState:UIControlStateNormal];
}

- (void)updateButtonTitleAndPlay:(NSNotification *)notification{
    [self.vm setCurrentEpisode: notification.userInfo[@"title"]];
    [self.shiBanPlayButton setTitle:[NSString stringWithFormat:@"播放第%@话",[self.vm indexToTitle]] forState:UIControlStateNormal];
    VideoViewController* vc =[[VideoViewController alloc] initWithAid: [self.vm videoAid]];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)setOtherProperty{
    if ([self.downLoadView viewWithTag: 12] == nil) {
        self.sevc.view.tag = 12;
        [self.downLoadView addSubview: self.sevc.view];
        [self.sevc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo([self.downLoadView viewWithTag:11].mas_top);
        }];
    }
    [self.sevc.collectionView reloadData];
}

- (NSArray *)allEpisode{
    NSArray<episodesModel *>* episodes = [self.vm shinBanInfoEpisode];
    NSMutableArray* tempArr = [NSMutableArray array];
    [episodes enumerateObjectsUsingBlock:^(episodesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tempArr addObject: @{@"aid":obj.av_id,@"quality":self.resolution,@"cid":obj.av_cid,@"title":obj.index_title}];
    }];
    return tempArr;
}

#pragma mark - UITableViewController

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray* arr = @[@"承包商排行",@"番剧详情",[NSString stringWithFormat:@"评论(%ld)",(long)[self.vm allReply]]];
    
    WMMenuView* menuView = [[WMMenuView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, 30) buttonItems:arr backgroundColor:[[ColorManager shareColorManager] colorWithString:@"AVInfoViewController.menuView.backgroundColor"] norSize:15 selSize:15 norColor:[[ColorManager shareColorManager] colorWithString:@"textColor"] selColor:[[ColorManager shareColorManager] colorWithString:@"AVInfoViewController.menuView.selColor"]];
    menuView.lineColor = [[ColorManager shareColorManager] colorWithString:@"AVInfoViewController.menuView.lineColor"];
    menuView.delegate = self;
    menuView.style = WMMenuViewStyleLine;
    self.menuView = menuView;
    return menuView;
}




#pragma mark - 懒加载

- (UIImageView *)shiBanCoverImgView {
    if(_shiBanCoverImgView == nil) {
        _shiBanCoverImgView = [[UIImageView alloc] init];
        [self.tableView.tableHeaderView addSubview: _shiBanCoverImgView];
        [_shiBanCoverImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_offset(10);
            make.width.mas_equalTo(_shiBanCoverImgView.mas_height).multipliedBy(0.7);
            make.bottom.mas_offset(-10);
        }];
    }
    return _shiBanCoverImgView;
}

- (UILabel *)shiBanLabel {
    if(_shiBanLabel == nil) {
        _shiBanLabel = [[UILabel alloc] init];
        _shiBanLabel.font = [UIFont systemFontOfSize: 15];
        _shiBanLabel.numberOfLines = 2;
        _shiBanLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        [self.tableView.tableHeaderView addSubview: _shiBanLabel];
        [_shiBanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shiBanCoverImgView);
            make.left.mas_equalTo(self.shiBanCoverImgView.mas_right).mas_offset(10);
            make.right.mas_offset(-10);
            make.bottom.mas_equalTo(self.shiBanPlayIcon.mas_top).mas_offset(-10);
        }];
    }
    return _shiBanLabel;
}

- (UIImageView *)shiBanPlayIcon {
    if(_shiBanPlayIcon == nil) {
        UIImage *img = [[UIImage imageNamed:@"list_playnumb_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _shiBanPlayIcon = [[UIImageView alloc] initWithImage: img];
        _shiBanPlayIcon.tintColor = [UIColor grayColor];
        [self.tableView.tableHeaderView addSubview: _shiBanPlayIcon];
        [_shiBanPlayIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(13);
            make.height.mas_equalTo(10);
            make.left.equalTo(self.shiBanLabel);
            make.right.mas_equalTo(self.shiBanPlayLabel.mas_left).mas_offset(-2);
        }];
    }
    return _shiBanPlayIcon;
}

- (UIImageView *)shiBandanMuIcon {
    if(_shiBandanMuIcon == nil) {
        _shiBandanMuIcon = [[UIImageView alloc] init];
        
        UIImage *img = [[UIImage imageNamed:@"list_danmaku_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _shiBandanMuIcon = [[UIImageView alloc] initWithImage: img];
        _shiBandanMuIcon.tintColor = [UIColor grayColor];
        [self.tableView.tableHeaderView addSubview: _shiBandanMuIcon];
        [_shiBandanMuIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(13);
            make.height.mas_equalTo(10);
            make.centerY.equalTo(self.shiBanPlayIcon);
            make.right.mas_equalTo(self.shiBanDanMuLabel.mas_left).mas_offset(-2);
        }];
    }
    return _shiBandanMuIcon;
}

- (UILabel *)shiBanPlayLabel {
    if(_shiBanPlayLabel == nil) {
        _shiBanPlayLabel = [[UILabel alloc] init];
        _shiBanPlayLabel.font = [UIFont systemFontOfSize: 10];
        _shiBanPlayLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        [self.tableView.tableHeaderView addSubview: _shiBanPlayLabel];
        [_shiBanPlayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shiBanPlayIcon);
            make.right.mas_equalTo(self.shiBandanMuIcon.mas_left).mas_offset(-10);
        }];
    }
    return _shiBanPlayLabel;
}


- (UILabel *)shiBanDanMuLabel {
    if(_shiBanDanMuLabel == nil) {
        _shiBanDanMuLabel = [[UILabel alloc] init];
        _shiBanDanMuLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        _shiBanDanMuLabel.font = [UIFont systemFontOfSize: 10];
        [self.tableView.tableHeaderView addSubview: _shiBanDanMuLabel];
        [_shiBanDanMuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shiBanPlayIcon);
            make.right.mas_equalTo(self.shiBanPlayButton.mas_left).mas_equalTo(-10);
            make.bottom.mas_equalTo(self.shiBanUpDateLabel.mas_top).mas_offset(-10);
        }];
    }
    return _shiBanDanMuLabel;
}

- (UILabel *)shiBanUpDateLabel {
    if(_shiBanUpDateLabel == nil) {
        _shiBanUpDateLabel = [[UILabel alloc] init];
        _shiBanUpDateLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        _shiBanUpDateLabel.font = [UIFont systemFontOfSize: 11];
        [self.tableView.tableHeaderView addSubview: _shiBanUpDateLabel];
        [_shiBanUpDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.shiBanPlayIcon);
            make.right.mas_equalTo(self.shiBanPlayButton.mas_left).mas_offset(-10);
        }];
    }
    return _shiBanUpDateLabel;
}

- (UIButton *)shiBanPlayButton {
    if(_shiBanPlayButton == nil) {
        _shiBanPlayButton = [[UIButton alloc] init];
        [_shiBanPlayButton setBackgroundColor: [[ColorManager shareColorManager] colorWithString:@"themeColor"]];
        _shiBanPlayButton.layer.cornerRadius = 5;
        _shiBanPlayButton.titleLabel.font = [UIFont systemFontOfSize: 13];
        _shiBanPlayButton.titleLabel.numberOfLines = 0;
        _shiBanPlayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _shiBanPlayButton.layer.masksToBounds = YES;
        [_shiBanPlayButton addTarget:self action:@selector(updateButtonTitleAndPlay:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView.tableHeaderView addSubview: _shiBanPlayButton];
        [_shiBanPlayButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(73.5);
            make.height.mas_equalTo(37);
            make.right.mas_offset(-10);
            make.centerY.equalTo(self.shiBanCoverImgView);
        }];
        
    }
    return _shiBanPlayButton;
}


- (NSMutableArray *)controllers{
    if (_controllers == nil) {
        _controllers = [NSMutableArray array];
        
        AVItemTableViewController* inverstorVC = [[AVItemTableViewController alloc] initWithVM:self.vm cellIdentitys:@[@"InvestorTableViewCell"]];
        [_controllers addObject:inverstorVC];
        
        AVItemTableViewController* avInfoVC = [[AVItemTableViewController alloc] initWithVM:self.vm cellIdentitys:@[@"ShiBanEpisodesTableViewCell",@"ShiBanIntroduceTableViewCell"]];
        [_controllers addObject:avInfoVC];
        
        AVItemTableViewController* replyVC = [[AVItemTableViewController alloc] initWithVM:self.vm cellIdentitys:@[@"ReViewTableViewCell"]];
        //添加脚部刷新
        replyVC.tableView.mj_footer = [MyRefreshComplete myRefreshFoot:^{
            [self.vm getMoveReplyCompleteHandle:^(NSError *error) {
                [replyVC.tableView.mj_footer endRefreshing];
                [replyVC.tableView reloadData];
                if (error) [MBProgressHUD showMsg:kerrorMessage WithView:self.view];
            }];
        }];
        
        [_controllers addObject:replyVC];
    }
    return _controllers;
}

- (ShiBanEpisodeCollectionViewController *)sevc{
    if(_sevc == nil) {
        _sevc = [[ShiBanEpisodeCollectionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        _sevc.episodes = [self.vm shinBanInfoEpisode];
    }
    return _sevc;
}

@end
