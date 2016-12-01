//
//  NHHomeBaseViewController.m
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHHomeBaseViewController.h"
#import "NHHomeListRequest.h"
#import "NHHomeServiceDataModel.h"
#import "NHHomeTableViewCellFrame.h"
#import "NHHomeTableViewCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "NHBaseRequest.h"
#import "NHDynamicDetailViewController.h"
#import "NHDiscoverTopicViewController.h"
#import "NHPersonalCenterViewController.h"
#import "NHHomeNeiHanShareView.h"
#import "NHHomeTopTipView.h"
#import "WMPlayer.h"
#import "NHCustomAlertView.h"
#import "NHHomeDynamicRequest.h"
#import "NHDynamicDetailReportViewController.h"
#import "NHBaseNavigationViewController.h"
#import "UIViewController+Loading.h"

#define kTipTopViewH 30
@interface NHHomeBaseViewController () <NHHomeTableViewCellDelegate, WMPlayerDelegate>
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSMutableArray *cellFrameArray;
@property (nonatomic, strong) NHBaseRequest *request;
/** 提示视图*/
@property (nonatomic, weak) NHHomeTopTipView *topTipView;
/** 是否显示提示视图*/
@property (nonatomic, assign) BOOL showTopTipViewFlag;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) NHBaseImageView *imageView;
@property (nonatomic, assign) BOOL isSmallScreen;
@end

@implementation NHHomeBaseViewController {
    WMPlayer *wmPlayer;
}
#pragma mark - 构造
- (instancetype)initWithRequest:(NHBaseRequest *)request {
    if (self = [super init]) {
        self.request = request;
    }
    return self;
}

- (instancetype)initWithUrl:(NSString *)url {
    if (self = [super init]) {
        self.url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 不需要分割线
    self.needCellSepLine = NO;
    // 需要刷新icon
    self.showRefreshIcon = YES;
    // 可以刷新可以加载更多
    self.refreshType = NHBaseTableVcRefreshTypeRefreshAndLoadMore;
    
    [self showLoadingView];
    if (self.url.length) {
        NHHomeListRequest *request = [NHHomeListRequest nh_request];
        request.nh_url = self.url;
        self.request = request; 
        [self loadData];
    } else {
        [self loadData];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self releaseWMPlayer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (wmPlayer.superview) {
        CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:self.indexPath];
        CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
        if (rectInSuperview.origin.y < -self.imageView.frame.size.height || rectInSuperview.origin.y>kScreenHeight-kTopBarHeight-kTabBarHeight) {//往上拖动
            
            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]&&self.isSmallScreen) {
                self.isSmallScreen = YES;
            } else {
                [self releaseWMPlayer];
            }
        } else {
            if ([self.imageView.subviews containsObject:wmPlayer]) {
                
            } else {
                [self releaseWMPlayer];
            }
        }
    }
}

// 刷新
- (void)nh_refresh {
    [super nh_refresh];
    [self loadData];
}

// 加载更多
- (void)nh_loadMore {
    [super nh_loadMore];
    
    if (self.dataArray.count == 0) {
        return ;
    }
    // 内涵加载更多，是根据max_time来加载，不是根据page等字段，所以只需要传递当前time
    [self.request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        [self nh_endLoadMore];
        if (success) {
            
            NHHomeServiceDataModel *model = [NHHomeServiceDataModel modelWithDictionary:response];
            
            for (int i = 0; i < model.data.count; i++) {
                NHHomeServiceDataElement *element = model.data[i];
                
//                NHHomeServiceDataElementMediaTypeLargeImage = 1,
//                /** Gif图片*/
//                NHHomeServiceDataElementMediaTypeGif = 2,
//                /** 视频*/
//                NHHomeServiceDataElementMediaTypeVideo = 3,
//                /** 小图*/
//                NHHomeServiceDataElementMediaTypeLittleImages = 4,
                if (element.group && element.group.media_type < 5) {
                    [self.dataArray addObject:element];
                    NHHomeTableViewCellFrame *cellFrame = [[NHHomeTableViewCellFrame alloc] init];
                    cellFrame.model = element;
                    [self.cellFrameArray addObject:cellFrame];
                }
            }
            [self nh_reloadData];
        }
    }];
    
}

