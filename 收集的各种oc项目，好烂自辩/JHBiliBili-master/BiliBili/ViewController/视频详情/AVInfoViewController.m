//
//  AVInfoViewController.m
//  BiliBili
//
//  Created by apple-jd44 on 15/11/1.
//  Copyright © 2015年 JimHuang. All rights reserved.
//

//滑动视图高

#import "AVInfoViewController.h"
#import "VideoViewController.h"
#import "AVItemTableViewController.h"
#import "ShiBanEpisodeCollectionViewController.h"
#import "JHViewController.h"

#import "WMMenuView.h"
#import "TakeHeadTableView.h"

#import "AVInfoViewModel.h"

#import "ShiBanEpisodesTableViewCell.h"

@interface AVInfoViewController ()

//up名
@property (strong, nonatomic) UILabel *UPLabel;
//视频缩略图
@property (strong, nonatomic) UIImageView *imgView;
//播放数
@property (strong, nonatomic) UILabel *playNumLabel;
//弹幕数
@property (strong, nonatomic) UILabel *danMuNumLabel;
//发布时间
@property (strong, nonatomic) UILabel *publicTimeLabel;
//视频标题
@property (strong, nonatomic) UILabel *titleLabel;
//播放按钮
@property (strong, nonatomic) UIButton *playButton;

@property (nonatomic, strong) ShiBanEpisodeCollectionViewController *sevc;
@end


@implementation AVInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self colorSetting];
    //初始化属性
    [self setProperty];
}

#pragma mark - UITableViewController
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSMutableArray* arr = [@[@"视频详情",@"相关视频",[NSString stringWithFormat:@"评论(%ld)",(long)[self.vm allReply]]] mutableCopy];
    if ([self.vm isShiBan]) {
        [arr insertObject:@"承包商排行" atIndex:0];
    }
    
    WMMenuView* menuView = [[WMMenuView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, 30) buttonItems:arr backgroundColor:[[ColorManager shareColorManager] colorWithString:@"AVInfoViewController.menuView.backgroundColor"] norSize:15 selSize:15 norColor:[[ColorManager shareColorManager] colorWithString:@"textColor"] selColor:[[ColorManager shareColorManager] colorWithString:@"AVInfoViewController.menuView.selColor"]];
    menuView.lineColor = [[ColorManager shareColorManager] colorWithString:@"AVInfoViewController.menuView.lineColor"];
    menuView.style = WMMenuViewStyleLine;
    menuView.delegate = self;
    self.menuView = menuView;
    return menuView;
}



#pragma mark - 方法
- (void)setWithModel:(AVDataModel*)model section:(NSString*)section{
    self.vm = [[AVInfoViewModel alloc] init];
    [self.vm setAVData:model section:section];
    self.navigationItem.title = [NSString stringWithFormat:@"av%@", model.aid];
}

- (NSArray *)allEpisode{
    return @[@{@"aid":[self.vm videoAid],@"quality":self.resolution,@"cid":[self.vm videoCid],@"title":[self.vm videoTitle]}];
}

/**
 *  初始化一般视频信息
 */
- (void)setProperty{
    //设置up名
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"UP主："];
    NSString* upName = [self.vm infoUpName];
    if (upName) {
        [str appendAttributedString:[[NSMutableAttributedString alloc] initWithString: [self.vm infoUpName] attributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),NSForegroundColorAttributeName:[[ColorManager shareColorManager] colorWithString:@"AVInfoViewController.UPLabel.textColor"]}]];
        [self.UPLabel setAttributedText:str];
    }
    
    //播放数
    self.playNumLabel.text = [NSString stringWithFormat:@"播放：%@", [self.vm infoPlayNum]];
    //弹幕数
    NSString* danMuCount = [self.vm infoDanMuCount];
    if (danMuCount) {
        self.danMuNumLabel.text = [NSString stringWithFormat:@"弹幕数：%@", danMuCount];
    }
    //创建时间
    NSString* pubTime = [self.vm infoTime];
    if (pubTime) {        
        self.publicTimeLabel.text = [NSString stringWithFormat:@"发布于：%@", pubTime];
    }
    //图片URL
    [self.imgView setImageWithURL: [self.vm infoImgURL]];
    //标题
    self.titleLabel.text = [self.vm infoTitle];
    
    [self.playButton setTitle:@"点击播放" forState:UIControlStateNormal];
}

- (void)setOtherProperty{
    if ([self.downLoadView viewWithTag: 13] == nil) {
        self.sevc.view.tag = 13;
        [self.downLoadView addSubview: self.sevc.view];
        [self.sevc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo([self.downLoadView viewWithTag:11].mas_top);
        }];
    }
    [self.sevc.collectionView reloadData];
}

