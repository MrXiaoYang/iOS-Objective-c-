//
//  NHDynamicDetailViewController.m
//  NeiHan
//
//  Created by Charles on 16/9/3.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHDynamicDetailViewController.h"
#import "NHDynamicDetailRequest.h"
#import "NHHomeServiceDataModel.h"
#import "NHDynamicDetailCommentCellFrame.h"
#import "NHHomeTableViewCell.h"
#import "NHHomeTableViewCellFrame.h"
#import "NHDynamicDetailCommentTableViewCell.h"
#import "NHDynamicDetailReportViewController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "NHBaseNavigationViewController.h"
#import "NHDiscoverSearchCommonCellFrame.h"
#import "NHDiscoverTopicViewController.h"
#import "NHPersonalCenterViewController.h"
#import "NHHomeNeiHanShareView.h"
#import "NHPersonalCenterViewController.h"
#import "NHNeiHanShareManager.h"
#import "NHHomeAttentionListSectionHeaderView.h"
#import "WMPlayer.h"


@interface NHDynamicDetailViewController () <NHHomeTableViewCellDelegate, NHDynamicDetailCommentTableViewCellDelegate, WMPlayerDelegate>
@property (nonatomic, strong) NHHomeTableViewCellFrame *cellFrame;
@property (nonatomic, strong) NHDiscoverSearchCommonCellFrame *searchCellFrame;
@property (nonatomic, strong) NSMutableArray *commentCellFrameArray;
@property (nonatomic, strong) NSMutableArray *topCommentCellFrameArray;
@property (nonatomic, strong) NSMutableArray *topDataArray;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) NHBaseImageView *imageView;
@property (nonatomic, assign) BOOL isSmallScreen;
@end

@implementation NHDynamicDetailViewController {
    WMPlayer *wmPlayer;
}

#pragma mark - 构造
- (instancetype)initWithSearchCellFrame:(NHDiscoverSearchCommonCellFrame *)searchCellFrame {
    if (self = [super init]) {
        self.searchCellFrame = searchCellFrame;
    }
    return self;
}

- (instancetype)initWithCellFrame:(NHHomeTableViewCellFrame *)cellFrame {
    if (self = [super init]) {
        self.cellFrame = cellFrame;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpItems];
    
    // 设置子视图
    [self setUpViews];
    
    // 请求数据
    [self loadData];
}