- (void)loadData {
    if (!self.request) return ;
    [self.request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            [self hideLoadingView]; 
//
            // 1. 停止旋转动画
            [self endRefreshIconAnimation];
//
            // 2. 显示提示视图
            NHHomeServiceDataModel *model = [NHHomeServiceDataModel modelWithDictionary:response];
            if (model.tip.length && _dataArray != nil && _cellFrameArray != nil) {
            self.topTipView.hidden = NO;
                self.topTipView.tipText = model.tip;
                self.showTopTipViewFlag = YES;
            } else {
            self.topTipView.hidden = YES;
                [self nh_endRefresh];
            }
            // 3. 更新数据
            [self.cellFrameArray removeAllObjects];
            [self.dataArray removeAllObjects];
            
            for (int i = 0; i < model.data.count; i++) {
                NHHomeServiceDataElement *element = model.data[i];
//                if (element.group) {
                
                if (element.group && element.group.media_type < 5) {
                    [self.dataArray addObject:element];
                    NHHomeTableViewCellFrame *cellFrame = [[NHHomeTableViewCellFrame alloc] init];
                    cellFrame.model = element;
                    [self.cellFrameArray addObject:cellFrame];
                }
            }
            [self nh_reloadData];
        }
    }];
}

// 提示视图
- (void)setShowTopTipViewFlag:(BOOL)showTopTipViewFlag {
    _showTopTipViewFlag = showTopTipViewFlag;
    [UIView animateWithDuration:0.4 animations:^{
        self.topTipView.frame = CGRectMake(0, 0, self.view.width, kTipTopViewH);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self nh_endRefresh];
            [UIView animateWithDuration:0.4 animations:^{
                self.topTipView.frame = CGRectMake(0, - kTipTopViewH, 0, kTipTopViewH);
            }];
        });
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)nh_numberOfSections {
    return 1;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NHBaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath {
    // 1. 创建cell
    NHHomeTableViewCell *cell = [NHHomeTableViewCell cellWithTableView:self.tableView];
    
    // 2. 设置数据
    NHHomeTableViewCellFrame *cellFrame = self.cellFrameArray[indexPath.row];
    cell.cellFrame = cellFrame;
    cell.delegate = self;
    cell.isFromHomeController = YES;
    
    // 3. 返回cell
    return cell;
}

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(NHBaseTableViewCell *)cell {
    NHDynamicDetailViewController *controller = [[NHDynamicDetailViewController alloc] initWithCellFrame:self.cellFrameArray[indexPath.row]];
    [self pushVc:controller];
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    NHHomeTableViewCellFrame *cellFrame = self.cellFrameArray[indexPath.row];
    return cellFrame.cellHeight;
}

#pragma mark - NHHomeTableViewCellDelegate
- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickImageView:(UIImageView *)imageView currentIndex:(NSInteger)currentIndex urls:(NSArray<NSURL *> *)urls {
    MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc] init];
    NSMutableArray *photoArray = [NSMutableArray new];
    for (NSURL *imageURL in urls) {
        MJPhoto *photo = ({
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.url = imageURL;
            photo.srcImageView = imageView;
            photo;
        });
        [photoArray addObject:photo];
    }
    photoBrowser.photos = photoArray;
    photoBrowser.currentPhotoIndex = currentIndex;
    [photoBrowser show];
}

- (void)homeTableViewCellDidClickCategory:(NHHomeTableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NHHomeServiceDataElement *element = self.dataArray[indexPath.row];
    NHDiscoverTopicViewController *controller = [[NHDiscoverTopicViewController alloc] initWithCatogoryId:element.group.category_id];
    controller.navigationItem.title = element.group.category_name;
    [self pushVc:controller];
}

- (void)homeTableViewCellDidClickClose:(NHHomeTableViewCell *)cell {
    NHCustomAlertView *alert = [[NHCustomAlertView alloc] initWithTitle:@"确认删除后，内涵段子将减少给您推荐类似的内容，您确认要删除吗？" cancel:@"取消" sure:@"确认删除"];
    [alert showInView:self.view.window];
    WeakSelf(weakSelf);
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [alert setupSureBlock:^BOOL{
        [weakSelf deleteDynamicAtIndexPath:indexPath];
        return YES;
    }];
}

- (void)deleteDynamicAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.cellFrameArray removeObjectAtIndex:indexPath.row];
    [self.tableView nh_deleteSingleRowAtIndexPath:indexPath];
}

- (void)homeTableViewCell:(NHHomeTableViewCell *)cell gotoPersonalCenterWithUserInfo:(NHNeiHanUserInfoModel *)userInfoModel {
    NHPersonalCenterViewController *personalCenter = [[NHPersonalCenterViewController alloc] initWithUserInfoModel:userInfoModel];
    [self pushVc:personalCenter];
}