- (void)colorSetting{
    [super colorSetting];
    self.titleLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
}

- (void)playButtonDown:(UIButton*)button{
    [self presentViewController:[[VideoViewController alloc] initWithAid:[self.vm videoAid]] animated:YES completion:nil];
}


#pragma mark - 懒加载

- (NSMutableArray *)controllers{
    if (_controllers == nil) {
        _controllers = [NSMutableArray array];
        if ([self.vm isShiBan]) {
            AVItemTableViewController* inverstorVC = [[AVItemTableViewController alloc] initWithVM:self.vm cellIdentitys:@[@"InvestorTableViewCell"]];
            [_controllers addObject:inverstorVC];
        }
        
        AVItemTableViewController* avInfoVC = [[AVItemTableViewController alloc] initWithVM:self.vm cellIdentitys:@[@"AVItemTableViewCell"]];
        [_controllers addObject:avInfoVC];
        
        AVItemTableViewController* sameVideoVC = [[AVItemTableViewController alloc] initWithVM:self.vm cellIdentitys:@[@"SameVideoTableViewCell"]];
        [_controllers addObject:sameVideoVC];
        
        
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


- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        [self.tableView.tableHeaderView addSubview: _imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(72);
            make.width.mas_equalTo(117);
            make.top.left.mas_offset(EDGE);
        }];
    }
    return _imgView;
}

- (UILabel *)UPLabel{
    if (_UPLabel == nil) {
        _UPLabel = [[UILabel alloc] init];
        _UPLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        _UPLabel.font = [UIFont systemFontOfSize:13];
        [self.tableView.tableHeaderView addSubview: _UPLabel];
        [_UPLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView);
            make.top.mas_equalTo(self.imgView.mas_bottom);
            make.height.equalTo(@[self.playNumLabel,self.danMuNumLabel,self.publicTimeLabel]);
        }];
    }
    return _UPLabel;
}


- (UILabel *)playNumLabel{
    if (_playNumLabel == nil) {
        _playNumLabel = [[UILabel alloc] init];
        _playNumLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        _playNumLabel.font = [UIFont systemFontOfSize:13];
        [self.tableView.tableHeaderView addSubview: _playNumLabel];
        [_playNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView);
            make.top.mas_equalTo(self.UPLabel.mas_bottom);
        }];
    }
    return _playNumLabel;
}

- (UILabel *)danMuNumLabel{
    if (_danMuNumLabel == nil) {
        _danMuNumLabel = [[UILabel alloc] init];
        _danMuNumLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        _danMuNumLabel.font = [UIFont systemFontOfSize:13];
        [self.tableView.tableHeaderView addSubview: _danMuNumLabel];
        [_danMuNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.playNumLabel.mas_right).mas_offset(EDGE);
            make.top.equalTo(self.playNumLabel);
        }];
    }
    return _danMuNumLabel;
}

- (UILabel *)publicTimeLabel{
    if (_publicTimeLabel == nil) {
        _publicTimeLabel = [[UILabel alloc] init];
        _publicTimeLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        _publicTimeLabel.font = [UIFont systemFontOfSize:13];
        [self.tableView.tableHeaderView addSubview: _publicTimeLabel];
        [_publicTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.playNumLabel.mas_left);
            make.top.mas_equalTo(self.playNumLabel.mas_bottom);
            make.bottom.mas_offset(-EDGE);
        }];
    }
    return _publicTimeLabel;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode = NSLineBreakByClipping;
        _titleLabel.textColor = [[ColorManager shareColorManager] colorWithString:@"textColor"];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self.tableView.tableHeaderView addSubview: _titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imgView.mas_right).mas_offset(EDGE);
            make.right.mas_offset(-EDGE);
            make.top.equalTo(self.imgView);
        }];
    }
    return _titleLabel;
}

- (UIButton *)playButton{
    if (_playButton == nil) {
        _playButton = [[UIButton alloc] init];
        _playButton.layer.cornerRadius = 5;
        _playButton.titleLabel.font = [UIFont systemFontOfSize: 13];
        [_playButton addTarget:self action:@selector(playButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        
        [_playButton setBackgroundColor:[[ColorManager shareColorManager] colorWithString:@"themeColor"]];
        [self.tableView.tableHeaderView addSubview: _playButton];
        [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(71);
            make.height.mas_equalTo(37);
            make.bottom.right.mas_equalTo(self.tableView.tableHeaderView).mas_offset(-EDGE);
        }];
    }
    return _playButton;
}


- (ShiBanEpisodeCollectionViewController *)sevc{
    if(_sevc == nil) {
        _sevc = [[ShiBanEpisodeCollectionViewController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        _sevc.episodes = @[[self.vm AVModel2EpisodesModel]];
    }
    return _sevc;
}

@end