// 请求数据
- (void)loadData {
    
    // 加载动态内容
    if (self.cellFrame) {
        NHHomeTableViewCellFrame *cellFrame = [[NHHomeTableViewCellFrame alloc] init];
        [cellFrame setModel:self.cellFrame.model isDetail:YES];
        self.cellFrame = cellFrame;
        [self nh_reloadData];
    } else if (self.searchCellFrame) {
        // 将seachcellframe里面的group组装为element然后封装为tableviewcellframe
        NHHomeTableViewCellFrame *cellFrame = [[NHHomeTableViewCellFrame alloc] init];
        NHHomeServiceDataElement *element =[[NHHomeServiceDataElement alloc] init];
        element.group = self.searchCellFrame.group;
        [cellFrame setModel:element isDetail:YES];
        self.cellFrame = cellFrame;
        [self nh_reloadData];
    }
    
    // 评论
    NHDynamicDetailRequest *request = [NHDynamicDetailRequest nh_request];
    request.nh_url = kNHHomeDynamicCommentListAPI;
    if (self.cellFrame) {
        request.group_id = self.cellFrame.model.group.ID;
    } else {
        request.group_id = self.searchCellFrame.group.ID;
    }
    request.sort = @"hot";
    request.offset = 0;
    [request nh_sendRequestWithCompletion:^(id response, BOOL success, NSString *message) {
        if (success) {
            if ([response isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = (NSDictionary *)response;
                // 最近评论
                if ([dict.allKeys containsObject:@"recent_comments"]) {
                    self.dataArray = [NHHomeServiceDataElementComment modelArrayWithDictArray:response[@"recent_comments"]]; for (NHHomeServiceDataElementComment *comment in self.dataArray) {
                        NHDynamicDetailCommentCellFrame *cellFrame = [[NHDynamicDetailCommentCellFrame alloc] init];
                        cellFrame.commentModel = comment;
                        [self.commentCellFrameArray addObject:cellFrame];
                    }
                }
                // 热门评论
                if ([dict.allKeys containsObject:@"top_comments"]) {
                    self.topDataArray = [NHHomeServiceDataElementComment modelArrayWithDictArray:response[@"top_comments"]];
                    for (NHHomeServiceDataElementComment *comment in self.topDataArray) {
                        NHDynamicDetailCommentCellFrame *cellFrame = [[NHDynamicDetailCommentCellFrame alloc] init];
                        cellFrame.commentModel = comment;
                        [self.topCommentCellFrameArray addObject:cellFrame];
                    }
                }
            }
           
            [self nh_reloadData];
        }
    }];
  

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

- (void)requestActionWithActionname:(NSString *)actionname {
    
    NHHomeTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    // 指针不变，只需要更换值
    if ([actionname isEqualToString:@"digg"]) {
        if (self.cellFrame.model.group.user_digg) {
            return ;
        }
        self.cellFrame.model.group.user_digg = 1;
        self.cellFrame.model.group.digg_count += 1;
        [cell didDigg];
        
    } else if ([actionname isEqualToString:@"bury"]) {
        if (self.cellFrame.model.group.user_bury) {
            return ;
        }
        self.cellFrame.model.group.user_bury = 1;
        self.cellFrame.model.group.bury_count += 1;
        [cell didBury];
    } else if ([actionname isEqualToString:@"repin"]) { // 收藏
        self.cellFrame.model.group.user_repin = 1;
    } else if ([actionname isEqualToString:@"unrepin"]) { // 取消收藏
        self.cellFrame.model.group.user_repin = 0;
        
    }
}

// 设置导航栏
- (void)setUpItems {

    // 标题
    self.navItemTitle = @"详情";
    
    // 举报
    WeakSelf(weakSelf);
    [self nh_setUpNavRightItemTitle:@"举报" handle:^(NSString *rightItemTitle) {
        NHDynamicDetailReportViewController *report = [[NHDynamicDetailReportViewController alloc] init];
        NHBaseNavigationViewController *nav = [[NHBaseNavigationViewController alloc] initWithRootViewController:report];
        [weakSelf presentVc:nav];
    }];
}

// 设置子视图
- (void)setUpViews {
    self.needCellSepLine = YES;
    self.sepLineColor = kSeperatorColor;
}

#pragma mark - UITableViewDelegate
- (NSInteger)nh_numberOfSections {
    if (self.topDataArray.count) {
        return 3;
    }
    return 2;
}

- (NSInteger)nh_numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (self.topDataArray.count) {
        if (section == 1) {
            return self.topDataArray.count;
        } else if (section == 2) {
            return self.dataArray.count;
        }
    } else {
        if (section == 1) {
            return self.dataArray.count;
        }
    }
    return 0;
}

- (NHBaseTableViewCell *)nh_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        // 1. 创建cell
        NHHomeTableViewCell *cell = [NHHomeTableViewCell cellWithTableView:self.tableView];
        
        // 2. 设置数据
        [cell setCellFrame:self.cellFrame isDetail:YES];
        cell.delegate = self;
        
        // 3. 返回cell
        return cell;
    }
    
    // 三个section
    NHDynamicDetailCommentTableViewCell *cell = [NHDynamicDetailCommentTableViewCell cellWithTableView:self.tableView];
    cell.delegate = self;
    if (self.topDataArray.count) {
        if (indexPath.section == 1) {
            cell.cellFrame = self.topCommentCellFrameArray[indexPath.row];
        } else {
            cell.cellFrame = self.commentCellFrameArray[indexPath.row];
        }
    } else {
        if (indexPath.section == 1) {
            cell.cellFrame = self.commentCellFrameArray[indexPath.row];
        }
    }
    return cell;
}

- (CGFloat)nh_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.cellFrame.cellHeight;
    }
    if (self.topDataArray.count) {
        if (indexPath.section == 1) {
            NHDynamicDetailCommentCellFrame *cellFrame = self.topCommentCellFrameArray[indexPath.row];
            return cellFrame.cellHeight;
        } else if (indexPath.section == 2) {
            NHDynamicDetailCommentCellFrame *cellFrame = self.commentCellFrameArray[indexPath.row];
            return cellFrame.cellHeight;
        }
    } else {
        if (indexPath.section == 1) {
            NHDynamicDetailCommentCellFrame *cellFrame = self.commentCellFrameArray[indexPath.row];
            return cellFrame.cellHeight;
        }
    }
    return 0;
}

- (CGFloat)nh_sectionHeaderHeightAtSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
    return 40;
}

