//
//  NHPersonalCenterViewController.m
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHPersonalCenterViewController.h"
#import "NHPersonalCenterHeaderView.h"
#import "NHBaseTableViewCell.h"
#import "NHNeiHanUserInfoModel.h"
#import "NHPersonalCenterRequest.h"
#import "NHNeiHanUserInfoModel.h"
#import "NHUserInfoManager.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "NHFansAndAttentionViewController.h"
#import "NHDiscoverHeaderPageControl.h"
#import "NHCustomActionSheet.h"
#import "NHPersonalCenterRequest.h"
#import "NHPersonalCenterSectionHeaderView.h"
#import "UIViewController+Loading.h"
#import "NHHomeTableViewCell.h"
#import "NHHomeTableViewCellFrame.h"
#import "NHDynamicDetailCommentCellFrame.h"
#import "NHDynamicDetailCommentTableViewCell.h"
#import "NHHomeServiceDataModel.h"
#import "NHDynamicDetailViewController.h"
#import "NHDiscoverTopicViewController.h"
#import "NHHomeNeiHanShareView.h"
#import "NHUserInfoViewController.h"
#import "NHCustomAlertView.h"
#import "NHCustomCommonEmptyView.h"
#import "NHHomeDynamicRequest.h"
#import "WMPlayer.h"
@interface NHPersonalCenterViewController () <NHHomeTableViewCellDelegate, NHPersonalCenterHeaderViewDelegate , NHPersonalCenterSectionHeaderViewDelegate, NHDynamicDetailCommentTableViewCellDelegate, WMPlayerDelegate>
@property (nonatomic, strong) NSMutableArray *cellFrameArray;
/** 头部视图*/
@property (nonatomic, strong) NHPersonalCenterHeaderView *headerView;
/** 用户基本信息*/
@property (nonatomic, strong) NHNeiHanUserInfoModel *userInfoModel;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NHPersonalCenterSectionHeaderViewItemType itemType;
@property (nonatomic, strong) NHPersonalCenterSectionHeaderView *sectionHeaderView;
@property (nonatomic, weak) NHCustomCommonEmptyView *emptyView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) NHBaseImageView *imageView;
@property (nonatomic, assign) BOOL isSmallScreen;
@end

@implementation NHPersonalCenterViewController {
    WMPlayer *wmPlayer;
}

- (instancetype)initWithUserId:(NSInteger)userId {
    if (self = [super init]) {
        self.userId = userId;
    }
    return self;
}

- (instancetype)initWithUserInfoModel:(NHNeiHanUserInfoModel *)userInfoModel {
    if (self = [super init]) {
        self.userInfoModel = userInfoModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpItems];
    
    // 请求数据
    [self loadData];
}

- (void)setUpItems {
    // 标题
    self.navItemTitle = @"个人中心";
    
    // 退出登陆
    if ([NHUtils isCurrentUserWithUserId:self.userInfoModel.user_id]) {
        WeakSelf(weakSelf);
        [self nh_setUpNavRightItemTitle:@"退出登录" handle:^(NSString *rightItemTitle) {
            NHUserInfoViewController *userInfo = [[NHUserInfoViewController alloc] init];
            [weakSelf pushVc:userInfo];
        }];
    }
}

- (void)loadData {
    self.headerView.userInfoModel = self.userInfoModel;
    
    NHPersonalCenterRequest *request = [NHPersonalCenterRequest nh_request];
    request.nh_url = kNHUserProfileInfoAPI;
    request.user_id = self.userId ? self.userId : self.userInfoModel.user_id;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            self.userInfoModel = [NHNeiHanUserInfoModel modelWithDictionary:response];
            self.headerView.userInfoModel = self.userInfoModel;
        }
    }];
    
}