- (void)requestActionWithActionname:(NSString *)actionname indexPath:(NSIndexPath *)indexPath {
    
    NHHomeTableViewCellFrame *cellFrame = [self.cellFrameArray objectAtIndex:indexPath.row];
    NHHomeDynamicRequest *request = [NHHomeDynamicRequest nh_request];
    request.group_id = cellFrame.model.group.ID;
    request.nh_url = kNHHomeDynamicLikeAPI;
    request.action = actionname;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            // 指针不变，只需要更换值
            NHHomeTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if ([actionname isEqualToString:@"digg"]) {
                if (cellFrame.model.group.user_digg) return ;
                cellFrame.model.group.user_digg = 1;
                cellFrame.model.group.digg_count += 1;
                [cell didDigg];
            } else if ([actionname isEqualToString:@"bury"]) {
                if (cellFrame.model.group.user_bury) return ;
                cellFrame.model.group.user_bury = 1;
                cellFrame.model.group.bury_count += 1;
                [cell didBury];
            } else if ([actionname isEqualToString:@"repin"]) { // 收藏
                cellFrame.model.group.user_repin = 1;
            } else if ([actionname isEqualToString:@"unrepin"]) { // 取消收藏
                cellFrame.model.group.user_repin = 0;
            }
        }
    }];
 
}

- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickItemWithType:(NHHomeTableViewCellItemType)itemType {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    // 数据
    NHHomeTableViewCellFrame *cellFrame = [self.cellFrameArray objectAtIndex:indexPath.row];
    WeakSelf(weakSelf);
    switch (itemType) {
        case NHHomeTableViewCellItemTypeLike: {
            [self requestActionWithActionname:@"digg" indexPath:indexPath];
        } break;
            
        case NHHomeTableViewCellItemTypeDontLike: {
            [self requestActionWithActionname:@"bury" indexPath:indexPath];
        } break;
            
        case NHHomeTableViewCellItemTypeComment: {
            
            // 跳转
            NHDynamicDetailViewController *controller = [[NHDynamicDetailViewController alloc] initWithCellFrame:cellFrame];
            [self pushVc:controller];
        } break;
            
        case NHHomeTableViewCellItemTypeShare: {
            NHHomeNeiHanShareView *share = [NHHomeNeiHanShareView shareViewWithType:NHHomeNeiHanShareViewTypeShowCopyAndCollect hasRepinFlag:cellFrame.model.group.user_repin];
            [share showInView:self.view];
            [share setUpItemClickHandle:^(NHHomeNeiHanShareView *shareView, NSString *title, NSInteger index, NHNeiHanShareType shareType) {
                [[NHNeiHanShareManager sharedManager] shareWithSharedType:shareType image:nil url:@"www.baidu.com" content:@"不错" controller:weakSelf];
            }];
            [share setUpBottomItemClickHandle:^(NHHomeNeiHanShareView *shareView, NSString *title, NSInteger index) {
               
                switch (index) {
                    case 0: {
                        NSString *shareUrl = cellFrame.model.group.share_url;
                        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                        pasteboard.string = shareUrl;
                        [MBProgressHUD showSuccess:@"已复制" toView:self.view];
                    } break;
                        
                    case 1: {
                        [self requestActionWithActionname:cellFrame.model.group.user_repin ? @"unrepin" : @"repin" indexPath:indexPath];
                    } break;
                        
                    case 2: {
                        NHDynamicDetailReportViewController *controller = [[NHDynamicDetailReportViewController alloc] init];
                        NHBaseNavigationViewController *nav = [[NHBaseNavigationViewController alloc] initWithRootViewController:controller];
                        [self presentVc:nav];
                    } break;
                        
                    default:
                        break;
                }
            }];
            
        }
            
            break;
            
        default:
            break;
    }
}

- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickVideoWithVideoUrl:(NSString *)videoUrl videoCover:(NHBaseImageView *)baseImageView {
    
    self.indexPath = [self.tableView indexPathForCell:cell];
    self.imageView = baseImageView;
    
    wmPlayer = [[WMPlayer alloc]initWithFrame:baseImageView.bounds];
    wmPlayer.delegate = self;
    wmPlayer.closeBtnStyle = CloseBtnStyleClose;
    wmPlayer.URLString = videoUrl;
    [baseImageView addSubview:wmPlayer];
    [wmPlayer play];
    

}