- (UIView *)nh_headerAtSection:(NSInteger)section {
    
    if (section == 0) {
        return [UIView new];
    }
    NHHomeAttentionListSectionHeaderView *headerView = [NHHomeAttentionListSectionHeaderView headerFooterViewWithTableView:self.tableView];
    headerView.tipL.backgroundColor = kWhiteColor;
    headerView.textColor = kCommonHighLightRedColor;
    if (self.topDataArray.count) {
        if (section == 1) {
            headerView.tipText = @"热门评论";
        } else if (section == 2) {
            headerView.tipText = @"新鲜评论";
        }
    } else {
        if (section == 1) {
            headerView.tipText = @"新鲜评论";
        }
    }
    return headerView;
}

#pragma mark - NHHomeTableViewCellDelegate
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

- (void)homeTableViewCellDidClickCategory:(NHHomeTableViewCell *)cell {
    NHHomeServiceDataElement *element = self.cellFrame.model;
    NHDiscoverTopicViewController *controller = [[NHDiscoverTopicViewController alloc] initWithCatogoryId:element.group.category_id];
    controller.navigationItem.title = element.group.category_name;
    [self pushVc:controller];
}

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

- (void)homeTableViewCell:(NHHomeTableViewCell *)cell didClickItemWithType:(NHHomeTableViewCellItemType)itemType {
    
    WeakSelf(weakSelf);
    switch (itemType) {
        case NHHomeTableViewCellItemTypeLike: {
            [self requestActionWithActionname:@"digg"];
        } break;
            
        case NHHomeTableViewCellItemTypeDontLike: {
            
            [self requestActionWithActionname:@"bury"];
        } break;
            
        case NHHomeTableViewCellItemTypeComment:
            
            break;
            
        case NHHomeTableViewCellItemTypeShare: {
            NHHomeNeiHanShareView *share = [NHHomeNeiHanShareView shareViewWithType:NHHomeNeiHanShareViewTypeShowCopyAndCollect hasRepinFlag:self.cellFrame.model.group.user_repin];
            [share showInView:self.view];
            [share setUpItemClickHandle:^(NHHomeNeiHanShareView *shareView, NSString *title, NSInteger index, NHNeiHanShareType shareType) {
                [[NHNeiHanShareManager sharedManager] shareWithSharedType:shareType image:nil url:@"www.baidu.com" content:@"不错" controller:weakSelf];
            }];
            WeakSelf(weakSelf);
            [share setUpBottomItemClickHandle:^(NHHomeNeiHanShareView *shareView, NSString *title, NSInteger index) {
                
                switch (index) {
                    case 0: {
                        NSString *shareUrl = weakSelf.cellFrame.model.group.share_url;
                        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                        pasteboard.string = shareUrl;
                        [MBProgressHUD showSuccess:@"已复制" toView:self.view];
                    } break;
                        
                    case 1: {
                        [weakSelf requestActionWithActionname:weakSelf.cellFrame.model.group.user_repin ? @"unrepin" : @"repin"];
                    } break;
                        
                    case 2: {
                        NHDynamicDetailReportViewController *controller = [[NHDynamicDetailReportViewController alloc] init];
                        NHBaseNavigationViewController *nav = [[NHBaseNavigationViewController alloc] initWithRootViewController:controller];
                        [weakSelf presentVc:nav];
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

- (void)homeTableViewCell:(NHHomeTableViewCell *)cell gotoPersonalCenterWithUserInfo:(NHNeiHanUserInfoModel *)userInfoModel {
    NHPersonalCenterViewController *controller = [[NHPersonalCenterViewController alloc] initWithUserInfoModel:userInfoModel];
    [self pushVc:controller];
}

#pragma mark - NHDynamicDetailCommentTableViewCellDelegate
- (void)commentTableViewCell:(NHDynamicDetailCommentTableViewCell *)commentCell didClickUserNameWithCommentModel:(NHHomeServiceDataElementComment *)comment {
    NHPersonalCenterViewController *personalCenter = [[NHPersonalCenterViewController alloc] initWithUserId:comment.user_id];
    [self pushVc:personalCenter];
}

- (NSMutableArray *)commentCellFrameArray {
    if (!_commentCellFrameArray) {
        _commentCellFrameArray = [NSMutableArray new];
    }
    return _commentCellFrameArray;
}

- (NSMutableArray *)topDataArray {
    if (!_topDataArray) {
        _topDataArray = [NSMutableArray new];
    }
    return _topDataArray;
}

- (NSMutableArray *)topCommentCellFrameArray {
    if (!_topCommentCellFrameArray) {
        _topCommentCellFrameArray = [NSMutableArray new];
    }
    return _topCommentCellFrameArray;
}
@end