- (void)setItemType:(NHPersonalCenterSectionHeaderViewItemType)itemType {
    _itemType = itemType;
    
    [self.dataArray removeAllObjects];
    [self.cellFrameArray removeAllObjects];
    [self.tableView reloadData];
    [self releaseWMPlayer];
    [self.tableView setContentOffset:CGPointZero animated:YES];
    
    NSString *url = nil;
    if (itemType == NHPersonalCenterSectionHeaderViewItemTypePublish) { // 投稿
        url = kNHUserPublishDraftListAPI;
    } else if (itemType == NHPersonalCenterSectionHeaderViewItemTypeCol) { // 收藏
        url = kNHUserColDynamicListAPI;
    } else if (itemType == NHPersonalCenterSectionHeaderViewItemTypeComment) { // 评论
        url = kNHUserDynamicCommentListAPI;
    }
    
    if (url) {
        NHPersonalCenterRequest *request = [NHPersonalCenterRequest nh_request];
        request.nh_url = url;
        request.user_id = self.userInfoModel.user_id ? self.userInfoModel.user_id : self.userId;
        [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
            if (success) {
                // 投稿和收藏
                if (itemType == NHPersonalCenterSectionHeaderViewItemTypePublish || itemType == NHPersonalCenterSectionHeaderViewItemTypeCol) {
                    NHHomeServiceDataModel *homeServiceData = [NHHomeServiceDataModel modelWithDictionary:response];
                    for (NHHomeServiceDataElement *element in homeServiceData.data) {
                        if (element.group) {
                            [self.dataArray addObject:element];
                            NHHomeTableViewCellFrame *cellFrame = [[NHHomeTableViewCellFrame alloc] init];
                            cellFrame.model = element;
                            [self.cellFrameArray addObject:cellFrame];
                        }
                    }
                    [self nh_reloadData];
                    if (itemType == NHPersonalCenterSectionHeaderViewItemTypePublish) {
                        [self emptyWithHiddenFlag:self.dataArray.count iconImage:@"nosubmission" text:@"不会发段子的土豪不是好逗比"];
                    } else {
                        [self emptyWithHiddenFlag:self.dataArray.count iconImage:@"nocollection" text:@"问君能有几多愁，恰似一个段子我没留"];
                    }
                } else if (itemType == NHPersonalCenterSectionHeaderViewItemTypeComment) { // 评论
                    for (NSDictionary *dict in response[@"data"]) {
                        NHHomeServiceDataElementComment *comment = [NHHomeServiceDataElementComment modelWithDictionary:dict[@"comment"]];
                        if (comment) {
                            [self.dataArray addObject:comment];
                            NHDynamicDetailCommentCellFrame *cellFrame = [[NHDynamicDetailCommentCellFrame alloc] init];
                            cellFrame.commentModel = comment;
                            [self.cellFrameArray addObject:cellFrame];
                        }
                    }
                    [self nh_reloadData];
                    [self emptyWithHiddenFlag:self.dataArray.count iconImage:@"nocomment" text:@"发挥你的想象力，给别人评论一下去吧"];
                }
            }
        }];
    }
}

- (void)emptyWithHiddenFlag:(BOOL)hiddenFlag iconImage:(NSString *)iconname text:(NSString *)text {
    self.emptyView.topTipImageView.image = [UIImage imageNamed:iconname];
    self.emptyView.secondL.text = text;
    self.emptyView.hidden = hiddenFlag;
}

#pragma mark - UITableViewDelegate
- (NHBaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.itemType == NHPersonalCenterSectionHeaderViewItemTypePublish || self.itemType == NHPersonalCenterSectionHeaderViewItemTypeCol) {
        // 1. 创建cell
        NHHomeTableViewCell *cell = [NHHomeTableViewCell cellWithTableView:self.tableView];
        
        // 2. 设置数据
        NHHomeTableViewCellFrame *cellFrame = self.cellFrameArray[indexPath.row];
        cell.cellFrame = cellFrame;
        cell.delegate = self;
        
        // 3. 返回cell
        return cell;
    } else {
        NHDynamicDetailCommentTableViewCell *cell = [NHDynamicDetailCommentTableViewCell cellWithTableView:self.tableView];
        
        // 2. 设置数据
        NHDynamicDetailCommentCellFrame *cellFrame = self.cellFrameArray[indexPath.row];
        cell.cellFrame = cellFrame;
        cell.delegate = self;
        
        // 3. 返回cell
        return cell;
    }
}

- (NSInteger)nh_numberOfSections {
    return 1;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UIView *)nh_headerAtSection:(NSInteger)section {
    
    if (section == 0) {
        return self.sectionHeaderView;
    }
    
    return [UIView new];
}

- (CGFloat)nh_sectionHeaderHeightAtSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    NHBaseTableHeaderFooterView *headerFooterView = (NHBaseTableHeaderFooterView *)view;
    headerFooterView.contentView.backgroundColor = kWhiteColor;
}

- (void)nh_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(NHBaseTableViewCell *)cell {
    if (self.itemType == NHPersonalCenterSectionHeaderViewItemTypePublish || self.itemType == NHPersonalCenterSectionHeaderViewItemTypeCol) {
        NHDynamicDetailViewController *controller = [[NHDynamicDetailViewController alloc] initWithCellFrame:self.cellFrameArray[indexPath.row]];
        [self pushVc:controller];
    }
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    if (self.itemType == NHPersonalCenterSectionHeaderViewItemTypePublish || self.itemType == NHPersonalCenterSectionHeaderViewItemTypeCol) {
        NHHomeTableViewCellFrame *cellFrame = self.cellFrameArray[indexPath.row];
        return cellFrame.cellHeight;
    }
    NHDynamicDetailCommentCellFrame *cellFrame = self.cellFrameArray[indexPath.row];
    return cellFrame.cellHeight;
}

#pragma mark - NHHomeTableViewCellDelegate
// 浏览大图
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

// 跳转到指定类型界面
- (void)homeTableViewCellDidClickCategory:(NHHomeTableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NHHomeServiceDataElement *element = self.dataArray[indexPath.row];
    NHDiscoverTopicViewController *controller = [[NHDiscoverTopicViewController alloc] initWithCatogoryId:element.group.category_id];
    [self pushVc:controller];
}