#pragma mark - WMPlayerDelegate
- (BOOL)prefersStatusBarHidden {
    if (wmPlayer) {
        if (wmPlayer.isFullscreen) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

- (void)toCell {
    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = self.imageView.bounds;
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [self.imageView addSubview:wmPlayer];
        [self.imageView bringSubviewToFront:wmPlayer];
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer.topView).with.offset(45);
            make.right.equalTo(wmPlayer.topView).with.offset(-45);
            make.center.equalTo(wmPlayer.topView);
            make.top.equalTo(wmPlayer.topView).with.offset(0);
        }];
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
        }];
        [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wmPlayer);
            make.width.equalTo(wmPlayer);
            make.height.equalTo(@30);
        }];
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        self.isSmallScreen = NO;
        wmPlayer.fullScreenBtn.selected = NO;
        
    }];
    
    
}

- (void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation {
    [wmPlayer removeFromSuperview];
    wmPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    } else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    wmPlayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    wmPlayer.playerLayer.frame =  CGRectMake(0,0, kScreenHeight,kScreenWidth);
    
    [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(kScreenWidth-40);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.equalTo(wmPlayer).with.offset(0);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wmPlayer).with.offset((-kScreenHeight/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(wmPlayer).with.offset(5);
        
    }];
    
    [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wmPlayer.topView).with.offset(45);
        make.right.equalTo(wmPlayer.topView).with.offset(-45);
        make.center.equalTo(wmPlayer.topView);
        make.top.equalTo(wmPlayer.topView).with.offset(0);
    }];
    
    [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenHeight);
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-36, -(kScreenWidth/2)));
        make.height.equalTo(@30);
    }];
    
    [wmPlayer.loadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-37, -(kScreenWidth/2-37)));
    }];
    [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenHeight);
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-36, -(kScreenWidth/2)+36));
        make.height.equalTo(@30);
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
    
    wmPlayer.fullScreenBtn.selected = YES;
    [wmPlayer bringSubviewToFront:wmPlayer.bottomView];
    
}

- (void)toSmallScreen {
    // 放widow上
    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.3f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = CGRectMake(kScreenWidth/2,kScreenHeight-kTabBarHeight-(kScreenWidth/2)*0.75, kScreenWidth/2, (kScreenWidth/2)*0.75);
        wmPlayer.playerLayer.frame = wmPlayer.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer.topView).with.offset(45);
            make.right.equalTo(wmPlayer.topView).with.offset(-45);
            make.center.equalTo(wmPlayer.topView);
            make.top.equalTo(wmPlayer.topView).with.offset(0);
        }];
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
            
        }];
        [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wmPlayer);
            make.width.equalTo(wmPlayer);
            make.height.equalTo(@30);
        }];
        
    } completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        wmPlayer.fullScreenBtn.selected = NO;
        self.isSmallScreen = YES;
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:wmPlayer];
    }];
}

- (void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn {
    if (wmplayer.isFullscreen) {
        wmplayer.isFullscreen = NO;
        [self toCell];
    } else {
        [self releaseWMPlayer];
    }
    
}

- (void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn {
    if (fullScreenBtn.isSelected) {//全屏显示
        wmPlayer.isFullscreen = YES;
        [self setNeedsStatusBarAppearanceUpdate];
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    } else {
        if (self.isSmallScreen) {
            // 放widow上,小屏显示
            [self toSmallScreen];
        } else {
            [self toCell];
        }
    }
}

- (void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    NSLog(@"didSingleTaped");
}

- (void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"didDoubleTaped");
}

- (void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state {
    NSLog(@"wmplayerDidFailedPlay");
}

- (void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state {
    NSLog(@"wmplayerDidReadyToPlay");
}

- (void)wmplayerFinishedPlay:(WMPlayer *)wmplayer {
    [self releaseWMPlayer];
}

- (void)releaseWMPlayer {
    [wmPlayer pause];
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [wmPlayer.autoDismissTimer invalidate];
    wmPlayer.autoDismissTimer = nil;
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
    wmPlayer = nil;
}

- (NSMutableArray *)cellFrameArray {
    if (!_cellFrameArray) {
        _cellFrameArray = [NSMutableArray new];
    }
    return _cellFrameArray;
}

- (NHHomeTopTipView *)topTipView {
    if (!_topTipView) {
        NHHomeTopTipView *topTipView = [[NHHomeTopTipView alloc] initWithFrame:CGRectMake(0, - kTipTopViewH, self.view.width, kTipTopViewH)];
        [self.view addSubview:topTipView];
        _topTipView = topTipView;
    }
    return _topTipView;
}
@end