// 个人中心
- (void)homeTableViewCell:(NHHomeTableViewCell *)cell gotoPersonalCenterWithUserInfo:(NHNeiHanUserInfoModel *)userInfoModel {
    NHPersonalCenterViewController *personalCenter = [[NHPersonalCenterViewController alloc] initWithUserInfoModel:userInfoModel];
    [self pushVc:personalCenter];
}

- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickItemWithType:(NHHomeTableViewCellItemType)itemType {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NHHomeTableViewCellFrame *cellFrame = [self.cellFrameArray objectAtIndex:indexPath.row];
    WeakSelf(weakSelf);
    switch (itemType) {
            
        case NHHomeTableViewCellItemTypeLike: {
            [self requestActionWithActionname:@"digg" indexPath:indexPath];
        }
            break;
            
        case NHHomeTableViewCellItemTypeDontLike: {
            [self requestActionWithActionname:@"bury" indexPath:indexPath];
        }
            
            break;
        case NHHomeTableViewCellItemTypeComment: {
            
            // 跳转
            NHDynamicDetailViewController *controller = [[NHDynamicDetailViewController alloc] initWithCellFrame:cellFrame];
            [self pushVc:controller];
        }
        case NHHomeTableViewCellItemTypeShare: {
            NHHomeNeiHanShareView *share = [NHHomeNeiHanShareView shareViewWithType:NHHomeNeiHanShareViewTypeDontShowCopyAndCollect];
            [share showInView:self.view];
            [share setUpItemClickHandle:^(NHHomeNeiHanShareView *shareView, NSString *title, NSInteger index, NHNeiHanShareType shareType) {
                [[NHNeiHanShareManager sharedManager] shareWithSharedType:shareType image:nil url:@"www.baidu.com" content:@"不错" controller:weakSelf];
            }];
        }
            break;
            
        default:
            break;
    }
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

// 播放器事件
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

///播放状态
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

#pragma mark - NHPersonalCenterSectionHeaderViewDelegate
// 投稿、收藏、评论
- (void)personalCenterSectionHeaderView:(NHPersonalCenterSectionHeaderView *)headerView didClickItemwithType:(NHPersonalCenterSectionHeaderViewItemType)type {
    self.itemType = type;
}

#pragma mark - NHPersonalCenterHeaderViewDelegate
- (void)personalCenterHeaderView:(NHPersonalCenterHeaderView *)headerView didClickItemWithType:(NHPersonalCenterHeaderViewItemType)itemType {
    
    // 粉丝和关注
    if (itemType == NHPersonalCenterHeaderViewItemTypeGotoFans) {
        NHFansAndAttentionViewController *attention = [[NHFansAndAttentionViewController alloc ] initWithUserId:self.userInfoModel.user_id vcType:NHFansAndAttentionViewControllerFans];
        [self pushVc:attention];
    } else if (itemType == NHPersonalCenterHeaderViewItemTypeGotoAtt) {
        NHFansAndAttentionViewController *attention = [[NHFansAndAttentionViewController alloc ] initWithUserId:self.userInfoModel.user_id vcType:NHFansAndAttentionViewControllerAttention];
        [self pushVc:attention];
    } else if (itemType == NHPersonalCenterHeaderViewItemTypeGotoIntegral) { // 积分
        
    } else if (itemType == NHPersonalCenterHeaderViewItemTypeAvatar) { // 头像
        if ([NHUtils isCurrentUserWithUserId:self.userInfoModel.user_id]) {
            NHCustomActionSheet *actionSheet = [NHCustomActionSheet actionSheetWithCancelTitle:@"取消" alertTitle:@"更换头像" SubTitles:@"相册",@"拍照", nil];
            [actionSheet show];
            [actionSheet setCustomActionSheetItemClickHandle:^(NHCustomActionSheet *actionSheet, NSInteger currentIndex, NSString *title) {
                
                NHCustomAlertView *alert = [[NHCustomAlertView alloc] initWithTitle:@"暂不开放此功能，想了解更多，请前往作者简书。" cancel:nil sure:@"确定"];
                [alert showInView:self.view.window];
            }];
        }
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

- (NSMutableArray *)cellFrameArray {
    if (!_cellFrameArray) {
        _cellFrameArray = [NSMutableArray new];
    }
    return _cellFrameArray;
}

- (NHPersonalCenterSectionHeaderView *)sectionHeaderView {
    if (!_sectionHeaderView) {
        _sectionHeaderView = [NHPersonalCenterSectionHeaderView headerFooterViewWithTableView:self.tableView];
        _sectionHeaderView.delegate = self;
        [_sectionHeaderView clickDefault];
        return _sectionHeaderView;
    }
    return _sectionHeaderView;
}

- (NHPersonalCenterHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[NHPersonalCenterHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 280)];
        self.tableView.tableHeaderView = _headerView;
        _headerView.delegate = self;
    }
    return _headerView;
}

- (NHCustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        NHCustomCommonEmptyView *empty = [[NHCustomCommonEmptyView alloc] initWithTitle:@"" secondTitle:@"不会发段子的土豪不是好逗比" iconname:@"nosubmission"];
        [self.tableView addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.emptyView.frame = CGRectMake(0, 330, kScreenWidth, 150);
}

@end
